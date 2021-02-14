//
// Created by Sean Wolford on 2/13/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import AppKit
import Cocoa
import Foundation

class UserInfoAlerts {
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
}