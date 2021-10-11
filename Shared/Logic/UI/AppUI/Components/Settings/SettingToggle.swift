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
    var setting: Binding<Bool>

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Text(settingName)
                .lineLimit(nil)
                .asStyledText(with: .title3, isCompressable: true)
                .frame(maxHeight: .infinity, alignment: .leading)
                .layoutPriority(1)

            Spacer()

            Toggle("", isOn: setting.animation())
                .toggleStyle(SwitchToggleStyle(tint: AppColor.buttonPrimary))
                .frame(alignment: .trailing)
// Remove shadow - broken on iOS ???
//                .shadow(color: AppColor.objectShadowLight.opacity(ShadowIntensity.strong.rawValue), radius: 3)
        }
        .frame(maxWidth: .infinity)
    }
}

struct SettingToggle_Previews: PreviewProvider {
    static var previews: some View {
        return SettingToggle(settingName: "Monkey Business",
                             setting: .constant(true))
    }
}

