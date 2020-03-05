//
//  AppUI.swift
//  Typist
//
//  Created by Sean Wolford on 2/1/20.
//  Copyright © 2020 wickedPropeller. All rights reserved.
//

import Foundation
import Cocoa
import AppKit

class AppUI {
    let menuBarIcon = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    var menu: NSMenu

    init() {
        menu = NSMenu()
        menuBarIcon.menu = menu
        menuBarIcon.target = self
    }

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

    @objc func constructMenu(_ sender: Any? = nil) {
        menu = NSMenu()
        menuBarIcon.target = self
        menuBarIcon.menu = menu
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
        slider.target = self
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

        if AppSettings.logUsageAnalytics {
            let analytics = KeyAnalytics.shared?.defaultAnalytics()
            analytics?.enumerated().forEach({

                var numMinutes = 0
                switch $0.offset {
                case 0: numMinutes = 1
                case 1: numMinutes = 5
                case 2: numMinutes = 10
                case 3: numMinutes = 30
                case 4: numMinutes = 60
                default: numMinutes = 0
                }
                let title = """
                            Past \(numMinutes)\n minutes -- 
                            \($0.element.0) total key presses -- 
                            \($0.element.1) average key presses every second
                            \n
                            """
                menu.addItem(NSMenuItem(title: title, action: nil, keyEquivalent: ""))
            })
            menu.addItem(NSMenuItem.separator())
        }

        let menuItemFirebase = NSMenuItem(title: "Share errors and crashes with developer", action: #selector(AppUI.setLogErrorsAndCrashes(_:)), keyEquivalent: "0")
        menuItemFirebase.state = AppSettings.logUsageAnalytics ? .on : .off
        menu.addItem(menuItemFirebase)
        menu.addItem(NSMenuItem.separator())

        let menuItemQuit = NSMenuItem(title: "Quit Typist", action: #selector(App.quit(_:)), keyEquivalent: "q")
        menu.addItem(menuItemQuit)

        menu.items.forEach({
            $0.target = self
            $0.isEnabled = AppDelegate.isAccessibilityAdded()
        })
    }

    private func triggerMenuItem(sender: Any, func: (() -> ())) {

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

    @objc func addToTrustedAppsAlert(userAddedToAccessibilityCompletion: ((NSAlert) -> ())?) {
        let question = NSLocalizedString("Add Typist to your trusted Apps", comment: "")
        let info = NSLocalizedString("""
                                     In order for Typist to be able to listen to key presses in other apps, it needs \
                                     to be added to the trusted applications in your system preferences. 

                                     To do this, do the following: 
                                     1. Unlock your 'System Preferences' if they are locked by clicking lock icon \
                                        in the bottom right hand corner.
                                     2. Scroll down to the Accessibility tab in the left menu.
                                     3. Click the + icon underneath your trusted apps and search the 'Applications' \
                                        folder and add 'Typist.app'
                                     4. Close 'System Preferences' and start using Typist.
                                     """,
                comment: "Typist will be unable to receive key press events.");
        let button = NSLocalizedString("Done", comment: "Close alert")
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = info
        alert.addButton(withTitle: button)
        if let window = NSApplication.shared.mainWindow {
            alert.beginSheetModal(for: window,
                    completionHandler: nil)
        } else {
            _ = alert.runModal()
        }

        userAddedToAccessibilityCompletion?(alert)
    }

    @objc func typistAddedToAccessibility() {
        let alert = NSAlert()
        alert.messageText = ""
        alert.informativeText = ""
        let button = NSLocalizedString("Awesome!", comment: "Close alert")
        alert.addButton(withTitle: button)
        if let window = NSApplication.shared.mainWindow {
            alert.beginSheetModal(for: window,
                    completionHandler: nil)
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
        if AppSettings.showModalNotifications {
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
