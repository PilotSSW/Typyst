//
//  AppDelegate.swift
//  Typyst
//
//  Created by Sean Wolford on 1/14/19.
//  Copyright © 2019 wickedPropeller. All rights reserved.
//

import Cocoa

//@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        #if DEBUG
        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/macOSInjection10.bundle")?.load()
        #endif

        UserDefaults.standard.register(defaults: ["NSApplicationCrashOnExceptions": true])

        AppCore.instance.setup()
    }

    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        AppCore.instance.persistence.saveContext(sender)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        AppCore.instance.typeWriterHandler.unloadTypewriter()
    }

    func windowWillReturnUndoManager(window: NSWindow) -> UndoManager? {
        // Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
        AppCore.instance.persistence.persistentContainer.viewContext.undoManager
    }
}

extension AppDelegate {
    static func runAsMenubarApp(_ bool: Bool) {
        NSApp.setActivationPolicy(bool ? .accessory : .regular)
    }

    static func isAccessibilityAdded() -> Bool {
        // Ensure key capture events are available or alert user
        let opts = NSDictionary(object: kCFBooleanTrue as Any,
                                 forKey: kAXTrustedCheckOptionPrompt.takeUnretainedValue() as NSString) as CFDictionary
        return AXIsProcessTrustedWithOptions(opts)
    }
}

