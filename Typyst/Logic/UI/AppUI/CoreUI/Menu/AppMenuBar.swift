//
// Created by Sean Wolford on 2/15/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import AppKit
import Foundation

class AppMenuBar {
    let statusBar: NSStatusBar
    let statusBarIcon: NSStatusItem

    init(menu: NSMenu) {
        statusBar = NSStatusBar()
        statusBarIcon = statusBar.statusItem(withLength: 36)
        statusBarIcon.title = "Typyst"

        if let button = statusBarIcon.button {
            button.image = NSImage(named: "AppIcon")
            button.image?.size = NSSize(width: 16.0, height: 16.0)
            button.image?.isTemplate = false
            button.target = self
        }

        statusBarIcon.target = self
        statusBarIcon.menu = menu
    }
}
