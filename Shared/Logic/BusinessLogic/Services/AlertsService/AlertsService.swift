//
// Created by Sean Wolford on 4/20/21.
//

import Combine
import Foundation

class AlertsService: Loggable, ObservableObject {
    private var appSettings: AppSettings
    private var appDebugSettings: AppDebugSettings

    @Published var currentAlert: Alert?
    private var alertQueue: [Alert] = []

    init(appSettings: AppSettings,
         appDebugSettings: AppDebugSettings) {
        self.appSettings = appSettings
        self.appDebugSettings = appDebugSettings
    }

    func showAlert(_ alert: Alert, priorityFirstInQueue: Bool = false) {
        logEvent(.debug, "Alert added -- \(alert)")

        let isNonCriticalAlert = [.userInfo].contains(alert.type) && !appSettings.showModalNotifications
        let isIgnoredDeveloperAlert = [.developer].contains(alert.type) && !appDebugSettings.debugGlobal

        if (isNonCriticalAlert || isIgnoredDeveloperAlert) { return }

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
        if alertQueue.count > 0 {
            currentAlert = alertQueue.remove(at: 0)
        }
        else {
            currentAlert = nil
        }
    }
}

protocol Alertable {}
extension Alertable {
    func showAlert(_ alert: Alert, priorityFirstInQueue: Bool = false,
                   alertsService: AlertsService = AppDependencyContainer.get().alertsService) {
        alertsService.showAlert(alert, priorityFirstInQueue: priorityFirstInQueue)
    }
}
