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
    var appSettings: AppSettings = RootDependencyContainer.get().appSettings

    var body: some View {
        VStack(spacing: 8) {
            Text("TypeWriter Settings")
                .bold()
                .asStyledText(with: .title)

            Spacer().frame(height: 6)

            SettingToggle(settingName: "Simulate Bell on Newline",
                          setting: $appSettings.bell)

            SettingToggle(settingName: "Simulate Lid Open and Close",
                          setting: $appSettings.lidOpenClose)

            SettingToggle(settingName: "Simulate Paper Feed",
                          setting: $appSettings.paperFeedEnabled)

            SettingToggle(settingName: "Simulate Paper Return",
                          setting: $appSettings.paperReturnEnabled)

            Spacer().frame(height: 6)
        }
    }
}

struct TypeWriterSettings_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterSettings()
    }
}
