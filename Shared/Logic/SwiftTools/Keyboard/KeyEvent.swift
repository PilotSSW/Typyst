//
// Created by Sean Wolford on 2/14/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation

class KeyEvent {
    enum KeyDirection {
        case keyDown
        case keyUp
    }
    
    var key: Key
    var direction: KeyDirection
    var modifiers: ModifierFlags
    var isRepeat: Bool
    var timestamp: Date

    var timeSinceEvent: TimeInterval {
        timestamp.distance(to: Date())
//        let systemUptimeNow = ProcessInfo.processInfo.systemUptime
//        return Double(systemUptimeNow - timestamp)
    }

    init(_ key: Key, _ direction: KeyDirection, _ modifiers: ModifierFlags, isRepeat: Bool = false, timestamp: Date = Date()) {
        self.key = key
        self.isRepeat = isRepeat
        self.modifiers = modifiers
        self.timestamp = timestamp

        if (!KeyEvent.isFlagsChangedKey(key)) { self.direction = direction }
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
    var direction: KeyEvent.KeyDirection
    var isRepeat: Bool

    init(_ keyEvent: KeyEvent, isRepeat: Bool = false) {
        keySet = KeySets.keyIsOfKeySet(keyEvent.key)
        direction = keyEvent.direction
        self.isRepeat = isRepeat
    }
}

