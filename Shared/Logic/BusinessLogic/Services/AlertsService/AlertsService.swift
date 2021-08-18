//
// Created by Sean Wolford on 4/20/21.
//

import Combine
import Foundation

final class AlertsService: Loggable, ObservableObject {
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
        let isNonCriticalAlert = [.userInfo].contains(alert.type) && !appSettings.showModalNotifications
        let isIgnoredDeveloperAlert = [.developer].contains(alert.type) && !appDebugSettings.debugGlobal

        if (isNonCriticalAlert || isIgnoredDeveloperAlert) {
            logEvent(.debug, "Alert service - ignored", context: alert)

            return
        }

        if currentAlert != nil {
            logEvent(.debug, "Alert service - queued", context: alert)

            priorityFirstInQueue
                ? alertQueue.insert(alert, at: 0)
                : alertQueue.append(alert)
        }
        else {
            logEvent(.debug, "Alert service - shown", context: alert)
            currentAlert = alert
        }
    }

    func dismissCurrentAlert() {
        if alertQueue.count > 0 {
            logEvent(.debug, "Alert service - next in queue",context: currentAlert)

            currentAlert = alertQueue.remove(at: 0)
        }
        else {
            logEvent(.debug, "Alert service - dismissed", context: currentAlert)

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
