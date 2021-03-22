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
    var appSettings: AppSettings = AppSettings.shared
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("App Settings")
                .font(.title)
                .foregroundColor(AppColor.textBody)
                .shadow(color: AppColor.textShadow,
                        radius: 4)
            Spacer()
                .frame(height: 14,
                       alignment: .center)

            SettingToggle(settingName: "Show modal notifications",
                          setting: $appSettings.showModalNotifications)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)

            Spacer()
                .frame(height: 8,
                       alignment: .center)

            SettingToggle(settingName: "Log Errors and Crashes",
                          setting: $appSettings.logErrorsAndCrashes)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)

            Spacer()
                    .frame(height: 8,
                           alignment: .center)

            SettingToggle(settingName: "Allow logging for typing analytics",
                          setting: $appSettings.logUsageAnalytics)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)

//            SettingToggle(settingName: "Show Dock Icon",
//                          setting: $appSettings.runAsMenubarApp)
        }
        .frame(minWidth: 200, maxWidth: .infinity)
    }
}

struct AppSettings_Previews: PreviewProvider {
    static var previews: some View {
        AppSettingsView()
    }
}
