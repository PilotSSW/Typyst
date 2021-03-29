//
// Created by Sean Wolford on 3/26/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Combine
import Foundation

class AnalyticsInfoViewModel: ObservableObject {
    var keyListenerCompletion: ((KeyEvent) -> Void)?
    @Published var timeElapsed: Double
    @Published var totalKeyPresses: Int
    @Published var averageKeyPressesPerMinute: Double
    @Published var averageKeyPressesPerSecond: Double

    lazy var textBody: AnalyticsInfoTextBody = {
        AnalyticsInfoTextBody(with: self)
    }()

    init(timeElapsed: Double,
         totalKeyPresses: Int = 0,
         averageKeyPressesPerMinute: Double = 0,
         averageKeyPressesPerSecond: Double = 0) {
        self.timeElapsed = timeElapsed
        self.totalKeyPresses = totalKeyPresses
        self.averageKeyPressesPerMinute = averageKeyPressesPerMinute
        self.averageKeyPressesPerSecond = averageKeyPressesPerSecond

        keyListenerCompletion = { [weak self] keyEvent in
            guard let self = self else { return }
            if (keyEvent.direction == .keyDown) {
                self.totalKeyPresses += 1
            }
        }
        KeyListener.instance.listenForAllKeyPresses(completion: keyListenerCompletion)
    }

    func update(timeElapsed: Double) {
        self.timeElapsed = timeElapsed

        let keyEvents = TypingStats.shared.keypressesInThePast(self.timeElapsed)
        totalKeyPresses = TypingStats.shared.total(keyEvents)
        averageKeyPressesPerSecond = TypingStats.shared.average(total: totalKeyPresses, over: timeElapsed)
        averageKeyPressesPerMinute = averageKeyPressesPerSecond * 60
    }
}

struct AnalyticsInfoTextBody {
    var viewModel: AnalyticsInfoViewModel

    var totalUptimeText: String { getTotalUptimeText() }
    var totalKeyPressesText: String { "\(viewModel.totalKeyPresses) total key presses" }
    var averageKeyPressesPerMinuteText: String { "\(viewModel.averageKeyPressesPerMinute.rounded(digits: 3)) key presses per minute" }
    var averageKeyPressesPerSecondText: String { "\(viewModel.averageKeyPressesPerSecond.rounded(digits: 3)) key presses per second" }

    init(with viewModel: AnalyticsInfoViewModel) {
        self.viewModel = viewModel
    }

    private func getTotalUptimeText() -> String {
        let time = TimeHelper.daysHoursMinutesSecondsFromTotalSeconds(viewModel.timeElapsed)

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

        return "\(daysString)\(hoursString)\(minutesString)\(secondsString)"
    }
}
