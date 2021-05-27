//
// Created by Sean Wolford on 3/4/20.
// Copyright (c) 2020 wickedPropeller. All rights reserved.
//

import Combine
import Foundation

class TypingStats {
    enum State {
        case logging
        case inactive
    }
    public private(set) var state: State = .inactive
    public static let shared: TypingStats = TypingStats()

    internal typealias KeyEventByTime = (AnonymousKeyEvent, Date)
    private var keyPresses: [KeyEventByTime] = []
    private var keyListenerCallback: (KeyEvent) -> Void

    private var removeOldKeyEventsTimerInterval: TimeInterval = 600
    private var removeOldKeyEventsTimer: RepeatingTimer? {
        didSet {
            removeOldKeyEventsTimer?.eventHandler = { [weak self] in
                DispatchQueue.main.async(execute: { [weak self] in
                    guard let self = self else { return }
                    self.keyPresses.removeAll(where: { abs($0.1.timeIntervalSinceNow) > 86400 })
                })
            }
        }
    }

    private init() {
        keyPresses.reserveCapacity(25000)

        keyListenerCallback = { (keyEvent) in TypingStats.shared.logEvent(keyEvent) }
        let _ = KeyHandler.instance.registerKeyPressCallback(withTag: "stats", completion: keyListenerCallback)

        removeOldKeyEventsTimer = RepeatingTimer(timeInterval: removeOldKeyEventsTimerInterval, leeway: .seconds(10))
        removeOldKeyEventsTimer?.resume()

        if (AppSettings.shared.logUsageAnalytics) { startTracking() }
        AppSettings.shared.$logUsageAnalytics
            .sink { [weak self] in
                guard let self = self else { return }
                $0 ? self.startTracking() : self.stopTracking()
            }
            .store(in: &AppCore.instance.subscriptions)
    }

    deinit {
        stopTracking()
        removeOldKeyEventsTimer?.suspend()
    }

    func logEvent(_ event: KeyEvent) {
        // Key events come in quickly -- don't lock up the main thread processing each one
        DispatchQueue.main.async(execute: { [weak self] in
            guard let self = self else { return }
            if (self.state == .logging && AppSettings.shared.logUsageAnalytics) {
                self.keyPresses.append((event.asAnonymousKeyEvent(), Date()))
            }
        })
    }
}

// State Controls and Getters
extension TypingStats {
    internal func startTracking() {
        if (state == .logging) { return }

        state = .logging
    }

    internal func stopTracking() {
        if (state == .inactive) { return }

        state = .inactive
    }

    func reset() {
        keyPresses.removeAll()
    }

    func isInactive() -> Bool {
        state == .inactive && keyPresses.count == 0
    }
}

// Querying Functions
extension TypingStats {
    internal func keypressesInThePast(_ seconds: Double) -> [KeyEventByTime] {
        let currentTime = Date()
        return keyPresses.filter({ $0.1.distance(to: currentTime) <= seconds })
    }

    public func total(_ kp: [KeyEventByTime]) -> Int {
        let kpLetter = kp.filter({ $0.0.direction == .keyDown }).count
//        let kpFlags = kp.filter({ $0.0.direction == .flagsChanged}).count / 2
        return kpLetter //+ kpFlags
    }

    public func average(total kp: Int, over seconds: Double) -> Double {
        Double(kp) / seconds
    }

    var allEvents: Int {
        keyPresses.count
    }
}
