//
// Created by Sean Wolford on 2/6/20.
// Copyright (c) 2020 wickedPropeller. All rights reserved.
//

import AppKit
import Foundation

final class MacOSKeyListener {
    enum KeyPressEnvironment {
        case all
        case global
        case local
    }
    internal var keyPressEnvironment: KeyPressEnvironment = .all

    internal static let eventTypes: [NSEvent.EventTypeMask] = [.keyUp, .keyDown, .flagsChanged]
    internal static let modifiers: [NSEvent.ModifierFlags] = [.capsLock, .command, .control, .function, .help, .numericPad, .option, .shift]

    private var keyHandler: KeyHandler? = nil

    private var localKPCB = [String: ((KeyEvent) -> Void)]()
    private var globalKPCB = [String: ((KeyEvent) -> Void)]()

    deinit {
        localKPCB.removeAll()
        globalKPCB.removeAll()
    }

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

// MARK: Logic for determining and handling keypresses
extension MacOSKeyListener {
    public func setKeyHandler(_ keyHandler: KeyHandler) {
        self.keyHandler = keyHandler
    }

    public func removeKeyHandler() {
        keyHandler = nil
    }

    private func determineKeyPressedFrom(_ event: NSEvent) -> KeyEvent? {
        let keyCode = event.keyCode
        let intVal = UInt32(exactly: keyCode) ?? 0
        if let keyPressed = Key(carbonKeyCode: intVal) {
            var direction: KeyEvent.KeyDirection = .keyDown
            var isRepeat = false

            if (event.type != .flagsChanged) {
                isRepeat = event.isARepeat
                direction = event.type == .keyUp
                    ? .keyUp
                    : .keyDown
            }

            return KeyEvent(keyPressed,
                            direction,
                            ModifierFlags(event.modifierFlags),
                            isRepeat: isRepeat)
        }

        return nil
    }

    private func handleEvent(_ event: NSEvent, _ environment: KeyPressEnvironment) {
        if let keyEvent = determineKeyPressedFrom(event) {
            keyHandler?.handleEvent(keyEvent) { [weak self] keyPressed in
                guard let self = self else { return }
                // Handle key presses and send actions to rest of app
                if environment == .local && (self.keyPressEnvironment == .local || self.keyPressEnvironment == .all) {
                    self.localKPCB.values.forEach { $0(keyPressed) }
                }
                else if environment == .global && (self.keyPressEnvironment == .global || self.keyPressEnvironment == .all) {
                    self.globalKPCB.values.forEach({ $0(keyPressed) })
                }
            }
        }
    }
}

extension MacOSKeyListener {
    // Listen for key presses in Typyst
    private func listenForLocalKeyPresses() {
        for eventType in MacOSKeyListener.eventTypes {
            NSEvent.addLocalMonitorForEvents(matching: eventType) { [weak self] (event) -> NSEvent in
                self?.handleEvent(event, .local)
                return event
            }
        }
    }

    // Listen for key presses in other apps
    private func listenForGlobalKeyPresses() {
        for eventType in MacOSKeyListener.eventTypes {
            NSEvent.addGlobalMonitorForEvents(matching: eventType) { [weak self] (event) in
                self?.handleEvent(event, .global)
            }
        }
    }

    internal func listenForAllKeyPresses() {
        listenForLocalKeyPresses()
        listenForGlobalKeyPresses()
    }
}

