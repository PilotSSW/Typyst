//
// Created by Sean Wolford on 2/14/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation

// MARK: Protocol/implementation meant as common base type to extend for different types to use in app.

protocol HashableKeyEvent: Hashable {
    var timeStamp: Date { get set }
    var keySet: KeySets.KeySetType? { get set }
    var direction: KeyEvent.KeyDirection { get set }
    var isRepeat: Bool { get set }
}

extension HashableKeyEvent {
    func hash(into hasher: inout Hasher) {
        hasher.combine(timeStamp)
        hasher.combine(keySet?.hashValue)
        hasher.combine(direction.hashValue)
        hasher.combine(isRepeat.hashValue)
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.hashValue == rhs.hashValue
    }

    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.keySet.hashValue < rhs.keySet.hashValue ||
        lhs.direction.hashValue < rhs.direction.hashValue ||
        lhs.isRepeat.hashValue < rhs.isRepeat.hashValue
    }
}


// Mark: KeyEvents meant for use in App

struct AnonymousKeyEvent: HashableKeyEvent {
    var keySet: KeySets.KeySetType?
    var direction: KeyEvent.KeyDirection
    var isRepeat: Bool
    var timeStamp: Date

    init(_ keyEvent: KeyEvent, isRepeat: Bool = false) {
        keySet = keyEvent.keySet
        direction = keyEvent.direction
        timeStamp = keyEvent.timeStamp
        self.isRepeat = isRepeat
    }
}

struct KeyEvent: HashableKeyEvent {
    var keySet: KeySets.KeySetType?

    enum KeyDirection {
        case keyDown
        case keyUp
    }
    
    var key: Key
    var direction: KeyDirection
    var modifiers: ModifierFlags
    var isRepeat: Bool
    var timeStamp: Date

    var timeSinceEvent: TimeInterval {
        timeStamp.distance(to: Date())
//        let systemUptimeNow = ProcessInfo.processInfo.systemUptime
//        return Double(systemUptimeNow - timestamp)
    }

    init(_ key: Key, _ direction: KeyDirection, _ modifiers: ModifierFlags, isRepeat: Bool = false, timeStamp: Date = Date()) {
        self.key = key
        self.keySet = KeySets.keyIsOfKeySet(key)
        self.isRepeat = isRepeat
        self.modifiers = modifiers
        self.timeStamp = timeStamp

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

