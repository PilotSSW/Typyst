//
// Created by Sean Wolford on 3/19/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Combine
import Foundation

class AnalyticsInfoCardViewModel: ObservableObject {
    enum State {
        case logging
        case inactive
    }
    @Published private(set) var state: State = .inactive

    private(set) var analyticsStartTime: Date?
    private(set) var currentAnalyticsIntervals = [Double]()
    @Published private(set) var analyticsInfoItems = [AnalyticsInfoViewModel]()

    private let timerPub = Timer
        .publish(every: 0.99, tolerance: 1.0, on: .main, in: .common)
    private var timer: Cancellable?

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

    private func updateItems() {
        let timeRunning = abs(analyticsStartTime?.timeIntervalSinceNow ?? 0)
        let timeIntervals = getAnalyticsIntervalsForTimeRunning(timeRunning)

        if (timeIntervals.count > analyticsInfoItems.count) {
            let index = analyticsInfoItems.count > 1
                ? timeIntervals.count - 2
                : 0
            let item = AnalyticsInfoViewModel(timeElapsed: timeIntervals[index])
            analyticsInfoItems.append(item)
        }

        for (index, timePeriod) in timeIntervals.enumerated() {
            if let item = analyticsInfoItems[safe: index] {
                item.update(timeElapsed: timePeriod)
            }
        }
    }

    func startTimer() {
        if state == .logging { return }

        analyticsInfoItems.removeAll()
        analyticsStartTime = Date()
        updateItems()
        timerPub.sink { [weak self] _ in
            guard let self = self else { return }
            self.updateItems()
        }
        .store(in: &AppCore.instance.subscriptions)
        timer = timerPub.connect()
        state = .logging
    }

    func stopTimer() {
        if state == .inactive { return }

        timer?.cancel()
        updateItems()

        state = .inactive
    }

    func reset() {
        TypingStats.shared.reset()
        analyticsStartTime = Date()
        updateItems()
    }
}
