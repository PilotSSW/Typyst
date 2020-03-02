//
// Created by Sean Wolford on 2/19/20.
// Copyright (c) 2020 wickedPropeller. All rights reserved.
//

import Foundation
import AppKit

extension NSEvent {
    var timeSinceEvent: Double {
        let systemUptimeNow = ProcessInfo.processInfo.systemUptime
        return Double(systemUptimeNow - self.timestamp)
    }
}
