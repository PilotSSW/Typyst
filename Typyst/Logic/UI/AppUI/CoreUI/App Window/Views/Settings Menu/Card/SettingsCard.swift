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
                .layoutPriority(1)

            Divider()
                .padding(.bottom, 12)

            TypeWriterSettings()
                .layoutPriority(1)

            Divider()
                .padding(.bottom, 12)

            AppSettingsView()
                .layoutPriority(1)

            Divider()
                .padding(.bottom, 6)

            EmailButton()
                .layoutPriority(1)
        }
        .padding(.horizontal, 18)
        .padding(.top, 18)
        .padding(.bottom, 18)
        .asParentCard(withColor: AppColor.cardSecondaryBackground)
    }
}

struct SettingsCard_Previews: PreviewProvider {
    static var previews: some View {
        SettingsCard()
    }
}
