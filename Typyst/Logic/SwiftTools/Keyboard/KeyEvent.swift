//
// Created by Sean Wolford on 2/14/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import HotKey

class KeyEvent {
    var key: Key
    var direction: NSEvent.EventType
    var isRepeat: Bool

    init(_ key: Key, _ direction: NSEvent.EventType, _ modifiers: NSEvent.ModifierFlags, isRepeat: Bool = false) {
        self.key = key
        self.isRepeat = isRepeat

        if (!KeyEvent.isFlagsChangedKey(key)) {
            self.direction = direction
        }
        else {
            if (modifiers.rawValue == 256) {
                self.direction = .keyUp
            }
            else {
                self.direction = .keyDown
            }
        }
    }   

    func asAnonymousKeyEvent() -> AnonymousKeyEvent {
        AnonymousKeyEvent(self)
    }

    static func isFlagsChangedKey(_ key: Key) -> Bool {
        switch(key) {
            case .command, .rightCommand, .control, .rightControl, .function,
                 .help, .option, .rightOption, .shift, .rightShift:
                return true
            default:
                return false
        }
    }
}

class AnonymousKeyEvent {
    var keySet: KeySets.KeySetType?
    var direction: NSEvent.EventType
    var isRepeat: Bool

    init(_ keyEvent: KeyEvent, isRepeat: Bool = false) {
        keySet = KeySets.keyIsOfKeySet(keyEvent.key)
        direction = keyEvent.direction
        self.isRepeat = isRepeat
    }
}
