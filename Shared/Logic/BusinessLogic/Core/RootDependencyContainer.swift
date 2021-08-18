//
// Created by Sean Wolford on 2019-01-16.
// Copyright (c) 2019 wickedPropeller. All rights reserved.
//

import Combine
import Foundation

//enum DependencyContainerRuntime {
//    case iOS
//    case iOSKeyboardExtension
//    case macOS
//}

final class RootDependencyContainer {
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
                                              logger: logging)
    }

    static func get() -> RootDependencyContainer { rootDependencyContainer }
}

