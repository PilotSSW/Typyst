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
        VStack(alignment: .center) {
            VolumeSetting(appSettings: appSettings)

            Divider()
                .padding(.bottom, 6)

            TypeWriterSettings()

            Divider()
                .padding(.vertical, 6)

            AppSettingsView()

            Divider()

            EmailButton()
        }
        .padding(.horizontal, 18)
        .padding(.top, 18)
        .padding(.bottom, 6)
        .asChildCard(withColor: AppColor.secondaryBackground)
    }
}

struct SettingsCard_Previews: PreviewProvider {
    static var previews: some View {
        SettingsCard()
    }
}
