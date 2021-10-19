//
// Created by Sean Wolford on 3/4/20.
// Copyright (c) 2020 wickedPropeller. All rights reserved.
//

import Combine
import Foundation
import KeyLogic

final class TypingStats: Loggable {
    private var keyEventStore: KeyEventStore?

    init(withSubscriptionsStore subscriptions: inout Set<AnyCancellable>,
         keyboardService: KeyboardService,
         settingsService: SettingsService = RootDependencyContainer.get().settingsService,
         appDebugSettings:AppDebugSettings = RootDependencyContainer.get().appDebugSettings)
    {
        keyEventStore = KeyEventStore(withSubscriptionsStore: &subscriptions,
                                      keyboardService: keyboardService,
                                      settingsService: settingsService,
                                      appDebugSettings: appDebugSettings)
    }

    func reset() {
        keyEventStore?.reset()
    }
}

// Querying Functions
extension TypingStats {
    internal func keypressesInThePast(_ seconds: Double,
                                      fromTime time: Date = Date(),
                                      direction: KeyDirection? = .keyDown) -> Set<AnonymousKeyEvent>
    {
        logEvent(.trace, "keypresses in the past seconds: \(seconds)")
        return keyEventStore?.keyPresses.filter {
            let firstCondition = $0.timeStamp.distance(to: time) <= seconds
            let secondCondition = direction != nil ? $0.direction == direction : true
            let thirdCondition = !$0.isRepeat
            return firstCondition && secondCondition && thirdCondition
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
