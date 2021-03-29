//
//  TypeWriterSettings.swift
//  Typyst
//
//  Created by Sean Wolford on 3/11/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct TypeWriterSettings: View {
    @ObservedObject
    var appSettings: AppSettings = AppSettings.shared

    var body: some View {
        VStack {
            Text("TypeWriter Settings")
                .bold()
                .asStyledText(with: .title)

            Spacer().frame(height: 14)

            SettingToggle(settingName: "Simulate Bell on Newline",
                          setting: $appSettings.bell)

            Spacer().frame(height: 8)

            SettingToggle(settingName: "Simulate Paper Feed",
                          setting: $appSettings.paperFeedEnabled)

            Spacer().frame(height: 8)

            SettingToggle(settingName: "Simulate Paper Return",
                          setting: $appSettings.paperReturnEnabled)

            Spacer().frame(height: 8)
        }
    }
}

struct TypeWriterSettings_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterSettings()
    }
}
