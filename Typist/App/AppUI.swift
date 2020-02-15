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
        let item = NSStatusBar.system.statusItem(withLength: NSStatusItem().length)
        item.button?.title = "Typist"

        if let button = menuBarIcon.button {
            button.image = NSImage(named: "AppIcon")
            button.image?.size.height = 16
            button.image?.size.width = 16
        }

        constructMenu()
    }

    func constructMenu() {

        // Volume slider
        let sliderView = NSView(frame: NSRect(x: 0, y: 0, width: 500, height: 25))

        let volumeLabel = NSTextField(frame: NSRect(x: 20, y: 0, width: 150, height: 25))
        volumeLabel.stringValue = "Volume"
        volumeLabel.isBordered = false;
        volumeLabel.isBezeled = false;
        volumeLabel.backgroundColor = .clear
        volumeLabel.textColor = .white
        volumeLabel.font = menu.font
        sliderView.addSubview(volumeLabel)

        let slider = NSSlider(frame: NSRect(x: 100, y: 0, width: 380, height: 25))
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
        UserDefaults.standard.set(slider.doubleValue, forKey: "lastSetVolume")
        App.instance.setVolumeTo(slider.doubleValue)
    }

    /**
    * Load Typewriters
    */
    @objc func loadOlympiaSM3(_ sender: Any?) {
        App.instance.setCurrentTypeWriter(model: Typewriter.Model.Olympia_SM3)
    }

    @objc func loadRoyalModelP(_ sender: Any?) {
        App.instance.setCurrentTypeWriter(model: Typewriter.Model.Royal_Model_P)
    }

    @objc func loadSmithCoronaSilent(_ sender: Any?) {
        App.instance.setCurrentTypeWriter(model: Typewriter.Model.Smith_Corona_Silent)
    }

    /**
    * Set current Typewriter properties
    */
    @objc func setPaperFeedEnabled(_ sender: Any?) {
        App.instance.simulatePaperFeed(enabled: !(App.instance.isPaperFeedEnabled() ?? false))
    }

    @objc func setPaperReturnEnabled(_ sender: Any?) {
        App.instance.simulatePaperReturn(enabled: !(App.instance.isPaperReturnEnabled() ?? false))
    }

    @objc func setShowModalNotifications(_ sender: Any?) {
        App.instance.showModalNotifications(enabled: !(App.instance.isModalNotificationsEnabled() ?? false))
    }
    
    /**
    * Show alerts
    */
    @objc func keyCaptureUnavailableAlert(completion: ((NSApplication.ModalResponse) -> ())?) {
        let question = NSLocalizedString("Uh oh.", comment: "Key press events will not be available.")
        let info = NSLocalizedString("""
                                     Typist will be unable to receive key press events from other applications and the typewriter sounds will not be triggered.
                                     """,
                comment: "Typist will be unable to receive key press events.");
        let button = NSLocalizedString("Okay", comment: "Close alert")
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = info
        alert.addButton(withTitle: button)
        if let window = NSApplication.shared.mainWindow {
            alert.beginSheetModal(for: window,
                    completionHandler: completion)
        } else {
            completion?(alert.runModal())
        }
    }

    @objc func addToTrustedAppsAlert(completion: ((NSApplication.ModalResponse) -> ())?) {
        let question = NSLocalizedString("Add Typist to your trusted Apps", comment: "")
        let info = NSLocalizedString("""
                                     In order for Typist to be able to listen to key presses in other apps, it needs to be added to the trusted applications in your system preferences. 
                                     """,
                comment: "Typist will be unable to receive key press events.");
        let button = NSLocalizedString("Okay", comment: "Close alert")
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = info
        alert.addButton(withTitle: button)
        if let window = NSApplication.shared.mainWindow {
            alert.beginSheetModal(for: window,
                    completionHandler: completion)
        } else {
            _ = alert.runModal()
        }
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

    @objc func typeWriterSoundsLoadedAlert(_ soundSets: [String]) {
        if App.instance.isModalNotificationsEnabled() {
            let alert = NSAlert()
            alert.messageText = "Loaded sounds"

            var message = ""
            soundSets.forEach({ message += $0 + "\n" })
            if let index = message.lastIndex(of: "\n") {
                message.remove(at: index)
            }
            alert.informativeText = message
            alert.runModal()
        }
    }

    @objc func couldntFindSoundsAlert(sounds: [String]) {
        let alert = NSAlert()
        alert.messageText = "Some sounds were unable to be loaded"

        var message = ""
        sounds.forEach({ message += $0 })
        alert.informativeText = message
        alert.runModal()
    }
}
