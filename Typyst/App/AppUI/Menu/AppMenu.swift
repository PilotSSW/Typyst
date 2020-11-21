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

    //private var analyticsView = AnalyticsMenuItemView()
    //private let analyticsRow = NSMenuItem()

    private init() {

    }

    func constructMenu() -> NSMenu {
        let menu = NSMenu()
        menu.title = "Typyst"
        menu.autoenablesItems = true
        menu.allowsContextMenuPlugIns = true
        menu.showsStateColumn = true

        let volumeLabel = NSTextField(frame: NSRect(x: 20, y: 0, width: 150, height: 25))
        volumeLabel.stringValue = "Volume"
        volumeLabel.isBordered = false;
        volumeLabel.isBezeled = false;
        volumeLabel.backgroundColor = .clear
        volumeLabel.textColor = .white
        volumeLabel.font = menu.font

        let slider = NSSlider(frame: NSRect(x: 100, y: 0, width: 380, height: 25))
        slider.target = App.instance.ui
        slider.action = #selector(AppUI.setVolume)
        slider.floatValue = UserDefaults.standard.float(forKey: "lastSetVolume")

        // Volume slider
        let sliderView = NSView(frame: NSRect(x: 0, y: 0, width: 500, height: 25))
        sliderView.addSubview(volumeLabel)
        sliderView.addSubview(slider)

        let volumeItem = NSMenuItem()
        volumeItem.view = sliderView

        menu.addItem(volumeItem)
        menu.addItem(.separator())

        let olympiaRow = NSMenuItem(title: "Olympia SM3", action: #selector(AppUI.loadOlympiaSM3(_:)), keyEquivalent: "O")
        olympiaRow.state = App.instance.loadedTypewriter?.model == .Olympia_SM3 ? .on : .off
        menu.addItem(olympiaRow)

        let royalModelPRow = NSMenuItem(title: "Royal Model P", action: #selector(AppUI.loadRoyalModelP(_:)), keyEquivalent: "P")
        royalModelPRow.state = App.instance.loadedTypewriter?.model == .Royal_Model_P ? .on : .off
        menu.addItem(royalModelPRow)

        let coronaSilentRow = NSMenuItem(title: "Smith Corona Silent", action: #selector(AppUI.loadSmithCoronaSilent(_:)), keyEquivalent: "S")
        coronaSilentRow.state = App.instance.loadedTypewriter?.model == .Smith_Corona_Silent ? .on : .off
        menu.addItem(coronaSilentRow)
        menu.addItem(.separator())

        let menuItemPR = NSMenuItem(title: "Simulate paper return / new line every 80 characters", action: #selector(AppUI.setPaperReturnEnabled(_:)), keyEquivalent: "1")
        menuItemPR.state = AppSettings.paperReturnEnabled ? .on : .off
        menu.addItem(menuItemPR)

        let menuItemPF = NSMenuItem(title: "Simulate paper feed every 25 newlines", action: #selector(AppUI.setPaperFeedEnabled(_:)), keyEquivalent: "2")
        menuItemPF.state = AppSettings.paperFeedEnabled ? .on : .off
        menu.addItem(menuItemPF)

        let menuItemMN = NSMenuItem(title: "Show modal notifications", action: #selector(AppUI.setShowModalNotifications(_:)), keyEquivalent: "3")
        menuItemMN.state = AppSettings.showModalNotifications ? .on : .off
        menu.addItem(menuItemMN)

        menu.addItem(.separator())

//        let menuItemTUA = NSMenuItem(title: "Show typing analytics", action: #selector(AppUI.setTrackUsageAnalytics(_:)), keyEquivalent: "9")
//        menuItemTUA.state = AppSettings.logUsageAnalytics ? .on : .off
//        menu.addItem(menuItemTUA)
//
//        menu.addItem(.separator())
//
//        let menuView = NSView()
//        menuView.addSubview(analyticsView.view)
//        menuView.translatesAutoresizingMaskIntoConstraints = false
//        menuView.topAnchor.constraint(equalTo: analyticsView.view.topAnchor, constant: -4).isActive = true
//        menuView.bottomAnchor.constraint(equalTo: analyticsView.view.bottomAnchor, constant: 4).isActive = true
//        menuView.leftAnchor.constraint(equalTo: analyticsView.view.leftAnchor, constant: -20).isActive = true
//        menuView.rightAnchor.constraint(equalTo: analyticsView.view.rightAnchor, constant: 20).isActive = true
//        analyticsRow.view = menuView
//        analyticsRow.tag = 99
//
//        if AppSettings.logUsageAnalytics {
//            menu.addItem(analyticsRow)
//            let resetAnalyticsRow = NSMenuItem(title: "Reset analytics", action: #selector(self.resetMenuAnalytics), keyEquivalent: "/")
//            resetAnalyticsRow.target = self
//            resetAnalyticsRow.isEnabled = true
//            resetAnalyticsRow.tag = 98
//            menu.addItem(resetAnalyticsRow)
//            menu.addItem(.separator())        }
//
//        AppSettings.shared.onLogUsageAnalyticsChanged({ [weak self] (enabled) in
//            guard let self = self else { return }
//            self.enableAnalyticsItem(enabled, menu: menu)
//        })

        let menuItemFirebase = NSMenuItem(title: "Share errors and crashes with developer", action: #selector(AppUI.setLogErrorsAndCrashes(_:)), keyEquivalent: "0")
        menuItemFirebase.state = AppSettings.logUsageAnalytics ? .on : .off
        menu.addItem(menuItemFirebase)
        let menuItemEmailDev = NSMenuItem(title: "Email Typyst Support", action: #selector(AppUI.openEmailClient(_:)), keyEquivalent: "")
        menuItemEmailDev.target = self
        menu.addItem(menuItemEmailDev)
        menu.addItem(.separator())

        let menuItemQuit = NSMenuItem(title: "Quit Typyst", action: #selector(App.quit(_:)), keyEquivalent: "q")
        menuItemQuit.target = App.instance
        menuItemQuit.isEnabled = true
        menuItemQuit.tag = 97
        menu.addItem(menuItemQuit)

        menu.items.forEach({
            if ![99, 98, 97].contains($0.tag) {
                $0.target = App.instance.ui
                $0.isEnabled = AppDelegate.isAccessibilityAdded()
            }
        })

        return menu
    }

    @objc func resetMenuAnalytics() {
        KeyAnalytics.shared.reset()
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
