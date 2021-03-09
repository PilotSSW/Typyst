//
//  SettingsCard.swift
//  Typyst
//
//  Created by Sean Wolford on 3/8/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import Combine
import SwiftUI

struct SettingsCard: View {
    @ObservedObject
    var appSettings: AppSettings = AppSettings.shared

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("Main Volume")
                    .foregroundColor(AppColor.textBody)
                    .font(.title2)
                    .shadow(color: AppColor.typeWriterCardHeaderBackground, radius: 4)
                Spacer(minLength: 12)
                Slider(value: $appSettings.volumeSetting)
            }
            .padding(.bottom, -6)

            Divider()
                .padding(.vertical, 6)

            Text("TypeWriter Settings")
                .font(.title)
                .shadow(color: AppColor.typeWriterCardHeaderBackground, radius: 4)
            SettingToggle(settingName: "Simulate Paper Feed", setting: $appSettings.paperFeedEnabled)
            SettingToggle(settingName: "Simulate Paper Return", setting: $appSettings.paperReturnEnabled)

            Divider()
                .padding(.vertical, 6)

            Text("App Settings")
                .font(.title)
                .shadow(color: AppColor.typeWriterCardHeaderBackground, radius: 4)
            SettingToggle(settingName: "Show modal notifications", setting: $appSettings.showModalNotifications)
            SettingToggle(settingName: "Show Dock Icon", setting: $appSettings.runAsMenubarApp)
        }
        .padding(.horizontal, 24)
    }
}

struct SettingsCard_Previews: PreviewProvider {
    static var previews: some View {
        SettingsCard()
    }
}
