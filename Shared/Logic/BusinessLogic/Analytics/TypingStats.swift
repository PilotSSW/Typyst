//
// Created by Sean Wolford on 3/4/20.
// Copyright (c) 2020 wickedPropeller. All rights reserved.
//

import Combine
import Foundation

final class TypingStats {
    private var keyEventStore: KeyEventStore?

    func setup(withSubscriptionsStore subscriptions: inout Set<AnyCancellable>) {
        keyEventStore = KeyEventStore(withSubscriptionsStore: &subscriptions)
    }

    func reset() {
        keyEventStore?.reset()
    }
}

// Querying Functions
extension TypingStats {
    internal func keypressesInThePast(_ seconds: Double) -> Set<AnonymousKeyEvent> {
        let currentTime = Date()
        return keyEventStore?.keyPresses.filter {
            $0.timeStamp.distance(to: currentTime) <= seconds
        } ?? Set<AnonymousKeyEvent>()
    }

    public func total(_ kp: Set<AnonymousKeyEvent>) -> Int {
        let kpLetter = kp.filter({ $0.direction == .keyDown }).count
//        let kpFlags = kp.filter({ $0.0.direction == .flagsChanged}).count / 2
        return kpLetter //+ kpFlags
    }

    public func average(total kp: Int, over seconds: Double) -> Double {
        Double(kp) / seconds
    }

    var allEvents: Int {
        keyEventStore?.keyPresses.count ?? 0
    }
}
