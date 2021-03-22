//
// Created by Sean Wolford on 2/14/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import HotKey

class KeyEvent {
    var key: Key
    var direction: NSEvent.EventType

    init(_ key: Key, _ direction: NSEvent.EventType) {
        self.key = key
        self.direction = direction
    }

    func asAnonymousKeyEvent() -> AnonymousKeyEvent {
        AnonymousKeyEvent(self)
    }
}

class AnonymousKeyEvent {
    var keySet: KeySets.KeySetType?
    var direction: NSEvent.EventType

    init(_ keyEvent: KeyEvent) {
        keySet = KeySets.keyIsOfKeySet(keyEvent.key)
        direction = keyEvent.direction
    }
}