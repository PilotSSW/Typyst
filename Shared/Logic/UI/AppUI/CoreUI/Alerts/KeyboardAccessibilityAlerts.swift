//
// Created by Sean Wolford on 2/13/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import AppKit
import Foundation
import Foundation

class KeyboardAccessibilityAlerts {
    @objc func keyCaptureUnavailableAlert(completion: ((NSApplication.ModalResponse) -> ())?) {
        let question = NSLocalizedString("Uh oh.", comment: "Key press events will not be available.")
        let info = NSLocalizedString("""
                                     Typyst will be unable to receive key press events from other applications and the typewriter sounds will not be triggered.
                                     """,
                                     comment: "Typyst will be unable to receive key press events.");
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
        let question = NSLocalizedString("Add Typyst to your trusted Apps", comment: "")
        let info = NSLocalizedString("""
                                     In order for Typyst to be able to listen to key presses in other apps, it needs \
                                     to be added to the trusted applications in your system preferences. 

                                     To do this, do the following: 
                                     1. Unlock your 'System Preferences' if they are locked by clicking lock icon \
                                        in the bottom right hand corner.
                                     2. Scroll down to the Accessibility tab in the left menu.
                                     3. Click the + icon underneath your trusted apps and search the 'Applications' \
                                        folder and add 'Typyst.app'
                                     4. Close 'System Preferences' and start using Typyst.
                                     """,
                                     comment: "Typyst will be unable to receive key press events.");
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

    @objc func typystAddedToAccessibility() {
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
}