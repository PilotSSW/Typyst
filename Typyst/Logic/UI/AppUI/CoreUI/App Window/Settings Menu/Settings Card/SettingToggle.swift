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
        Toggle(isOn: $setting) {
            Text(settingName)
                .foregroundColor(AppColor.textBody)
                .font(.title3)
                .shadow(color: AppColor.textShadow, radius: 2)
        }
    }
}
