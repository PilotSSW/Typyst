//
// Created by Sean Wolford on 2019-01-16.
// Copyright (c) 2019 wickedPropeller. All rights reserved.
//

import Combine
import Foundation

class RootDependencyContainer: ObservableObject {
    fileprivate static var rootDependencyContainer = RootDependencyContainer()

    var subscriptions = Set<AnyCancellable>()

    private(set) var appSettings: AppSettings
    private(set) var appDebugSettings: AppDebugSettings
    private(set) var logging: Logging

//    @Published private(set) var persistence = AppPersistence()

    private(set) var keyboardService: KeyboardService
    private(set) var typeWriterService: TypeWriterService

    private init() {
        subscriptions = Set<AnyCancellable>()

        appSettings = AppSettings()
        appDebugSettings = AppDebugSettings()

        logging = Logging(withStore: &subscriptions, appSettings: appSettings, appDebugSettings: appDebugSettings)

        keyboardService = KeyboardService(appSettings: appSettings, appDebugSettings: appDebugSettings)
        typeWriterService = TypeWriterService(withKeyboardService: keyboardService,
                                              appSettings: appSettings,
                                              logger: logging,
                                              subscriptionStore: subscriptions)
    }

    static func get() -> RootDependencyContainer { rootDependencyContainer }
}

#if os(macOS) || os(iOS)
class AppDependencyContainer: ObservableObject {
    fileprivate static var appDependencyContainer = AppDependencyContainer(withRootDependencyContainer: RootDependencyContainer.get())

    private(set) var rootDependencyContainer: RootDependencyContainer
    private(set) var alertsService: AlertsService
    private(set) var emailService: EmailService

    private(set) var typingStats: TypingStats

    #if os(macOS)
    private(set) internal var macOSKeyListener: MacOSKeyListener
    //lazy var macOSUI = MacOSUI(self)
    #endif

    private init(withRootDependencyContainer rootContainer: RootDependencyContainer) {
        rootDependencyContainer = rootContainer

        alertsService = AlertsService(appSettings: rootDependencyContainer.appSettings,
                                      appDebugSettings: rootDependencyContainer.appDebugSettings)

        #if os(macOS)
        macOSKeyListener = MacOSKeyListener(keyboardService: rootDependencyContainer.keyboardService)
        #endif

        emailService = EmailService()

        typingStats = TypingStats(withSubscriptionsStore: &rootDependencyContainer.subscriptions,
                                  keyboardService: rootDependencyContainer.keyboardService,
                                  appSettings: rootDependencyContainer.appSettings,
                                  appDebugSettings: rootDependencyContainer.appDebugSettings)
        #if os(macOS)
        //macOSUI.setup()
        #endif
    }

    deinit {
        //persistence.saveAction(self)
    }

    static func get() -> AppDependencyContainer { appDependencyContainer }
}
#endif

