//
// Created by Sean Wolford on 2/15/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation

class OSHelper {

}

#if os(macOS)
import AppKit

extension OSHelper {
    static func askUserToAllowSystemAccessibility(alertsHandler: AlertsService = AppDependencyContainer.get().alertsService) {
        let alert = KeyboardAccessibilityAlerts.keyCaptureUnavailableAlert({
            NSWorkspace.shared.open(URL(fileURLWithPath: "/System/Library/PreferencePanes/Security.prefPane"))

            let alert = KeyboardAccessibilityAlerts.addToSystemAccessibilityInstructions(dismissAction: {
                quitApp()
            }, primaryAction: {
                listenForSystemPrefsAccessibilityAdded()
            })
            alertsHandler.showAlert(alert)
        })
        alertsHandler.showAlert(alert)
    }

    static func listenForSystemPrefsAccessibilityAdded(alertsHandler: AlertsService = AppDependencyContainer.get().alertsService) {
        let timer = RepeatingTimer(timeInterval: 0.5)
        timer.eventHandler = { [weak timer] in
            guard let timer = timer else { return }
            if isAccessibilityAdded() {
                timer.suspend()
                alertsHandler.showAlert(KeyboardAccessibilityAlerts.successfullyAddedToAccessibility())

                return
            }
        }
        timer.resume()
    }

    static func isAccessibilityAdded() -> Bool {
        // Ensure key capture events are available or alert user
        let opts = NSDictionary(object: kCFBooleanTrue as Any,
                                forKey: kAXTrustedCheckOptionPrompt.takeUnretainedValue() as NSString) as CFDictionary
        return AXIsProcessTrustedWithOptions(opts)
    }

    static func runAsMenubarApp(_ bool: Bool) {
        //NSApp.setActivationPolicy(bool ? .accessory : .regular)
    }

    static func quitApp() {
        NSApplication.shared.terminate(nil)
    }
}
#endif
