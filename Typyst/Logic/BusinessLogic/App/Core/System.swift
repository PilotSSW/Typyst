//
// Created by Sean Wolford on 2/15/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import AppKit
import Foundation

class SystemFunctions {
    static func askUserToAllowSystemAccessibility() {
        App.instance.ui.alerts.keyboardAccessibility.keyCaptureUnavailableAlert(){ modalResponse in
            NSWorkspace.shared.open(URL(fileURLWithPath: "/System/Library/PreferencePanes/Security.prefPane"))
            App.instance.ui.alerts.keyboardAccessibility.addToTrustedAppsAlert(userAddedToAccessibilityCompletion: { (modalBody) in
                // Check that the app has permission to listen for key events
                listenForSystemPrefsAccessibilityAdded()
            })
        }
    }

    static func listenForSystemPrefsAccessibilityAdded() {
        let timer = RepeatingTimer(timeInterval: 0.5)
        timer.eventHandler = { [weak timer] in
            guard let timer = timer else { return }
            if AppDelegate.isAccessibilityAdded() {
                NSApplication.shared.stopModal()
                timer.suspend()
                App.instance.ui.alerts.keyboardAccessibility.typystAddedToAccessibility()
            }
        }
        timer.resume()
    }
}