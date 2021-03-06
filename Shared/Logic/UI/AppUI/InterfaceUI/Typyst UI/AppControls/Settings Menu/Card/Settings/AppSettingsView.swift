//
//  AppSettings.swift
//  Typyst
//
//  Created by Sean Wolford on 3/11/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct AppSettingsView: View {
    @ObservedObject
    var appSettings: AppSettings = RootDependencyContainer.get().appSettings

    @ObservedObject
    var appDebugSettings: AppDebugSettings = RootDependencyContainer.get().appDebugSettings
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("App Settings")
                .bold()
                .asStyledText(with: .title)

            Spacer().frame(height: 14)

            #if DEBUG
            SettingToggle(settingName: "Enable debug options",
                          setting: $appDebugSettings.debugGlobal)

            Spacer().frame(height: 8)
            #endif

            SettingToggle(settingName: "Allow Typing Statistics",
                          setting: $appSettings.logUsageAnalytics)

            Spacer().frame(height: 8)

            SettingToggle(settingName: "Show modal notifications",
                          setting: $appSettings.showModalNotifications)

            Spacer().frame(height: 8)

            SettingToggle(settingName: "Log Errors and Crashes",
                          setting: $appSettings.logErrorsAndCrashes)

            Spacer().frame(height: 8)

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
