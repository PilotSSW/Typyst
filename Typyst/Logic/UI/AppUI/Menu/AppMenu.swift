//
// Created by Sean Wolford on 3/19/20.
// Copyright (c) 2020 wickedPropeller. All rights reserved.
//

import Foundation
import Cocoa
import AppKit
import SwiftUI


class AppMenu {
    public static let shared = AppMenu()

    //var statusBar: StatusBarController?

    private init() {

    }

    func constructMenu() -> NSMenu {
        let menu = NSMenu()
        menu.title = "Typyst"
        menu.autoenablesItems = true
        menu.allowsContextMenuPlugIns = true
        menu.showsStateColumn = true

        let separator = NSMenuItem.separator()
        let items = MenuItems.shared

        let volumeOptions = [
            items.volumeSlider,
            separator
        ]

        let typeWriters = [
            items.typewriterModelDivider,
            items.coronaSilent,
            items.olympiaSM3,
            items.royalModelP,
            separator
        ]

        let typeWritersSettings = [
            items.typewriterSettingsDivider,
            items.paperFeed,
            items.paperReturn,
            separator
        ]

        let appSettings = [
            items.modalNotifications,
            items.reportErrors,
            items.emailDeveloper,
            separator
        ]

        let analyticsOptions = AppSettings.logUsageAnalytics
            ? [
                items.analyticsEnabled,
                items.analyticsReset,
                items.analyticsView,
                separator
            ]
            : [
                items.analyticsEnabled,
                separator
            ]

        let menuOptions: [NSMenuItem] = [
            volumeOptions,
            typeWriters,
            typeWritersSettings,
            appSettings,
            analyticsOptions,
            [items.quitApp]
        ].flatMap({ $0 })

        menuOptions.forEach({ menu.addItem($0) })

        menu.items.forEach({
            if ![99, 98, 97].contains($0.tag) {
                $0.target = App.instance.ui
                $0.isEnabled = AppDelegate.isAccessibilityAdded()
            }
        })

//        AppSettings.shared.onLogUsageAnalyticsChanged({ [weak self] (enabled) in
//            guard let self = self else { return }
//            self.enableAnalyticsItem(enabled, menu: menu)
//        })

        return menu
    }

//    @objc func enableAnalyticsItem(_ enabled: Bool, menu: NSMenu) {
//        if !enabled {
//            menu.removeItem(at: 14) // remove separator
//            menu.removeItem(at: 13) // reset analytics
//            menu.removeItem(self.analyticsRow)
//        } else {
//            menu.items.insert(self.analyticsRow, at: 12)
//            _ = menu.items[12].view
//            let resetAnalyticsRow = NSMenuItem(title: "Reset analytics", action: #selector(self.resetMenuAnalytics), keyEquivalent: "/")
//            resetAnalyticsRow.target = self
//            menu.items.insert(resetAnalyticsRow, at: 13)
//            menu.items.insert(.separator(), at: 14)
//            self.analyticsRow.view?.needsDisplay = true
//            self.analyticsRow.view?.displayIfNeeded()
//        }
//    }
}
