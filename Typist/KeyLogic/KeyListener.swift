//
// Created by Sean Wolford on 2/6/20.
// Copyright (c) 2020 wickedPropeller. All rights reserved.
//

import Foundation
import HotKey

typealias KeyEvent = (Key, NSEvent.EventType)
class KeyListener {
    static let instance = KeyListener()
    static let eventTypes: [NSEvent.EventTypeMask] = [.keyUp, .keyDown, .flagsChanged]

    var keyListeners = [Any]()

    private init(){

    }

    deinit {
        keyListeners.removeAll()
    }

    static func determineKeyPressedFrom(_ event: NSEvent) -> KeyEvent?{
        let keyCode = event.keyCode
        let intVal = UInt32(exactly: keyCode) ?? 0
        if let keyPressed = Key(carbonKeyCode: intVal) {
            return (keyPressed, event.type)
        }
        
        return nil
    }

    // Listen for key presses in Typist
    func listenForLocalKeyPresses(completion: ((KeyEvent) -> ())?) {
        for eventType in KeyListener.eventTypes {
            self.keyListeners.append(
            NSEvent.addLocalMonitorForEvents(matching: eventType) { (event) -> NSEvent in
                if let keyPressed = KeyListener.determineKeyPressedFrom(event) {
                    completion?(keyPressed)
                }

                return event
            } as Any)
        }
    }

    // Listen for key presses in other apps
    func listenForGlobalKeyPresses(completion: ((KeyEvent) -> ())?) {
        for eventType in KeyListener.eventTypes {
            self.keyListeners.append(
            NSEvent.addGlobalMonitorForEvents(matching: eventType) { (event) in
                if let keyPressed = KeyListener.determineKeyPressedFrom(event) {
                    if App.instance.debug {
                        NSLog("Key press detected: \(keyPressed)")
                    }
                    completion?(keyPressed)
                }
            } as Any)
        }
    }

    func listenForAllKeyPresses(completion: (((Key, NSEvent.EventType)) -> ())?) {
        listenForLocalKeyPresses(completion: completion)
        listenForGlobalKeyPresses(completion: completion)
    }
}

