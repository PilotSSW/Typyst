//
// Created by Sean Wolford on 3/19/20.
// Copyright (c) 2020 wickedPropeller. All rights reserved.
//

import Foundation
import Cocoa
import AppKit
import SwiftUI

class AppMenu {
//    let analyticsMenuItems = MenuItemsAnalyticsItems()
    let appMenuItems = MenuItemsAppSettings()
    let coreMenuItems = MenuItemsCore()
    let typeWriterMenuItems = MenuItemsTypeWriters()
    let typeWriterSettingsMenuItems = MenuItemsTypeWriterSettings()
    let volumeMenuItems = MenuItemsVolumeSettings()

    let menu: NSMenu = NSMenu()
    let statusBarIcon = NSStatusBar.system.statusItem(withLength: 18)

    init() {
        menu.title = "Typyst"
        menu.autoenablesItems = true
        menu.allowsContextMenuPlugIns = true
        menu.showsStateColumn = true

//        AppSettings.shared.onLogUsageAnalyticsChanged({ [weak self] (enabled) in
//            guard let self = self else { return }
//            self.enableAnalyticsItem(enabled, menu: menu)
//        })
    }

    func constructMenu() {
        let menuOptions: [NSMenuItem] = getMenuItems()
        menuOptions.forEach({
            // Case: Items that should never be disabled / have their isEnabled changed
            if ![1, 2].contains($0.tag) {
                $0.isEnabled = AppDelegate.isAccessibilityAdded()
            }
            // Case: Special items that have a specific target already set -- all others should point here
            if ![2, 98, 99].contains($0.tag) {
                $0.target = App.instance.ui.appMenu
            }
            menu.addItem($0)
        })
    }

    func attachToOSMenuBar() {
        statusBarIcon.menu = menu

        if let button = statusBarIcon.button {
            button.image = NSImage(named: "AppIcon")
            button.image?.size = NSSize(width: 16.0, height: 16.0)
            button.image?.isTemplate = false
        }
    }

    func getMenuItems() -> [NSMenuItem] {
        [
            volumeMenuItems.items,
            typeWriterMenuItems.items,
            typeWriterSettingsMenuItems.items,
            appMenuItems.items,
//            analyticsMenuItems.items,
            coreMenuItems.items
        ].flatMap({ $0 })
    }
}
