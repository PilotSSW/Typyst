//
//  AppDelegate.swift
//  Typist
//
//  Created by Sean Wolford on 1/14/19.
//  Copyright © 2019 wickedPropeller. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let menu = NSMenu()
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    let popover = NSPopover()
    var app: App?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        let item = NSStatusBar.system.statusItem(withLength: NSStatusItem().length)
        item.button?.title = "Typyst"
        // Insert code here to initialize your application
        setupApplication()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Typist")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving and Undo support

    @IBAction func saveAction(_ sender: AnyObject?) {
        // Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
        let context = persistentContainer.viewContext

        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing before saving")
        }
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Customize this code block to include application-specific recovery steps.
                let nserror = error as NSError
                NSApplication.shared.presentError(nserror)
            }
        }
    }

    func windowWillReturnUndoManager(window: NSWindow) -> UndoManager? {
        // Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
        return persistentContainer.viewContext.undoManager
    }

    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        // Save changes in the application's managed object context before the application terminates.
        let context = persistentContainer.viewContext
        
        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing to terminate")
            return .terminateCancel
        }
        
        if !context.hasChanges {
            return .terminateNow
        }
        
        do {
            try context.save()
        } catch {
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
        }
        // If we got here, it is time to quit.
        return .terminateNow
    }
    
    
    /**
     * App functions
     */
    
    @objc func setupApplication() {
        
        if let button = statusItem.button {
            button.image = NSImage(named: "AppIcon")
            button.image?.size.height = 16
            button.image?.size.width = 16
        }

        let opts = NSDictionary(object: kCFBooleanTrue, forKey: kAXTrustedCheckOptionPrompt.takeUnretainedValue() as NSString) as CFDictionary
        guard AXIsProcessTrustedWithOptions(opts) == true else {
            let question = NSLocalizedString("Uh oh.", comment: "Key press events will not be available.")
            let info = NSLocalizedString("Typist will be unable to receive key press events from other applications and the typewriter sounds will not be triggered.",
                                         comment: "Typist will be unable to receive key press events.");
            let button = NSLocalizedString("Okay", comment: "Close alert")
            let alert = NSAlert()
            alert.messageText = question
            alert.informativeText = info
            alert.addButton(withTitle: button)
            _ = alert.runModal()
            return
        }

        constructMenu()
        app = App()
    }
    
    func constructMenu() {
        menu.addItem(NSMenuItem(title: "Load Olympia SM3", action: #selector(AppDelegate.loadOlympiaSM3(_:)), keyEquivalent: "1"))
        menu.addItem(NSMenuItem(title: "Load Royal Model P", action: #selector(AppDelegate.loadRoyalModelP(_:)), keyEquivalent: "2"))
        menu.addItem(NSMenuItem(title: "Load Smith Corona Silent", action: #selector(AppDelegate.loadSmithCoronaSilent(_:)), keyEquivalent: "3"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Simulate paper return / new line every 80 characters", action: #selector(AppDelegate.setPaperReturnEnabled), keyEquivalent: "4"))
        menu.addItem(NSMenuItem(title: "Simulate paper feed every 25 newlines", action: #selector(AppDelegate.setPaperFeedEnabled(_:)), keyEquivalent: "0"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit Typist", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))

        statusItem.menu = menu
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
        app?.simulatePaperFeed(enabled: !(app?.paperFeedEnabled() ?? true))
    }
    
    @objc func setPaperReturnEnabled() {
        app?.simulatePaperReturn(enabled: !(app?.paperReturnEnabled() ?? true))
    }
}

