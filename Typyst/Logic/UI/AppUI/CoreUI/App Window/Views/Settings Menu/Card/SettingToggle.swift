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
                .asStyledText(with: .title3)
                .frame(maxHeight: .infinity, alignment: .leading)
            Spacer(minLength: 0)
                .background(Color.clear)
            Toggle(isOn: $setting) {}
                .toggleStyle(SwitchToggleStyle(tint: AppColor.buttonPrimary))
                .frame(alignment: .trailing)
                .shadow(color: AppColor.objectShadowLight, radius: 3)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

