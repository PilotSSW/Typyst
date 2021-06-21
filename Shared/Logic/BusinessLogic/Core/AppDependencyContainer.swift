//
// Created by Sean Wolford on 2019-01-16.
// Copyright (c) 2019 wickedPropeller. All rights reserved.
//

import Combine
import Foundation

class AppDependencyContainer: ObservableObject {
    private(set) var appSettings: AppSettings
    private(set) var appDebugSettings: AppDebugSettings
    private(set) var logging: Logging

    private(set) var alertsService: AlertsService
    private(set) var emailService: EmailService
    private(set) var keyboardService: KeyboardService
    private(set) var typeWriterService: TypeWriterService

    private(set) var typingStats: TypingStats
//    @Published private(set) var persistence = AppPersistence()

    #if os(macOS)
    private(set) internal var macOSKeyListener: MacOSKeyListener
    //lazy var macOSUI = MacOSUI(self)
    #endif

    var subscriptions: Set<AnyCancellable>

    init() {
        subscriptions = Set<AnyCancellable>()
        appSettings = AppSettings()
        appDebugSettings = AppDebugSettings()

        logging = Logging(withStore: &subscriptions, appSettings: appSettings, appDebugSettings: appDebugSettings)

        alertsService = AlertsService(appSettings: appSettings, appDebugSettings: appDebugSettings)
        keyboardService = KeyboardService(appSettings: appSettings, appDebugSettings: appDebugSettings)

        #if os(macOS)
        macOSKeyListener = MacOSKeyListener(keyboardService: keyboardService)
        #endif

        emailService = EmailService()

        typingStats = TypingStats(withSubscriptionsStore: &subscriptions,
                                  keyboardService: keyboardService,
                                  appSettings: appSettings,
                                  appDebugSettings: appDebugSettings)

        typeWriterService = TypeWriterService(withKeyboardService: keyboardService,
                                              appSettings: appSettings,
                                              subscriptionStore: subscriptions)

        #if os(macOS)
        //macOSUI.setup()
        #endif
    }

    deinit {
        //persistence.saveAction(self)
    }
}

internal let appDependencyContainer = AppDependencyContainer()

class KeyboardDependencyContainer {
    var subscriptions = Set<AnyCancellable>()

    private(set) var appSettings: AppSettings
    private(set) var appDebugSettings: AppDebugSettings
    private(set) var logging: Logging

    private(set) var keyboardService: KeyboardService
    private(set) var typeWriterService: TypeWriterService

    init() {
        appSettings = AppSettings()
        appDebugSettings = AppDebugSettings()

        logging = Logging(withStore: &subscriptions, appSettings: appSettings, appDebugSettings: appDebugSettings)

        keyboardService = KeyboardService(appSettings: appSettings, appDebugSettings: appDebugSettings)
        typeWriterService = TypeWriterService(withKeyboardService: keyboardService, subscriptionStore: subscriptions)
    }
}
