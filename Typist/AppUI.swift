//
//  AppUI.swift
//  Typist
//
//  Created by Sean Wolford on 2/1/20.
//  Copyright © 2020 wickedPropeller. All rights reserved.
//

import Foundation
import Cocoa

class AppUI {
    let menu = NSMenu()
    let menuBarIcon = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    let popover = NSPopover()

    /**
     * App UI functions
     */

    @objc func setupApplicationUI() {

        if let button = menuBarIcon.button {
            button.image = NSImage(named: "AppIcon")
            button.image?.size.height = 16
            button.image?.size.width = 16
        }

        constructMenu()
    }

    func constructMenu() {

        // Volume slider
        let sliderView = NSView(frame: NSRect(x: 0, y: 0, width: 500, height: 40))

        let volumeLabel = NSTextField(frame: NSRect(x: 20, y: 20, width: 150, height: 80))
        volumeLabel.stringValue = "Volume"
        volumeLabel.isBordered = false;
        volumeLabel.isBezeled = false;
        volumeLabel.backgroundColor = .clear
        volumeLabel.textColor = .white
        sliderView.addSubview(volumeLabel)

        let slider = NSSlider(frame: NSRect(x: 100, y: 0, width: 380, height: 40))
        slider.target = self
        slider.action = #selector(AppUI.setVolume)
        slider.floatValue = UserDefaults.standard.float(forKey: "lastSetVolume")
        sliderView.addSubview(slider)

        let volumeItem = NSMenuItem()
        volumeItem.view = sliderView

        menu.addItem(volumeItem)

        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Load Olympia SM3", action: #selector(AppUI.loadOlympiaSM3(_:)), keyEquivalent: "1"))
        menu.addItem(NSMenuItem(title: "Load Royal Model P", action: #selector(AppUI.loadRoyalModelP(_:)), keyEquivalent: "2"))
        menu.addItem(NSMenuItem(title: "Load Smith Corona Silent", action: #selector(AppUI.loadSmithCoronaSilent(_:)), keyEquivalent: "3"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Simulate paper return / new line every 80 characters", action: #selector(AppUI.setPaperReturnEnabled(_:)), keyEquivalent: "8"))
        menu.addItem(NSMenuItem(title: "Simulate paper feed every 25 newlines", action: #selector(AppUI.setPaperFeedEnabled(_:)), keyEquivalent: "9"))
        menu.addItem(NSMenuItem(title: "Show modal notifications", action: #selector(AppUI.setShowModalNotifications(_:)), keyEquivalent: "0"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit Typist", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))

        menuBarIcon.menu = menu
    }

    @objc func setVolume(slider: NSSlider) {
        UserDefaults.standard.set(slider.floatValue, forKey: "lastSetVolume")
        app?.loadedTypewriter?.volume = slider.floatValue
    }

    @objc func loadOlympiaSM3(_ sender: Any?) {
        app?.currentTypeWriter(model: TypewriterModel.Olympia_SM3)
    }

    @objc func loadRoyalModelP(_ sender: Any?) {
        app?.currentTypeWriter(model: TypewriterModel.Royal_Model_P)
    }

    @objc func loadSmithCoronaSilent(_ sender: Any?) {
        app?.currentTypeWriter(model: TypewriterModel.Smith_Corona_Silent)
    }

    @objc func setPaperFeedEnabled(_ sender: Any?) {
        app?.simulatePaperFeed(enabled: !(app?.paperFeedEnabled() ?? false))
    }

    @objc func setPaperReturnEnabled(_ sender: Any?) {
        app?.simulatePaperReturn(enabled: !(app?.paperReturnEnabled() ?? false))
    }

    @objc func setShowModalNotifications(_ sender: Any?) {
        app?.showModalNotifications(enabled: !(app?.modalNotificationsEnabled() ?? false))
    }

    @objc func keyCaptureUnavailableAlert() {
        let question = NSLocalizedString("Uh oh.", comment: "Key press events will not be available.")
        let info = NSLocalizedString("Typist will be unable to receive key press events from other applications and the typewriter sounds will not be triggered.",
                comment: "Typist will be unable to receive key press events.");
        let button = NSLocalizedString("Okay", comment: "Close alert")
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = info
        alert.addButton(withTitle: button)
        _ = alert.runModal()
    }

    @objc func couldntSaveAppStateAlert(_ error: NSError, _ sender: NSApplication) -> NSApplication.TerminateReply {
        let nserror = error as NSError

        // Customize this code block to include application-specific recovery steps.
        let result = sender.presentError(nserror)
        if (result) {
            return .terminateCancel
        }

        let question = NSLocalizedString("Could not save changes while quitting. Quit anyway?", comment: "Quit without saves error question message")
        let info = NSLocalizedString("Quitting now will lose any changes you have made since the last successful save", comment: "Quit without saves error question info");
        let quitButton = NSLocalizedString("Quit anyway", comment: "Quit anyway button title")
        let cancelButton = NSLocalizedString("Cancel", comment: "Cancel button title")
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = info
        alert.addButton(withTitle: quitButton)
        alert.addButton(withTitle: cancelButton)

        let answer = alert.runModal()
        if answer == .alertSecondButtonReturn {
            return .terminateCancel
        }

        return .terminateNow
    }
}
