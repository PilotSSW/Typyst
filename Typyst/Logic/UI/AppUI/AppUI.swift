//
//  AppUI.swift
//  Typyst
//
//  Created by Sean Wolford on 2/1/20.
//  Copyright © 2020 wickedPropeller. All rights reserved.
//

import AppKit
import Cocoa
import Foundation

class AppUI {
    let menuBarIcon = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    public var alerts = Alerts()

    init() {
        menuBarIcon.target = self
    }

    /**
     * App UI functions
     */
    @objc func setupApplicationUI() {
        let item = NSStatusBar.system.statusItem(withLength: NSStatusItem().length)
        item.button?.title = "Typyst"

        if let button = menuBarIcon.button {
            button.image = NSImage(named: "AppIcon")
            button.image?.size.height = 16
            button.image?.size.width = 16
        }

        menuBarIcon.menu = AppMenu.shared.constructMenu()
    }

    @objc func setVolume(slider: NSSlider) {
        UserDefaults.standard.set(slider.doubleValue, forKey: "lastSetVolume")
        App.instance.setVolumeTo(slider.doubleValue)
    }

    @objc func openEmailClient(_ sender: Any? = nil) {
        let service = NSSharingService(named: NSSharingService.Name.composeEmail)
        service?.recipients = ["pilotssw@gmail.com"]
        service?.subject = "Oh no! Something in Typyst isn't working correctly"
        service?.perform(withItems: ["Test Mail body"])
        NSWorkspace.shared.launchApplication("Mail")
    }

    /**
    * Load Typewriters
    */
    @objc func loadOlympiaSM3(_ sender: Any?) {
        App.instance.setCurrentTypeWriter(model: Typewriter.Model.Olympia_SM3)
        deselectAllTypewritersInMenu()
        (sender as? NSMenuItem)?.state = .on
    }

    @objc func loadRoyalModelP(_ sender: Any?) {
        App.instance.setCurrentTypeWriter(model: Typewriter.Model.Royal_Model_P)
        deselectAllTypewritersInMenu()
        (sender as? NSMenuItem)?.state = .on
    }

    @objc func loadSmithCoronaSilent(_ sender: Any?) {
        App.instance.setCurrentTypeWriter(model: Typewriter.Model.Smith_Corona_Silent)
        deselectAllTypewritersInMenu()
        (sender as? NSMenuItem)?.state = .on
    }

    @objc private func deselectAllTypewritersInMenu() {
        if let menu = menuBarIcon.menu {
            for row in menu.items[2...4] {
                row.state = .off
            }
        }
    }

    /**
    * Set current Typewriter properties
    */
    @objc func setPaperFeedEnabled(_ sender: Any?) {
        let enabled = !AppSettings.paperFeedEnabled
        (sender as? NSMenuItem)?.state = enabled ? .on : .off
        AppSettings.paperFeedEnabled = enabled
    }

    @objc func setPaperReturnEnabled(_ sender: Any?) {
        let enabled = !AppSettings.paperReturnEnabled
        (sender as? NSMenuItem)?.state = enabled ? .on : .off
        AppSettings.paperReturnEnabled = enabled
    }

    @objc func setShowModalNotifications(_ sender: Any?) {
        let enabled = !AppSettings.showModalNotifications
        (sender as? NSMenuItem)?.state = enabled ? .on : .off
        AppSettings.showModalNotifications = enabled
    }

    @objc func setTrackUsageAnalytics(_ sender: Any?) {
        let enabled = !AppSettings.logUsageAnalytics
        (sender as? NSMenuItem)?.state = enabled ? .on : .off
        AppSettings.logUsageAnalytics = enabled
    }

    @objc func setLogErrorsAndCrashes(_ sender: Any?) {
        let enabled = !AppSettings.logErrorsAndCrashes
        (sender as? NSMenuItem)?.state = enabled ? .on : .off
        AppSettings.logErrorsAndCrashes = enabled
    }
}
