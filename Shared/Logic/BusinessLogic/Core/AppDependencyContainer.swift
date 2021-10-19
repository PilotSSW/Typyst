//
//  AppDependencyContainer.swift
//  Typyst (iOS)
//
//  Created by Sean Wolford on 6/27/21.
//

import Combine
import Foundation

final class AppDependencyContainer: ObservableObject {
    fileprivate static var appDependencyContainer = AppDependencyContainer(withRootDependencyContainer: RootDependencyContainer.get())

    private(set) var rootDependencyContainer: RootDependencyContainer
    private(set) var alertsService: AlertsService
    private(set) var documentsService: DocumentsService
    private(set) var emailService: EmailService

    private(set) var typingStats: TypingStats

    #if os(macOS)
    private(set) internal var macOSService: MacOSService
    #endif

    private init(withRootDependencyContainer rootContainer: RootDependencyContainer) {
        rootDependencyContainer = rootContainer

        alertsService = AlertsService(settingsService: rootDependencyContainer.settingsService,
                                      appDebugSettings: rootDependencyContainer.appDebugSettings)

        #if os(macOS)
        macOSService = MacOSService(alertsService: alertsService,
                                    keyboardService: rootDependencyContainer.keyboardService,
                                    loggingService: rootDependencyContainer.logging,
                                    settingsService: rootDependencyContainer.settingsService,
                                    subscriptions: &rootDependencyContainer.subscriptions)
        #endif

        documentsService = DocumentsService()

        emailService = EmailService()

        typingStats = TypingStats(withSubscriptionsStore: &rootDependencyContainer.subscriptions,
                                  keyboardService: rootDependencyContainer.keyboardService,
                                  settingsService: rootDependencyContainer.settingsService,
                                  appDebugSettings: rootDependencyContainer.appDebugSettings)
    }

    deinit {

    }

    static func get() -> AppDependencyContainer {
        if (appDependencyContainer == nil) {
            Logging.logFatalCrash()
        }

        return appDependencyContainer
    }
}
