//
// Created by Sean Wolford on 3/4/20.
// Copyright (c) 2020 wickedPropeller. All rights reserved.
//

import Combine
import Foundation
import HotKey

class KeyAnalytics {
    enum State {
        case logging
        case inactive
    }
    public private(set) var state: State = .inactive
    public static let shared: KeyAnalytics = KeyAnalytics()

    private typealias KeyEventByTime = (AnonymousKeyEvent, Date)
    private var keyPresses: [KeyEventByTime] = []
    private var keyListenerCallback: (KeyEvent) -> Void

    private var timerInterval: TimeInterval = 600
    private var removeOldKeyEventsTimer: RepeatingTimer? {
        didSet {
            removeOldKeyEventsTimer?.eventHandler = { [weak self] in
                guard let self = self else { return }
                self.keyPresses.removeAll(where: { abs($0.1.timeIntervalSinceNow) > 86400 })
            }
        }
    }

    private init() {
        keyListenerCallback = { (keyEvent) in
            KeyAnalytics.shared.logEvent(keyEvent)
        }
        KeyListener.instance.listenForAllKeyPresses(completion: keyListenerCallback)

        if (AppSettings.shared.logUsageAnalytics) { startTracking() }
        AppSettings.shared.$logUsageAnalytics
            .sink { [weak self] in
                guard let self = self else { return }
                $0 ? self.startTracking() : self.stopTracking()
            }
            .store(in: &App.instance.subscriptions)
    }

    deinit {
        stopTracking()
    }

    func logEvent(_ event: KeyEvent) {
        if (state == .logging && AppSettings.shared.logUsageAnalytics) {
            keyPresses.append((event.asAnonymousKeyEvent(), Date()))
        }
    }
}

extension KeyAnalytics {
    private func startTracking() {
        if (state == .logging) { return }

        removeOldKeyEventsTimer = RepeatingTimer(timeInterval: timerInterval)
        removeOldKeyEventsTimer?.resume()
        state = .logging
    }

    private func stopTracking() {
        if (state == .inactive) { return }

        removeOldKeyEventsTimer?.suspend()
        state = .inactive
    }

    func reset() {
        keyPresses.removeAll()
    }

    func isInactive() -> Bool {
        state == .inactive && keyPresses.count == 0
    }
}

// Querying functions
extension KeyAnalytics {
    private func keypressesInPast(_ seconds: Double) -> [KeyEventByTime] {
        let currentTime = Date()
        return keyPresses.filter({ $0.1.distance(to: currentTime) <= seconds })
    }

    public func totalKeypressesInPastSeconds(_ seconds: Double) -> Int {
        let kp = keypressesInPast(seconds)
        let kpLetter = kp.filter({ $0.0.direction == .keyDown }).count
        let kpFlags = kp.filter({ $0.0.direction == .flagsChanged}).count / 2
        return kpLetter + kpFlags
    }

    public func averageKeypressesEveryXSecondsForPastSeconds(_ seconds: Double) -> Double {
        Double(totalKeypressesInPastSeconds(seconds)) / seconds
    }
}
