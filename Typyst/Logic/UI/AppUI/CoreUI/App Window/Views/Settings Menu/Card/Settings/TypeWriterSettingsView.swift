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
                .font(.title)
                .foregroundColor(AppColor.textBody)
                .frame(maxWidth: .infinity, alignment: .center)
                .shadow(color: AppColor.textShadow,
                        radius: 4)

            Spacer()
                .frame(maxWidth: .infinity, idealHeight: 14, alignment: .center)

            SettingToggle(settingName: "Simulate Paper Feed",
                          setting: $appSettings.paperFeedEnabled)
                .frame(maxWidth: .infinity, alignment: .center)

            Spacer()
                .frame(maxWidth: .infinity, idealHeight: 8, alignment: .center)

            SettingToggle(settingName: "Simulate Paper Return",
                          setting: $appSettings.paperReturnEnabled)
        }
    }
}

struct TypeWriterSettings_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterSettings()
    }
}
