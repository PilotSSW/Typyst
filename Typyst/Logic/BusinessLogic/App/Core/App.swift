//
// Created by Sean Wolford on 2019-01-16.
// Copyright (c) 2019 wickedPropeller. All rights reserved.
//

import AppKit
import Combine
import Foundation

class App: ObservableObject {
    static let instance: App = App()
    @Published private(set) var core = AppCore()
    @Published private(set) var logging = Logging()
    @Published private(set) var ui = AppUI()
    @Published private(set) var persistence = AppPersistence()

    var subscriptions = Set<AnyCancellable>()

    private init() {
        
    }

    deinit {
        persistence.saveAction(self)
    }

    func setup() {
        logging.setup()
        core.setup()
        ui.setup()

        if !AppDelegate.isAccessibilityAdded() {
            SystemFunctions.askUserToAllowSystemAccessibility()
        }
    }

    @objc func quit(_ sender: Any?) {
        NSApplication.shared.terminate(sender)
    }

    @objc func emailSupport() {
        let service = NSSharingService(named: NSSharingService.Name.composeEmail)
        service?.recipients = ["pilotssw@gmail.com"]
        service?.subject = "Oh no! Something in Typyst isn't working correctly"
        service?.perform(withItems: ["Test Mail body"])
        NSWorkspace.shared.launchApplication("Mail")
    }
}
