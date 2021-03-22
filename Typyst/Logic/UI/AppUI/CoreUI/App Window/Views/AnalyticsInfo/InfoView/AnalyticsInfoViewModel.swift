//
// Created by Sean Wolford on 3/19/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation

class AnalyticsInfoViewModel: ObservableObject {
    enum State {
        case logging
        case inactive
    }
    private(set) var state: State = .inactive

    private(set) var currentAnalyticsIntervals: [Double] = [Double]()
    private var analyticsStartTime: Date?

    @Published var analyticsInfoItems: [AnalyticsInfo] = [AnalyticsInfo]() {
        didSet { analyticsInfoUpdated?(analyticsInfoItems) }
    }
    var analyticsInfoUpdated: (([AnalyticsInfo]) -> Void)? = nil

    let timer = RepeatingTimer(timeInterval: 0.2)

    init() {}

    deinit {
        stopTimer()
    }

    private func getAnalyticsIntervalsForTimeRunning(_ totalUptime: Double) -> [Double] {
        switch(totalUptime) {
        case 0...60: return [totalUptime]
        case 60...300: return [60, totalUptime]
        case 300...900: return [60, 300, totalUptime]
        case 900...3600: return [60, 300, 900, totalUptime]
        case 3600...86400: return [60, 300, 900, 3600, totalUptime]
        default: return [60, 300, 900, 3600, 86400]
        }
    }

    private func pushNewAnalyticsInfoItems() {
        let timeRunning = abs(analyticsStartTime?.timeIntervalSinceNow ?? 0)
        let timeIntervals = getAnalyticsIntervalsForTimeRunning(timeRunning)

        for (index, timePeriod) in timeIntervals.enumerated() {
            if var item = analyticsInfoItems[safe: index] {
                item.timeStamp = Date().timeIntervalSinceReferenceDate
                item.amountOfTime = timePeriod
                item.totalKeyPresses = KeyAnalytics.shared.totalKeypressesInPastSeconds(timePeriod)
                item.averageKeyPresses = KeyAnalytics.shared.averageKeypressesEveryXSecondsForPastSeconds(timePeriod)
            }
            else {
                let analyticsInfo = AnalyticsInfo(timeStamp: Date().timeIntervalSinceReferenceDate,
                                                  amountOfTime: timePeriod,
                                                  totalKeyPresses: KeyAnalytics.shared.totalKeypressesInPastSeconds(timePeriod),
                                                  averageKeyPresses: KeyAnalytics.shared.averageKeypressesEveryXSecondsForPastSeconds(timePeriod))
                analyticsInfoItems.append(analyticsInfo)
            }
        }
    }

    func startTimer() {
        if state == .logging { return }

        analyticsStartTime = Date()
        timer.eventHandler = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.pushNewAnalyticsInfoItems()
            }
        }
        timer.resume()
        state = .logging
    }

    func stopTimer() {
        if state == .inactive { return }

        timer.suspend()
        state = .inactive
    }

    func reset() {
        KeyAnalytics.shared.reset()
        analyticsStartTime = Date()
    }
}

class AnalyticsInfo: ObservableObject {
    @Published var timeStamp: TimeInterval
    @Published var amountOfTime: Double
    @Published var totalKeyPresses: Int
    @Published var averageKeyPresses: Double

    init(timeStamp: TimeInterval, amountOfTime: Double, totalKeyPresses: Int, averageKeyPresses: Double) {
        self.timeStamp = timeStamp
        self.amountOfTime = amountOfTime
        self.totalKeyPresses = totalKeyPresses
        self.averageKeyPresses = averageKeyPresses
    }

    func getAsTextBody() -> AnalyticsInfoTextBody {
        let time = TimeHelper.daysHoursMinutesSecondsFromTotalSeconds(amountOfTime)

        var secondsString: String = ""
        let secondsElapsed = Int(time.seconds)
        if secondsElapsed == 1 { secondsString = "\(secondsElapsed) second" }
        else if time.seconds > 1 { secondsString = "\(secondsElapsed) seconds" }

        var minutesString: String = ""
        if time.minutes == 1 { minutesString = "\(time.minutes) minute" }
        else if time.minutes > 1 { minutesString = "\(Int(time.minutes)) minutes" }
        if (!minutesString.isEmpty && !secondsString.isEmpty) { minutesString += ": " }

        var hoursString: String =  ""
        if time.hours == 1 { hoursString = "\(time.hours) hour" }
        else if time.hours > 1 { hoursString = "\(Int(time.hours)) hours" }
        if (!hoursString.isEmpty && !minutesString.isEmpty) { hoursString += ": " }

        var daysString: String = ""
        if time.days == 1 { daysString = "\(time.days) day" }
        else if time.days > 1 { daysString = "\(Int(time.days)) days" }
        if (!daysString.isEmpty && !hoursString.isEmpty) { daysString += ": " }

        let totalUptimeText = "\(daysString)\(hoursString)\(minutesString)\(secondsString)"

        return AnalyticsInfoTextBody(
            totalUptimeText: totalUptimeText,
            totalKeyPressesText: "\(totalKeyPresses) total key presses",
            averageKeyPressesText: "\(averageKeyPresses.rounded(digits: 3)) key presses per second")
    }
}

struct AnalyticsInfoTextBody {
    let totalUptimeText: String
    let totalKeyPressesText: String
    let averageKeyPressesText: String
}
