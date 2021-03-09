//
// Created by Sean Wolford on 2/15/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import AppKit
import Foundation

class MenuItemsAnalyticsItems {
    var items: [NSMenuItem] {
        AppSettings.shared.logUsageAnalytics ? [
            sectionHeader,
            analyticsEnabled,
            analyticsReset,
            analyticsView,
            NSMenuItem.separator()
        ] : [
            sectionHeader,
            analyticsEnabled,
            NSMenuItem.separator()
        ]
    }

    lazy var sectionHeader: NSMenuItem = {
        let section = NSMenuItem(title: "Typing Analytics", action: nil, keyEquivalent: "")
        section.isEnabled = false
        section.tag = 2
        return section
    }()

    lazy var analyticsEnabled: NSMenuItem = {
        let item = NSMenuItem(title: "Show typing analytics", action: #selector(AppMenu.setTrackUsageAnalytics(sender:)), keyEquivalent: "9")
        item.state = AppSettings.shared.logUsageAnalytics ? .on : .off
        return item
    }()

    lazy var analyticsView: NSMenuItem = {
        let analyticsView = AnalyticsInfoView()
        let menuItem = NSMenuItem(title: "", action: nil, keyEquivalent: "")
        menuItem.view?.addSubview(analyticsView.view)
        menuItem.view?.translatesAutoresizingMaskIntoConstraints = false
        menuItem.view?.topAnchor.constraint(equalTo: analyticsView.view.topAnchor, constant: -4).isActive = true
        menuItem.view?.bottomAnchor.constraint(equalTo: analyticsView.view.bottomAnchor, constant: 4).isActive = true
        menuItem.view?.leftAnchor.constraint(equalTo: analyticsView.view.leftAnchor, constant: -20).isActive = true
        menuItem.view?.rightAnchor.constraint(equalTo: analyticsView.view.rightAnchor, constant: 20).isActive = true
        menuItem.tag = 99

        return menuItem
    }()

    lazy var analyticsReset: NSMenuItem = {
        let resetAnalyticsRow = NSMenuItem(title: "Reset analytics", action: #selector(KeyAnalytics.shared.reset), keyEquivalent: "/")
        resetAnalyticsRow.isEnabled = true
        resetAnalyticsRow.tag = 98

        return resetAnalyticsRow
    }()


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

// Analytics Menu Items
extension AppMenu {
    @objc func setTrackUsageAnalytics(sender: Any?) {
        let enabled = !AppSettings.shared.logUsageAnalytics
        (sender as? NSMenuItem)?.state = enabled ? .on : .off
        AppSettings.shared.logUsageAnalytics = enabled
    }
}
