//
// Created by Sean Wolford on 2019-01-16.
// Copyright (c) 2019 wickedPropeller. All rights reserved.
//

import Combine
import Foundation
import RealmSwift

final class RootDependencyContainer {
    fileprivate static var rootDependencyContainer = RootDependencyContainer()

    var subscriptions = Set<AnyCancellable>()

    private(set) var settingsService: SettingsService
    private(set) var appDebugSettings: AppDebugSettings
    private(set) var logging: Logging

//    @Published private(set) var persistence = AppPersistence()

    private(set) var keyboardService: KeyboardService
    private(set) var typeWriterService: TypeWriterService
    
    private(set) var realmInstance: Realm?

    private init() {
        subscriptions = Set<AnyCancellable>()
        
        settingsService = SettingsService()
        appDebugSettings = AppDebugSettings()

        logging = Logging(withStore: &subscriptions,
                          settingsService: settingsService,
                          appDebugSettings: appDebugSettings)
        
        realmInstance = Realm(.mainRealm, withLoggingInstance: logging)

        keyboardService = KeyboardService(settingsService: settingsService,
                                          appDebugSettings: appDebugSettings)

        typeWriterService = TypeWriterService(withKeyboardService: keyboardService,
                                              settingsService: settingsService,
                                              logger: logging)
    }

    static func get() -> RootDependencyContainer {
        if (rootDependencyContainer == nil) {
            Logging.logFatalCrash()
        }

        return rootDependencyContainer
    }
}

