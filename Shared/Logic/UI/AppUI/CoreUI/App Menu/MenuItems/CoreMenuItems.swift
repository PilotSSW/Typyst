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
        let menuItemQuit = NSMenuItem(title: "Quit Typyst", action: #selector(AppCore.quit(_:)), keyEquivalent: "q")
        menuItemQuit.target = AppCore.instance
        menuItemQuit.isEnabled = true
        menuItemQuit.tag = 2

        return menuItemQuit
    }()
}

// Core Menu Items
extension AppMenu {
    @objc func openEmailClient(_ sender: Any?) {
        AppCore.instance.emailSupport()
    }
}
