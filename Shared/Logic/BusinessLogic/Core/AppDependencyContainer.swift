//
//  AppDependencyContainer.swift
//  Typyst (iOS)
//
//  Created by Sean Wolford on 6/27/21.
//

import Combine
import Foundation

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
