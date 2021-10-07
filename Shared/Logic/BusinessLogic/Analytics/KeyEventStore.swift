//
//  KeyEventHandler.swift
//  Typyst
//
//  Created by Sean Wolford on 5/30/21.
//

import Combine
import Foundation

final class KeyEventStore {
    private let settingsService: SettingsService
    private let appDebugSettings: AppDebugSettings
    private let keyboardService: KeyboardService

    private let createdAt = Date()

    enum State {
        case logging
        case inactive
    }
    public private(set) var state: State = .inactive
    public private(set) var keyPresses: Set<AnonymousKeyEvent> = []
    private var keyListenerCallback: (KeyEvent) -> Void = { _ in }
    private var removeOldKeyEventsTimerInterval: TimeInterval = 600
    private var removeOldKeyEventsTimer: RepeatingTimer? {
        didSet {
            removeOldKeyEventsTimer?.eventHandler = { [weak self] in
                DispatchQueue.main.async(execute: { [weak self] in
                    guard let self = self else { return }
                    let currentTime = Date()
                    self.keyPresses.filter {
                        abs($0.timeStamp.distance(to: currentTime)) > 86400
                    }.forEach { self.keyPresses.remove($0) }
                })
            }
        }
    }

    init(withSubscriptionsStore subscriptions: inout Set<AnyCancellable>,
         keyboardService: KeyboardService = RootDependencyContainer.get().keyboardService,
         settingsService: SettingsService = RootDependencyContainer.get().settingsService,
         appDebugSettings: AppDebugSettings = RootDependencyContainer.get().appDebugSettings) {
        self.settingsService = settingsService
        self.appDebugSettings = appDebugSettings
        self.keyboardService = keyboardService

        keyPresses.reserveCapacity(25000)
        keyboardService.registerKeyPressCallback(withTag: "stats-\(hashValue)") { [weak self] (keyEvent) in
            guard let self = self else { return }
            self.logEvent(keyEvent.asAnonymousKeyEvent())
        }

        removeOldKeyEventsTimer = RepeatingTimer(timeInterval: removeOldKeyEventsTimerInterval, leeway: .seconds(10))
        removeOldKeyEventsTimer?.resume()

        if (settingsService.logUsageAnalytics) { startTracking() }

        settingsService.$logUsageAnalytics
        .sink { [weak self] in
            guard let self = self else { return }
            $0 ? self.startTracking() : self.stopTracking()
        }
        .store(in: &subscriptions)
    }

    deinit {
        keyboardService.removeListenerCallback(withTag: "stats-\(hashValue)")
        stopTracking()
        removeOldKeyEventsTimer?.suspend()
    }

    func logEvent(_ event: AnonymousKeyEvent) {
        if !(state == .logging && settingsService.logUsageAnalytics) { return }

        // Key events come in quickly -- don't lock up the main thread processing each one
        DispatchQueue.main.async(execute: { [weak self] in
            guard let self = self else { return }
            self.keyPresses.insert(event)
        })
    }
}

/// Mark: State Controls and Getters
extension KeyEventStore {
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

/// Mark: Query functions
extension KeyEventStore: Hashable {
    var hashValue: Int {
        createdAt.hashValue + keyPresses.count
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(createdAt)
        hasher.combine(keyPresses)
    }

    static func == (lhs: KeyEventStore, rhs: KeyEventStore) -> Bool {
        lhs.createdAt == rhs.createdAt &&
        lhs.keyPresses.count == rhs.keyPresses.count
    }

    static func < (lhs: KeyEventStore, rhs: KeyEventStore) -> Bool {
        lhs.createdAt < rhs.createdAt ||
        lhs.keyPresses.count < rhs.keyPresses.count
    }
}
