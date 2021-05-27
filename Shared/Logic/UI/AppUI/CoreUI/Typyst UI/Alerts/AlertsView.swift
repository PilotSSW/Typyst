//
//  AlertsView.swift
//  Typyst
//
//  Created by Sean Wolford on 4/20/21.
//

import SwiftUI

func createSwiftUIAlert(_ alert: Alert?,
                        alertsHandler: AlertsHandler = AppCore.instance.alertsHandler) -> SwiftUI.Alert {
    if let alert = alert {
        let title = Text(alert.title)
        var message: Text? = nil
        var primaryButton: SwiftUI.Alert.Button = .default(Text("Okay"))
        var secondaryButton: SwiftUI.Alert.Button? = nil

        if let messageText = alert.message {
            message = Text(messageText)
        }

        if let primaryText = alert.primaryButtonText {
            primaryButton = .default(Text(primaryText), action: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    alertsHandler.dismissCurrentAlert()
                    alert.primaryAction?()
                })
            })
        }

        if let secondaryText = alert.secondaryButtonText {
            secondaryButton = .cancel(Text(secondaryText), action: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    alertsHandler.dismissCurrentAlert()
                    alert.secondaryAction?()
                })
            })
        }

        return secondaryButton == nil
            ? SwiftUI.Alert(
                title: title,
                message: message,
                dismissButton: primaryButton)
            : SwiftUI.Alert(
                title: title,
                message: message,
                primaryButton: primaryButton,
                secondaryButton: secondaryButton ?? .cancel())
    }
    else {
        return SwiftUI.Alert(title: Text("Well ding."),
                             message: Text("Looks like the developer made a programming error."),
                             dismissButton: .cancel())
    }
}
