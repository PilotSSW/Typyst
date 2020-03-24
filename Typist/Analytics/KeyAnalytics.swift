//
// Created by Sean Wolford on 3/4/20.
// Copyright (c) 2020 wickedPropeller. All rights reserved.
//

import Foundation
import HotKey

enum TimeAmount {
    case seconds
    case minutes
    case hours
    case days
}


class KeyAnalytics {
    typealias KeyEventByTime = (KeyEvent, Date)
    public static let shared: KeyAnalytics? = AppSettings.logUsageAnalytics ? KeyAnalytics() : nil

    public internal(set) var defaultAnalyticsIntervals: [Double] = [10, 20, 30, 45, 60]

    private var keypresses: [KeyEventByTime] = []

    private init() {

    }

    public func logEvent(_ event: KeyEvent) {
        keypresses.append((event, Date()))
    }

    public func keypressesInPast(_ seconds: Double) -> [KeyEventByTime] {
        let currentTime = Date()
        let startingTime = Date(timeInterval: -seconds, since: currentTime)

        return keypresses.filter({ $0.1 >= startingTime && $0.0.1 == .keyUp })
    }

    public func totalKeypressesInPastSeconds(_ seconds: Double) -> Int {
        keypressesInPast(seconds).count
    }

    public func averageKeypressesEveryXSecondsForPastSeconds(_ seconds: Double) -> Double {
        Double(keypressesInPast(seconds).count) / seconds
    }

    public func defaultAnalytics() -> [(Int, Double)] {
        defaultAnalyticsIntervals.map({ (totalKeypressesInPastSeconds($0), averageKeypressesEveryXSecondsForPastSeconds($0)) })
    }
}

class TimeHelper {
    struct TimeAmount {
        let days: Int
        let hours: Int
        let minutes: Int
        let seconds: Double
    }
    static func daysHoursMinutesSecondsFromTotalSeconds(_ totalSeconds: Double) -> TimeAmount {
        var seconds = totalSeconds
        let days = Int(seconds / 86400)
        seconds = seconds.truncatingRemainder(dividingBy: 86400)
        let hours = Int(seconds) / 3600
        seconds = seconds.truncatingRemainder(dividingBy: 3600)
        let minutes = Int(seconds) / 60
        seconds = seconds.truncatingRemainder(dividingBy: 60)

        return TimeAmount(days: days, hours: hours, minutes: minutes, seconds: seconds)
    }
}