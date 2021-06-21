//
// Created by Sean Wolford on 2/15/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import AppKit
import Foundation

class SystemFunctions {
    static func askUserToAllowSystemAccessibility(alertsHandler: AlertsService = appDependencyContainer.alertsService) {
        let alert = KeyboardAccessibilityAlerts.keyCaptureUnavailableAlert({
            NSWorkspace.shared.open(URL(fileURLWithPath: "/System/Library/PreferencePanes/Security.prefPane"))

            let alert = KeyboardAccessibilityAlerts.addToSystemAccessibilityInstructions(dismissAction: {
                //appCore.macOSUI.quit(nil)
            }, primaryAction: {
                listenForSystemPrefsAccessibilityAdded()
            })
            alertsHandler.showAlert(alert)
        })
        alertsHandler.showAlert(alert)
    }

    static func listenForSystemPrefsAccessibilityAdded(alertsHandler: AlertsService = appDependencyContainer.alertsService) {
        let timer = RepeatingTimer(timeInterval: 0.5)
        timer.eventHandler = { [weak timer] in
            guard let timer = timer else { return }
            if AppDelegate.isAccessibilityAdded() {
                timer.suspend()
                alertsHandler.showAlert(KeyboardAccessibilityAlerts.successfullyAddedToAccessibility())
            }
        }
        timer.resume()
    }
}
