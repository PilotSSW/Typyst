//
// Created by Sean Wolford on 2/15/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import AppKit
import Foundation

class MenuItemsAppSettings {

    var items: [NSMenuItem] {[
        sectionHeader,
        modalNotifications,
        reportErrors,
        NSMenuItem.separator()
    ]}

    lazy var sectionHeader: NSMenuItem = {
        let section = NSMenuItem(title: "App Settings", action: nil, keyEquivalent: "")
        section.isEnabled = false
        section.tag = 2
        return section
    }()

    lazy var modalNotifications: NSMenuItem = {
        let menuItemMN = NSMenuItem(title: "Show modal notifications", action: #selector(AppMenu.setShowModalNotifications(_:)), keyEquivalent: "3")
        menuItemMN.state = AppSettings.showModalNotifications ? .on : .off
        return menuItemMN
    }()

    lazy var reportErrors: NSMenuItem = {
        let menuItemFirebase = NSMenuItem(title: "Share errors and crashes with developer", action: #selector(AppMenu.setLogErrorsAndCrashes(_:)), keyEquivalent: "0")
        menuItemFirebase.state = AppSettings.logUsageAnalytics ? .on : .off
        return menuItemFirebase
    }()
}

// App Settings Menu Items
extension AppMenu {
    @objc func setLogErrorsAndCrashes(_ sender: Any?) {
        let enabled = !AppSettings.logErrorsAndCrashes
        (sender as? NSMenuItem)?.state = enabled ? .on : .off
        AppSettings.logErrorsAndCrashes = enabled
    }

    @objc func setShowModalNotifications(_ sender: Any?) {
        let enabled = !AppSettings.showModalNotifications
        (sender as? NSMenuItem)?.state = enabled ? .on : .off
        AppSettings.showModalNotifications = enabled
    }
}