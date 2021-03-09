//
// Created by Sean Wolford on 2019-01-16.
// Copyright (c) 2019 wickedPropeller. All rights reserved.
//

import AppKit
import Foundation
import FirebaseCore
import FirebaseCoreDiagnostics
import FirebaseCrashlytics
import FirebaseInstallations

class App {
    static let instance: App = App()
    private(set) var core = AppCore()
    private(set) var ui = AppUI()
    private(set) var persistence = AppPersistence()

    var showModals: Bool = true

    private init() {
        
    }

    deinit {
        persistence.saveAction(self)
    }

    func setup() {
        #if DEBUG
        AppDebugSettings.shared.debugGlobal = true
        #endif

        core.setup()
        ui.setup()

        if !AppDelegate.isAccessibilityAdded() {
            SystemFunctions.askUserToAllowSystemAccessibility()
        }
    }

    @objc func quit(_ sender: Any?) {
        NSApplication.shared.terminate(sender)
    }
}
