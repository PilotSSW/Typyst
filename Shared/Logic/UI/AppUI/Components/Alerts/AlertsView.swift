//
//  AlertsView.swift
//  Typyst
//
//  Created by Sean Wolford on 4/20/21.
//

import Foundation
import struct SwiftUI.Alert
import struct SwiftUI.Text

final class AlertUI: Loggable {
    static let instance = AlertUI()

    private init() {}

    func createSwiftUIAlert(_ alert: Alert,
                            alertsService: AlertsService) -> SwiftUI.Alert {
        let title = Text(alert.title)
        var message: Text? = nil
        var primaryButton: SwiftUI.Alert.Button = .default(Text("Okay"))
        var secondaryButton: SwiftUI.Alert.Button? = nil

        if let messageText = alert.message {
            message = Text(messageText)
        }

        if let primaryText = alert.primaryButtonText {
            primaryButton = .default(Text(primaryText), action: {
                self.logEvent(.debug, "Alert primary button pressed", context: [alert])

                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    alertsService.dismissCurrentAlert()
                    alert.primaryAction?()
                    self.logEvent(.trace, "Alert primary action run", context: [alert])
                })
            })
        }

        if let secondaryText = alert.secondaryButtonText {
            secondaryButton = .cancel(Text(secondaryText), action: {
                self.logEvent(.debug, "Alert secondary button pressed", context: [alert])

                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    alertsService.dismissCurrentAlert()
                    alert.secondaryAction?()
                    self.logEvent(.trace, "Alert secondary action run", context: [alert])
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
}
