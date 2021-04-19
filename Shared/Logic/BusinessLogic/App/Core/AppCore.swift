//
// Created by Sean Wolford on 2019-01-16.
// Copyright (c) 2019 wickedPropeller. All rights reserved.
//

#if os(macOS)
import AppKit
#endif
import Combine
import Foundation

class AppCore: ObservableObject {
    static let instance: AppCore = AppCore()
    @Published private(set) var typeWriterHandler = TypeWriterHandler()
    @Published private(set) var logging = Logging()
    @Published private(set) var ui = AppUI()
//    @Published private(set) var persistence = AppPersistence()

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
        ui.setup()

//        if !AppDelegate.isAccessibilityAdded() {
//            SystemFunctions.askUserToAllowSystemAccessibility()
//        }
        #endif
    }

    @objc func quit(_ sender: Any?) {
        #if os(macOS)
        NSApplication.shared.terminate(sender)
        #endif
    }

    @objc func emailSupport() {
        #if os(macOS)
        let service = NSSharingService(named: NSSharingService.Name.composeEmail)
        service?.recipients = ["pilotssw@gmail.com"]
        service?.subject = "Oh no! Something in Typyst isn't working correctly"
        service?.perform(withItems: ["Test Mail body"])
        NSWorkspace.shared.launchApplication("Mail")
        #endif
    }
}
