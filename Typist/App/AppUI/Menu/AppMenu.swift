//
// Created by Sean Wolford on 3/19/20.
// Copyright (c) 2020 wickedPropeller. All rights reserved.
//

import Foundation
import Cocoa
import AppKit

class AppMenu {
    public static let shared = AppMenu()

    private var analyticsView = AnalyticsMenuItemView()
    private let analyticsRow = NSMenuItem()

    private init() {

    }

    func constructMenu() -> NSMenu {
        let menu = NSMenu()
        menu.title = "Typist"
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
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Load Olympia SM3", action: #selector(AppUI.loadOlympiaSM3(_:)), keyEquivalent: "1"))
        menu.addItem(NSMenuItem(title: "Load Royal Model P", action: #selector(AppUI.loadRoyalModelP(_:)), keyEquivalent: "2"))
        menu.addItem(NSMenuItem(title: "Load Smith Corona Silent", action: #selector(AppUI.loadSmithCoronaSilent(_:)), keyEquivalent: "3"))
        menu.addItem(NSMenuItem.separator())

        let menuItemPR = NSMenuItem(title: "Simulate paper return / new line every 80 characters", action: #selector(AppUI.setPaperReturnEnabled(_:)), keyEquivalent: "8")
        menuItemPR.state = AppSettings.paperReturnEnabled ? .on : .off
        menu.addItem(menuItemPR)

        let menuItemPF = NSMenuItem(title: "Simulate paper feed every 25 newlines", action: #selector(AppUI.setPaperFeedEnabled(_:)), keyEquivalent: "9")
        menuItemPF.state = AppSettings.paperFeedEnabled ? .on : .off
        menu.addItem(menuItemPF)

        let menuItemMN = NSMenuItem(title: "Show modal notifications", action: #selector(AppUI.setShowModalNotifications(_:)), keyEquivalent: "0")
        menuItemMN.state = AppSettings.showModalNotifications ? .on : .off
        menu.addItem(menuItemMN)

        menu.addItem(NSMenuItem.separator())

        let menuItemTUA = NSMenuItem(title: "Show usage analytics", action: #selector(AppUI.setTrackUsageAnalytics(_:)), keyEquivalent: "0")
        menuItemTUA.state = AppSettings.logUsageAnalytics ? .on : .off
        menu.addItem(menuItemTUA)

        menu.addItem(NSMenuItem.separator())

        let menuView = NSView()
        menuView.addSubview(analyticsView.view)
        menuView.translatesAutoresizingMaskIntoConstraints = false
        menuView.topAnchor.constraint(equalTo: analyticsView.view.topAnchor, constant: -15).isActive = true
        menuView.bottomAnchor.constraint(equalTo: analyticsView.view.bottomAnchor, constant: 15).isActive = true
        menuView.leftAnchor.constraint(equalTo: analyticsView.view.leftAnchor, constant: -15).isActive = true
        menuView.rightAnchor.constraint(equalTo: analyticsView.view.rightAnchor, constant: 15).isActive = true
        analyticsRow.view = menuView
        AppSettings.shared.onLogUsageAnalyticsChanged({ [weak self] (enabled) in
            guard let strongSelf = self else { return }

            strongSelf.analyticsRow.isHidden = !enabled
        })
        menu.addItem(analyticsRow)
        menu.addItem(NSMenuItem.separator())


        let menuItemFirebase = NSMenuItem(title: "Share errors and crashes with developer", action: #selector(AppUI.setLogErrorsAndCrashes(_:)), keyEquivalent: "0")
        menuItemFirebase.state = AppSettings.logUsageAnalytics ? .on : .off
        menu.addItem(menuItemFirebase)
        let menuItemEmailDev = NSMenuItem(title: "Email Typist Support", action: #selector(AppUI.setLogErrorsAndCrashes(_:)), keyEquivalent: "0")

        menu.addItem(NSMenuItem.separator())

        let menuItemQuit = NSMenuItem(title: "Quit Typist", action: #selector(App.quit(_:)), keyEquivalent: "q")
        menu.addItem(menuItemQuit)

        menu.items.forEach({
            $0.target = App.instance.ui
            $0.isEnabled = AppDelegate.isAccessibilityAdded()
        })

        return menu
    }
}