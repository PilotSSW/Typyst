//
//  SettingToggle.swift
//  Typyst
//
//  Created by Sean Wolford on 3/8/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

struct SettingToggle: View {
    var settingName: String = ""
    @Binding var setting: Bool

    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            Text(settingName)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .foregroundColor(AppColor.textBody)
                .font(.title3)
                .frame(maxHeight: .infinity, alignment: .leading)
                .shadow(color: AppColor.textShadow, radius: 2)
            Spacer(minLength: 0)
                .background(Color.clear)
            Toggle(isOn: $setting) {}
                .toggleStyle(SwitchToggleStyle(tint: AppColor.buttonPrimary))
                .frame(maxHeight: .infinity, alignment: .trailing)
                .accentColor(AppColor.buttonPrimary)
                .shadow(color: AppColor.objectShadow, radius: 2)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

//struct SettingToggle_Previews: PreviewProvider {
//    @ObservedObject
//    var appSettings: AppSettings = AppSettings.shared
//
//    static var previews: some View {
//        SettingToggle(setting: appSettings.$paperFeedEnabled)
//    }
//}
