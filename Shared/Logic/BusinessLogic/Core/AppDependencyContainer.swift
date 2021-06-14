//
// Created by Sean Wolford on 2019-01-16.
// Copyright (c) 2019 wickedPropeller. All rights reserved.
//

import Combine
import Foundation

class AppDependencyContainer: ObservableObject {
    private(set) var appSettings = AppSettings()
    private(set) var appDebugSettings = AppDebugSettings()
    private(set) var logging = Logging()

    @Published private(set) var alertsHandler = AlertsHandler()
    private(set) var emailHandler = EmailHandler()
    @Published private(set) var keyHandler = KeyHandler()
    @Published private(set) var typeWriterHandler = TypeWriterHandler()

    @Published private(set) var typingStats = TypingStats()
//    @Published private(set) var persistence = AppPersistence()

    #if os(macOS)
    private(set) internal var macOSKeyListener: MacOSKeyListener
    //lazy var macOSUI = MacOSUI(self)
    #endif

    var subscriptions = Set<AnyCancellable>()

    init(completion: ((AppDependencyContainer) -> Void)? = nil) {
        #if os(macOS)
        macOSKeyListener = MacOSKeyListener()
        #endif
        completion?(self)
    }

    deinit {
        //persistence.saveAction(self)
    }

    func setup() {
        logging.setup(withStore: &subscriptions)
        typeWriterHandler.setup()
        typingStats.setup(withSubscriptionsStore: &subscriptions)
        #if os(macOS)
        //macOSUI.setup()
        #endif
    }
}

internal let appDependencyContainer = AppDependencyContainer() { container in
    DispatchQueue.main.async {
        container.setup()
    }
}
