//
// Created by Sean Wolford on 2/15/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import AppKit
import Foundation
import SwiftUI

class MenuItemsCore {

    var items: [NSMenuItem] {[
        emailDeveloper,
        .separator(),
        quitApp
    ]}

    lazy var showMainWindow: NSMenuItem = {
        let menuItemEmailDev = NSMenuItem(title: "Show Main Window", action: #selector(AppMenu.openEmailClient(_:)), keyEquivalent: "")
        menuItemEmailDev.isEnabled = true
        menuItemEmailDev.tag = 1

        return menuItemEmailDev
    }()

    lazy var emailDeveloper: NSMenuItem = {
        let menuItemEmailDev = NSMenuItem(title: "Email Typyst Support", action: #selector(AppMenu.openEmailClient(_:)), keyEquivalent: "")
        menuItemEmailDev.isEnabled = true
        menuItemEmailDev.tag = 1

        return menuItemEmailDev
    }()

    lazy var quitApp: NSMenuItem = {
        let menuItemQuit = NSMenuItem(title: "Quit Typyst", action: #selector(App.quit(_:)), keyEquivalent: "q")
        menuItemQuit.isEnabled = true
        menuItemQuit.tag = 1

        return menuItemQuit
    }()
}

// Core Menu Items
extension AppMenu {
    @objc func openEmailClient(_ sender: Any?) {
        let service = NSSharingService(named: NSSharingService.Name.composeEmail)
        service?.recipients = ["pilotssw@gmail.com"]
        service?.subject = "Oh no! Something in Typyst isn't working correctly"
        service?.perform(withItems: ["Test Mail body"])
        NSWorkspace.shared.launchApplication("Mail")
    }
}
