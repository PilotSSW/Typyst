//
//  AppSettings.swift
//  Typyst
//
//  Created by Sean Wolford on 3/11/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct AppSettingsView: View {
    @StateObject
    var settingsService: SettingsService = RootDependencyContainer.get().settingsService

    @StateObject
    var appDebugSettings: AppDebugSettings = RootDependencyContainer.get().appDebugSettings

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("App Settings")
                .bold()
                .asStyledText(with: .title)

            Spacer().frame(height: 6)

            #if DEBUG
            SettingToggle(settingName: "Enable debug options",
                          setting: $appDebugSettings.debugGlobal)
            #endif

            if ([.macOS].contains(OSHelper.runtimeEnvironment)) {            SettingToggle(settingName: "Play TypeWriter sounds outside of Typyst",
                          setting: $settingsService.allowExternalMacOSKeypresses)
            }

            if (![.keyboardExtension].contains(OSHelper.runtimeEnvironment)) {
                SettingToggle(settingName: "Allow Typing Statistics",
                          setting: $settingsService.logUsageAnalytics)


                SettingToggle(settingName: "Show modal notifications",
                              setting: $settingsService.showModalNotifications)
            }

            SettingToggle(settingName: "Log Errors and Crashes",
                          setting: $settingsService.logErrorsAndCrashes)

            if ([.ipadOS, .macOS].contains(OSHelper.runtimeEnvironment)) {
                SettingToggle(settingName: "Show TypeWriterView",
                              setting: $settingsService.showTypeWriterView)
            }

//            SettingToggle(settingName: "Show Dock Icon",
//                          setting: $appSettings.runAsMenubarApp)

//            Spacer().frame(height: 8)
        }
        .frame(minWidth: 200, maxWidth: .infinity)
    }
}

struct AppSettings_Previews: PreviewProvider {
    static var previews: some View {
        AppSettingsView()
    }
}
