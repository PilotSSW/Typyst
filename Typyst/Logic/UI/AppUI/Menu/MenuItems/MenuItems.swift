//
// Created by Sean Wolford on 2/13/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import AppKit
import Cocoa
import Foundation

class MenuItems {
    public static let shared = MenuItems()


    /**
     * Action menu options
     */


    var emailDeveloper: NSMenuItem = {
        let menuItemEmailDev = NSMenuItem(title: "Email Typyst Support", action: #selector(AppUI.openEmailClient(_:)), keyEquivalent: "")
//        menuItemEmailDev.target = shared
        return menuItemEmailDev
    }()

    var modalNotifications: NSMenuItem = {
        let menuItemMN = NSMenuItem(title: "Show modal notifications", action: #selector(AppUI.setShowModalNotifications(_:)), keyEquivalent: "3")
        menuItemMN.state = AppSettings.showModalNotifications ? .on : .off
        return menuItemMN
    }()

    var reportErrors: NSMenuItem = {
        let menuItemFirebase = NSMenuItem(title: "Share errors and crashes with developer", action: #selector(AppUI.setLogErrorsAndCrashes(_:)), keyEquivalent: "0")
        menuItemFirebase.state = AppSettings.logUsageAnalytics ? .on : .off
        return menuItemFirebase
    }()

    var volumeSlider: NSMenuItem = {
        let volumeLabel = NSTextField(frame: NSRect(x: 20, y: 0, width: 150, height: 25))
        volumeLabel.stringValue = "Volume"
        volumeLabel.isBordered = false;
        volumeLabel.isBezeled = false;
        volumeLabel.backgroundColor = .clear
        volumeLabel.textColor = .white

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

        return volumeItem
    }()

    var quitApp: NSMenuItem  = {
        let menuItemQuit = NSMenuItem(title: "Quit Typyst", action: #selector(App.quit(_:)), keyEquivalent: "q")
        menuItemQuit.target = App.instance
        menuItemQuit.isEnabled = true
        menuItemQuit.target = App.instance.ui
        menuItemQuit.tag = 97

        return menuItemQuit
    }()


    /**
     * Analytics actions and menu options
     */

    var analyticsEnabled: NSMenuItem = {
        let item = NSMenuItem(title: "Show typing analytics", action: #selector(AppUI.setTrackUsageAnalytics(_:)), keyEquivalent: "9")
        item.state = AppSettings.logUsageAnalytics ? .on : .off
        return item
    }()

    var analyticsView: NSMenuItem = {
        let analyticsView = AnalyticsMenuItemView()
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

    var analyticsReset: NSMenuItem = {
        let resetAnalyticsRow = NSMenuItem(title: "Reset analytics", action: #selector(KeyAnalytics.shared.reset), keyEquivalent: "/")
//        resetAnalyticsRow.target = shared
        resetAnalyticsRow.isEnabled = true
        resetAnalyticsRow.tag = 98

        return resetAnalyticsRow
    }()


    /**
     * Typewriter menu options
     */

    var typewriterModelDivider: NSMenuItem = {
        return NSMenuItem(title: "Smith Corona Silent", action: nil, keyEquivalent: "")
    }()

    var coronaSilent: NSMenuItem = {
        let coronaSilentRow = NSMenuItem(title: "Smith Corona Silent", action: #selector(AppUI.loadSmithCoronaSilent(_:)), keyEquivalent: "S")
        coronaSilentRow.state = App.instance.loadedTypewriter?.model == .Smith_Corona_Silent ? .on : .off
        return coronaSilentRow
    }()

    var olympiaSM3: NSMenuItem = {
        let olympiaRow = NSMenuItem(title: "Olympia SM3", action: #selector(AppUI.loadOlympiaSM3(_:)), keyEquivalent: "O")
        olympiaRow.state = App.instance.loadedTypewriter?.model == .Olympia_SM3 ? .on : .off
        return olympiaRow
    }()

    var royalModelP: NSMenuItem = {
        let royalModelPRow = NSMenuItem(title: "Royal Model P", action: #selector(AppUI.loadRoyalModelP(_:)), keyEquivalent: "P")
        royalModelPRow.state = App.instance.loadedTypewriter?.model == .Royal_Model_P ? .on : .off
        return royalModelPRow
    }()


    /**
     * Typewriter settings menu options
     */

    var typewriterSettingsDivider: NSMenuItem = {
       return NSMenuItem(title: "Typewriter settings", action: nil, keyEquivalent: "")
    }()

    var paperReturn: NSMenuItem = {
        let menuItemPR = NSMenuItem(title: "Simulate paper return / new line every 80 characters", action: #selector(AppUI.setPaperReturnEnabled(_:)), keyEquivalent: "1")
        menuItemPR.state = AppSettings.paperReturnEnabled ? .on : .off
        return menuItemPR
    }()

    var paperFeed: NSMenuItem = {
        let menuItemPF = NSMenuItem(title: "Simulate paper feed every 25 newlines", action: #selector(AppUI.setPaperFeedEnabled(_:)), keyEquivalent: "2")
        menuItemPF.state = AppSettings.paperFeedEnabled ? .on : .off
        return menuItemPF
    }()
}
