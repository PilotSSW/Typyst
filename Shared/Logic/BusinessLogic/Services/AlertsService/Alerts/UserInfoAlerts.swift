//
// Created by Sean Wolford on 2/13/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation

class UserInfoAlerts {
    static func soundsLoaded(_ soundSets: [String]) -> Alert {
        var message = ""
        soundSets.forEach({ message += $0 + "\n" })
        if let index = message.lastIndex(of: "\n") {
            message.remove(at: index)
        }

        return Alert(
            type: .userInfo,
            title: "TypeWriter Loaded",
            message: message,
            primaryButtonText: "Cool",
            primaryAction: nil,
            secondaryButtonText: nil,
            secondaryAction: nil)
    }
}
