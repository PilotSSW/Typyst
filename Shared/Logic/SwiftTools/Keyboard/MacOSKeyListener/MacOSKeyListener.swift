//
// Created by Sean Wolford on 2/6/20.
// Copyright (c) 2020 wickedPropeller. All rights reserved.
//

import AppKit
import Foundation

final class MacOSKeyListener: Loggable {
    private let nsEventListener = NSEventListener()

    enum State {
        case listening
        case idle
    }
    private(set) internal var state: State = .idle

    enum KeyPressEnvironment {
        case all
        case global
        case local
    }
    private(set) internal var keyPressEnvironment: KeyPressEnvironment = .local {
        didSet {
            if state == .listening {
                stop()
                start()
            }
        }
    }

    private var localKPCB = [String: ((KeyEvent) -> Void)]()
    private var globalKPCB = [String: ((KeyEvent) -> Void)]()

    private var modifierStates: [Key: KeyEvent.KeyDirection] = [:]

    init(shouldAutoRun: Bool = true) {
        modifierStates = [.capsLock, .command, .rightCommand, .control, .rightControl, .function, .help, .option, .rightOption, .shift,. rightShift].reduce(into: [:], { dictionary, modifierFlag in
            dictionary[modifierFlag] = .keyUp
        })
        if shouldAutoRun { start() }
    }

    deinit {
        localKPCB.removeAll()
        globalKPCB.removeAll()
    }

    func start() {
        if state == .listening { return }

        if keyPressEnvironment == .all || keyPressEnvironment == .local {
            nsEventListener.listenForLocalKeyPresses(onKeyPress: { [weak self] event in
                guard let self = self else { return }
                self.handleEvent(event, .local)
            })
        }
        if keyPressEnvironment == .all || keyPressEnvironment == .global {
            nsEventListener.listenForGlobalKeyPresses(onKeyPress: { [weak self] event in
                guard let self = self else { return }
                self.handleEvent(event, .global)
            })
        }

        state = .listening
    }

    func stop() {
        if state == .idle { return }
        nsEventListener.removeKeyListeners()
        state = .idle
    }

    func setKeyListenerEnvironment(_ environment: KeyPressEnvironment) {
        keyPressEnvironment = environment
    }
}

/// Mark: Register key listeners
extension MacOSKeyListener {
    internal func registerLocalKeyPressCallback(withTag tag: String, completion: @escaping (KeyEvent) -> Void) -> Bool {
        if localKPCB[tag] != nil { return false }
        localKPCB[tag] = completion
        return true
    }

    internal func registerGlobalKeyPressCallback(withTag tag: String, completion: @escaping (KeyEvent) -> Void) -> Bool {
        if globalKPCB[tag] != nil { return false }
        globalKPCB[tag] = completion
        return true
    }

    internal func registerKeyPressCallback(withTag tag: String, completion: @escaping (KeyEvent) -> Void) -> Bool {
        let val1 = registerLocalKeyPressCallback(withTag: tag, completion: completion)
        let val2 = registerGlobalKeyPressCallback(withTag: tag, completion: completion)
        return val1 && val2
    }

    internal func removeListenerCallback(withTag tag: String) -> Bool {
        let val1 = localKPCB.removeValue(forKey: tag)
        let val2 = globalKPCB.removeValue(forKey: tag)
        return val1 != nil && val2 != nil
    }
}

/// MARK: Logic for determining and handling keypresses
extension MacOSKeyListener {
    private func setModifierKeyState(_ keyPressed: Key,
                                     forceKeyDirection keyDirection: KeyEvent.KeyDirection? = nil,
                                     event: NSEvent? = nil) -> KeyEvent.KeyDirection {
        var direction: KeyEvent.KeyDirection

        if let currentModifierState = modifierStates[keyPressed] {
            let newModifierState: KeyEvent.KeyDirection = keyDirection ?? currentModifierState == .keyUp ? .keyDown : .keyUp
            modifierStates[keyPressed] = newModifierState
            direction = newModifierState
        }
        // Case: Unrecognized modifier flag
        else {
            logEvent(.warning, "Unrecognized modifier flag \nKeyPress:\(keyPressed)\nEvent:\(String(describing: event))")
            direction = .unknown
        }

        return direction
    }

    private func mapNSEventAndKeyCodeToKeyEvent(_ event: NSEvent, _ keyPressed: Key) -> KeyEvent? {
        var direction: KeyEvent.KeyDirection
        var isRepeat: Bool

        // Case: Modifier Keys
        if (modifierStates.keys.contains(keyPressed)) {//event.type == .flagsChanged) {
            let keyDirection: KeyEvent.KeyDirection = event.modifierFlags.carbonFlags > 0 ? .keyUp : .keyDown
            direction = setModifierKeyState(keyPressed, forceKeyDirection: keyDirection, event: event)
            isRepeat = false
//            logEvent(.trace, "Flags changed \(keyPressed)")
        }
        // Case: All other keys
        else {
            isRepeat = event.type == .flagsChanged ? false : event.isARepeat
            switch(event.type) {
                case .keyUp: direction = .keyUp
                case .keyDown: direction = .keyDown
                default: direction = .unknown
            }
        }

        return KeyEvent(keyPressed,
                        direction,
                        ModifierFlags(event.modifierFlags),
                        isRepeat: isRepeat)
    }

    private func determineKeyPressedFrom(_ event: NSEvent) -> KeyEvent? {
        let keyCode = event.keyCode
        let intVal = UInt32(exactly: keyCode) ?? 0
        if let keyPressed = Key(carbonKeyCode: intVal) {
            return mapNSEventAndKeyCodeToKeyEvent(event, keyPressed)
        }

        return nil
    }

    private func handleEvent(
            _ event: NSEvent,
            _ environment: KeyPressEnvironment) {
        if let keyEvent = determineKeyPressedFrom(event) {
            // Handle key presses and send actions to rest of app
            let acceptLocalEvents = keyPressEnvironment == .local || keyPressEnvironment == .all
            let acceptExternalEvents = keyPressEnvironment == .global || keyPressEnvironment == .all

            // Run any local registered completion handlers
            if environment == .local && acceptLocalEvents {
                localKPCB.values.forEach { $0(keyEvent) }
            }
            else if environment == .global && acceptExternalEvents {
                globalKPCB.values.forEach({ $0(keyEvent) })
            }
        }
    }
}

extension NSEvent.ModifierFlags: Hashable {

}
