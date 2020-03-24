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

    public internal(set) var currentAnalyticsIntervals: [Double] = KeyAnalytics.getAnalyticsIntervalsForTimeRunning(0)
    private let timer: RepeatingTimer

    private var keypresses: [KeyEventByTime] = []

    private init() {
        self.timer = RepeatingTimer(timeInterval: 60)
        timer.eventHandler = { [weak self] in
            self?.currentAnalyticsIntervals = KeyAnalytics.getAnalyticsIntervalsForTimeRunning(abs(startTime.timeIntervalSinceNow))
        }
        timer.resume()
    }

    deinit {
        timer.suspend()
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
        currentAnalyticsIntervals.map({ (totalKeypressesInPastSeconds($0), averageKeypressesEveryXSecondsForPastSeconds($0)) })
    }

    static private func getAnalyticsIntervalsForTimeRunning(_ totalUptime: Double) -> [Double] {
        switch totalUptime {
        case 0...120: return [5, 15, 30, 45, 60]
        case 120...300: return [15, 30, 60, 90, 120]
        case 300...600: return [15, 30, 60, 150, 300]
        case 600...1800: return [15, 60, 120, 300, 600]
        case 1800...3600: return [15, 60, 300, 600, 1800]
        case 3600...14400: return [15, 60, 300, 600, 3600]
        case 14400...86400: return [15, 60, 600, 3600, 14400]
        case let x where x > 86400: return [15, 60, 600, 3600, 7200, 86400]
        default: return []
        }
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