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
}