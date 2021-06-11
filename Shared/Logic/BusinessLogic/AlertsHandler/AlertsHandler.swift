//
// Created by Sean Wolford on 4/20/21.
//

import Combine
import Foundation

class AlertsHandler: ObservableObject {
    @Published var currentAlert: Alert?
    private var alertQueue: [Alert] = []

    func showAlert(_ alert: Alert, priorityFirstInQueue: Bool = false) {
        let checkedTypes: [AlertType] = [.developer, .userInfo]
        if checkedTypes.contains(alert.type) && !appDependencyContainer.appSettings.showModalNotifications {
            return
        }

        if currentAlert != nil {
            priorityFirstInQueue
                ? alertQueue.insert(alert, at: 0)
                : alertQueue.append(alert)
        }
        else {
            currentAlert = alert
        }
    }

    func dismissCurrentAlert() {
        currentAlert = nil

        if alertQueue.count > 0 {
            currentAlert = alertQueue.remove(at: 0)
        }
    }
}

protocol Alertable {}
extension Alertable {
    func showAlert(_ alert: Alert, priorityFirstInQueue: Bool = false,
                   alertsHandler: AlertsHandler = appDependencyContainer.alertsHandler) {
        alertsHandler.showAlert(alert, priorityFirstInQueue: priorityFirstInQueue)
    }
}
