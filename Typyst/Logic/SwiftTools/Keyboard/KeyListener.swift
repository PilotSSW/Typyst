//
// Created by Sean Wolford on 2/6/20.
// Copyright (c) 2020 wickedPropeller. All rights reserved.
//

import Foundation
import HotKey


class KeyListener {
    internal static let instance = KeyListener()
    internal static let eventTypes: [NSEvent.EventTypeMask] = [.keyUp, .keyDown, .flagsChanged]
    internal static let modifiers: [NSEvent.ModifierFlags] = [.capsLock, .command, .control, .function, .help, .numericPad, .option, .shift]

    private var keyListeners = [Any]()

    private init() {

    }

    deinit {
        keyListeners.removeAll()
    }

    internal static func determineKeyPressedFrom(_ event: NSEvent) -> KeyEvent? {
        let keyCode = event.keyCode
        let intVal = UInt32(exactly: keyCode) ?? 0
        if let keyPressed = Key(carbonKeyCode: intVal) {
            return KeyEvent(keyPressed, event.type, event.modifierFlags)
        }
        
        return nil
    }

    // Listen for key presses in Typyst
    internal func listenForLocalKeyPresses(completion: ((KeyEvent) -> ())?) {
        for eventType in KeyListener.eventTypes {
            keyListeners.append(
            NSEvent.addLocalMonitorForEvents(matching: eventType) { (event) -> NSEvent in
                if let keyPressed = KeyListener.determineKeyPressedFrom(event) {
                    completion?(keyPressed)
                }

                return event
            } as Any)
        }
    }

    // Listen for key presses in other apps
    internal func listenForGlobalKeyPresses(completion: ((KeyEvent) -> ())?) {
        for eventType in KeyListener.eventTypes {
            keyListeners.append(
            NSEvent.addGlobalMonitorForEvents(matching: eventType) { (event) in
                if event.timeSinceEvent <= 0.75,
                   let keyPressed = KeyListener.determineKeyPressedFrom(event) {
                    let debugSettings = AppDebugSettings.shared
                    if debugSettings.debugKeypresses && debugSettings.debugKeypresses {
                        NSLog("Key: \(keyPressed.key) - \(keyPressed.direction)")
                    }
                    completion?(keyPressed)
                }

            } as Any)
        }
    }

    internal func listenForAllKeyPresses(completion: ((KeyEvent) -> ())?) {
        listenForLocalKeyPresses(completion: completion)
        listenForGlobalKeyPresses(completion: completion)
    }

    internal func removeAll() {
        keyListeners.removeAll()
    }
}

