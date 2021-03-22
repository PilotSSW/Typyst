//
// Created by Sean Wolford on 3/20/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation

class TimeHelper {
    struct TimeAmount {
        let days: Int
        let hours: Int
        let minutes: Int
        let seconds: Double

        enum TimeAmount {
            case seconds
            case minutes
            case hours
            case days
        }
    }

    static func daysHoursMinutesSecondsFromTotalSeconds(_ totalSeconds: Double) -> TimeAmount {
        var remainingSeconds = totalSeconds
        var days = 0, hours = 0, minutes = 0

        if (remainingSeconds >= 86400) {
            days = Int(remainingSeconds / 86400)
            remainingSeconds = remainingSeconds.truncatingRemainder(dividingBy: 86400)
        }

        if (remainingSeconds >= 3600) {
            hours = Int(remainingSeconds / 3600)
            remainingSeconds = remainingSeconds.truncatingRemainder(dividingBy: 3600)
        }

        if (remainingSeconds >= 60) {
            minutes = Int(remainingSeconds / 60)
            remainingSeconds = remainingSeconds.truncatingRemainder(dividingBy: 60)
        }

        return TimeAmount(days: days, hours: hours, minutes: minutes, seconds: remainingSeconds)
    }
}