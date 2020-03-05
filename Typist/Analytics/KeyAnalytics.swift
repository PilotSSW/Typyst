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

    private var keypresses: [KeyEventByTime] = []

    private init() {

    }

    public func logEvent(_ event: KeyEvent) {
        keypresses.append((event, Date()))
    }

    public func keypressesInPast(_ seconds: Double) -> [KeyEventByTime] {
        let currentTime = Date()
        let startingTime = Date(timeInterval: -seconds, since: currentTime)

        return keypresses.filter({ $0.1 >= startingTime })
    }

    public func totalKeypressesInPastSeconds(_ seconds: Double) -> Int {
        keypressesInPast(seconds).count
    }

    public func averageKeypressesEveryXSecondsForPastSeconds(_ seconds: Double) -> Double {
        Double(keypressesInPast(seconds).count) / seconds
    }

    public func defaultAnalytics() -> [(Int, Double)] {
        let analytics = [
            (totalKeypressesInPastSeconds(60), averageKeypressesEveryXSecondsForPastSeconds(60)),
            (totalKeypressesInPastSeconds(300), averageKeypressesEveryXSecondsForPastSeconds(300)),
            (totalKeypressesInPastSeconds(600), averageKeypressesEveryXSecondsForPastSeconds(600)),
            (totalKeypressesInPastSeconds(1800), averageKeypressesEveryXSecondsForPastSeconds(1800)),
            (totalKeypressesInPastSeconds(3600), averageKeypressesEveryXSecondsForPastSeconds(3600))
        ]

        return analytics
    }
}