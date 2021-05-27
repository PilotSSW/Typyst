//
// Created by Sean Wolford on 2/13/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation

class ErrorAlerts {
    static func appFailedToSaveState() -> Alert {
        Alert(
            type: .error,
            title: "System Problem",
            message: """
                     Typyst was unable to save changes to your settings. 
                     """,
            primaryButtonText: "Okay",
            primaryAction: nil,
            secondaryButtonText: nil,
            secondaryAction: nil)
    }

    static func soundsFailedToLoad(_ sounds: [String]) -> Alert {
        Alert(
            type: .error,
            title: "Some sounds were unable to be loaded",
            message: sounds.joined(separator: "\n"),
            primaryButtonText: "Okay",
            primaryAction: nil,
            secondaryButtonText: nil,
            secondaryAction: nil)
    }
//    @objc func couldntSaveAppStateAlert(_ error: NSError, _ sender: NSApplication) -> NSApplication.TerminateReply {
//        let nserror = error as NSError
//
//        // Customize this code block to include application-specific recovery steps.
//        let result = sender.presentError(nserror)
//        if (result) {
//            return .terminateCancel
//        }
//
//        let question = NSLocalizedString("Could not save changes while quitting. Quit anyway?",
//                                         comment: "Quit without saves error question message")
//        let info = NSLocalizedString("Quitting now will lose any changes you have made since the last successful save",
//                                     comment: "Quit without saves error question info");
//        let quitButton = NSLocalizedString("Quit anyway",
//                                           comment: "Quit anyway button title")
//        let cancelButton = NSLocalizedString("Cancel",
//                                             comment: "Cancel button title")
//        let alert = NSAlert()
//        alert.messageText = question
//        alert.informativeText = info
//        alert.addButton(withTitle: quitButton)
//        alert.addButton(withTitle: cancelButton)
//
//        let answer = alert.runModal()
//        if answer == .alertSecondButtonReturn {
//            return .terminateCancel
//        }
//
//        return .terminateNow
//    }
}
