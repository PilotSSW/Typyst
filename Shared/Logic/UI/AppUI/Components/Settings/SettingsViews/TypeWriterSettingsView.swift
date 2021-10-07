//
//  TypeWriterSettings.swift
//  Typyst
//
//  Created by Sean Wolford on 3/11/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct TypeWriterSettings: View {
    @StateObject
    var settings: SettingsService = RootDependencyContainer.get().settingsService

    var body: some View {
        VStack(spacing: 8) {
            Text("TypeWriter Settings")
                .bold()
                .asStyledText(with: .title)

            Spacer().frame(height: 6)

            SettingToggle(settingName: "Simulate Bell on Newline",
                          setting: $settings.bell)

            SettingToggle(settingName: "Simulate Lid Open and Close",
                          setting: $settings.lidOpenClose)

            SettingToggle(settingName: "Simulate Paper Feed",
                          setting: $settings.paperFeedEnabled)

            SettingToggle(settingName: "Simulate Paper Return",
                          setting: $settings.paperReturnEnabled)

            Spacer().frame(height: 6)
        }
    }
}

struct TypeWriterSettings_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterSettings()
    }
}
