//
// Created by Sean Wolford on 2019-01-16.
// Copyright (c) 2019 wickedPropeller. All rights reserved.
//

import Combine
import Foundation

class AppCore: ObservableObject {
    static let instance: AppCore = AppCore()
    @Published private(set) var alertsHandler = AlertsHandler()
    @Published private(set) var logging = Logging()
    @Published private(set) var typeWriterHandler = TypeWriterHandler()
//    @Published private(set) var persistence = AppPersistence()

    #if os(macOS)
    lazy var macOSUI = MacOSUI()
    #endif

    var subscriptions = Set<AnyCancellable>()

    private init() {

    }

    deinit {
        //persistence.saveAction(self)
    }

    func setup() {
        logging.setup()
        typeWriterHandler.setup()
        #if os(macOS)
        macOSUI.setup()
        MacOSKeyListener.instance.listenForAllKeyPresses()
        #endif
    }
}
