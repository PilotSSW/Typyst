//
//  AppSettingsCommands.swift
//  Typyst
//
//  Created by Sean Wolford on 6/11/21.
//

import Foundation
import SwiftUI

struct AppSettingsCommands: View {
    @ObservedObject
    var settingsService = RootDependencyContainer.get().settingsService

    @ObservedObject
    var appDebugSettings: AppDebugSettings = RootDependencyContainer.get().appDebugSettings

    var body: some View {
        VStack {
            Text("App Settings")

            Divider()

            SettingToggle(settingName: "Show informational notifications and alerts",
                          setting: $settingsService.showModalNotifications)
                .keyboardShortcut("1")

            SettingToggle(settingName: "Send performance and error reports to developer",
                          setting: $settingsService.logErrorsAndCrashes)
                .keyboardShortcut("2")
        }
    }
}
