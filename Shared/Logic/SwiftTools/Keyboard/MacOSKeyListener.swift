//
// Created by Sean Wolford on 2/6/20.
// Copyright (c) 2020 wickedPropeller. All rights reserved.
//

import AppKit
import Foundation

class MacOSKeyListener {
    enum KeyPressEnvironment {
        case all
        case global
        case local
    }

    internal static let instance = MacOSKeyListener()
    internal static let eventTypes: [NSEvent.EventTypeMask] = [.keyUp, .keyDown, .flagsChanged]
    internal static let modifiers: [NSEvent.ModifierFlags] = [.capsLock, .command, .control, .function, .help, .numericPad, .option, .shift]

    private var localKPCB = [String: ((KeyEvent) -> Void)]()
    private var globalKPCB = [String: ((KeyEvent) -> Void)]()

    private init() {
        listenForAllKeyPresses()
    }

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
    private static func determineKeyPressedFrom(_ event: NSEvent) -> KeyEvent? {
        let keyCode = event.keyCode
        let intVal = UInt32(exactly: keyCode) ?? 0
        if let keyPressed = Key(carbonKeyCode: intVal) {
            var isRepeat = false
            var direction: KeyEvent.KeyDirection = .keyDown
            if (event.type != .flagsChanged) {
                isRepeat = event.isARepeat
            }
            else {
                direction = event.type == .keyUp
                    ? .keyUp
                    : .keyDown
            }
            return KeyEvent(keyPressed, direction, ModifierFlags(event.modifierFlags), isRepeat: isRepeat)
        }

        return nil
    }

    private static func handleEvent(_ event: NSEvent, _ environment: KeyPressEnvironment) {
        if let keyEvent = determineKeyPressedFrom(event) {
            KeyHandler.handleEvent(keyEvent) { keyPressed in 
                // Handle key presses and send actions to rest of app
                if environment == .local {
                    instance.localKPCB.values.forEach { $0(keyPressed) }
                }
                else if environment == .global {
                    instance.globalKPCB.values.forEach({ $0(keyPressed) })
                }
            }
        }
    }
}

extension MacOSKeyListener {
    // Listen for key presses in Typyst
    private func listenForLocalKeyPresses() {
        for eventType in MacOSKeyListener.eventTypes {
            NSEvent.addLocalMonitorForEvents(matching: eventType) { (event) -> NSEvent in
                MacOSKeyListener.handleEvent(event, .local)
                return event
            }
        }
    }

    // Listen for key presses in other apps
    private func listenForGlobalKeyPresses() {
        for eventType in MacOSKeyListener.eventTypes {
            NSEvent.addGlobalMonitorForEvents(matching: eventType) { (event) in
                MacOSKeyListener.handleEvent(event, .global)
            }
        }
    }

    private func listenForAllKeyPresses() {
        listenForLocalKeyPresses()
        listenForGlobalKeyPresses()
    }
}

