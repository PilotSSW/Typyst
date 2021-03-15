//
// Created by Sean Wolford on 2/15/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import AppKit
import Foundation

class MenuItemsAppSettings {

    var items: [NSMenuItem] {[
        sectionHeader,
        showMainWindow,
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
        menuItemMN.state = AppSettings.shared.showModalNotifications ? .on : .off
        AppSettings.shared.$showModalNotifications
            .sink { menuItemMN.state = $0 ? .on : .off }
            .store(in: &App.instance.subscriptions)
        return menuItemMN
    }()

    lazy var reportErrors: NSMenuItem = {
        let menuItemFirebase = NSMenuItem(title: "Share errors and crashes with developer", action: #selector(AppMenu.setLogErrorsAndCrashes(_:)), keyEquivalent: "0")
        menuItemFirebase.state = AppSettings.shared.logUsageAnalytics ? .on : .off
        AppSettings.shared.$logErrorsAndCrashes
            .sink { menuItemFirebase.state = $0 ? .on : .off }
            .store(in: &App.instance.subscriptions)
        return menuItemFirebase
    }()

    lazy var showMainWindow: NSMenuItem = {
        let menuItemMainWindow = NSMenuItem(title: "Show main window", action: #selector(AppMenu.showMainWindow(_:)), keyEquivalent: "1")
        menuItemMainWindow.state = AppSettings.shared.showMainWindow ? .on : .off
        AppSettings.shared.$showMainWindow
            .sink { menuItemMainWindow.state = $0 ? .on : .off }
            .store(in: &App.instance.subscriptions)
        return menuItemMainWindow
    }()
}

// App Settings Menu Items
extension AppMenu {
    @objc func setLogErrorsAndCrashes(_ sender: Any?) {
        let enabled = !AppSettings.shared.logErrorsAndCrashes
        (sender as? NSMenuItem)?.state = enabled ? .on : .off
        AppSettings.shared.logErrorsAndCrashes = enabled
    }

    @objc func setShowModalNotifications(_ sender: Any?) {
        let enabled = !AppSettings.shared.showModalNotifications
        (sender as? NSMenuItem)?.state = enabled ? .on : .off
        AppSettings.shared.showModalNotifications = enabled
    }

    @objc func showMainWindow(_ sender: Any?) {
        AppSettings.shared.showMainWindow = !AppSettings.shared.showMainWindow
        (sender as? NSMenuItem)?.state = AppSettings.shared.showMainWindow ? .on : .off

        if AppSettings.shared.showMainWindow {
            App.instance.ui.appWindow?.showWindow()
        }
        else {
            App.instance.ui.appWindow?.closeWindow()
        }
    }
}
