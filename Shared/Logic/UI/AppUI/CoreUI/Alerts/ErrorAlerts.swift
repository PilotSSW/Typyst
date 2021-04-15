//
// Created by Sean Wolford on 2/13/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import AppKit
import Cocoa
import Foundation

class ErrorAlerts {
    @objc func couldntSaveAppStateAlert(_ error: NSError, _ sender: NSApplication) -> NSApplication.TerminateReply {
        let nserror = error as NSError

        // Customize this code block to include application-specific recovery steps.
        let result = sender.presentError(nserror)
        if (result) {
            return .terminateCancel
        }

        let question = NSLocalizedString("Could not save changes while quitting. Quit anyway?",
                                         comment: "Quit without saves error question message")
        let info = NSLocalizedString("Quitting now will lose any changes you have made since the last successful save",
                                     comment: "Quit without saves error question info");
        let quitButton = NSLocalizedString("Quit anyway",
                                           comment: "Quit anyway button title")
        let cancelButton = NSLocalizedString("Cancel",
                                             comment: "Cancel button title")
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

    @objc func couldntFindSoundsAlert(sounds: [String]) {
        let alert = NSAlert()
        alert.messageText = "Some sounds were unable to be loaded"

        var message = ""
        sounds.forEach({ message += $0 })
        alert.informativeText = message
        alert.runModal()
    }
}
