//
//  SettingsMenu.swift
//  Typyst
//
//  Created by Sean Wolford on 3/8/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import Combine
import SwiftUI

struct SettingsMenu: View {
    var body: some View {
        VStack(alignment: .center, spacing: 6) {
            VolumeSetting()

            Divider()
                .padding(.bottom, 6)

            TypeWriterSettings()

            Divider()
                .padding(.bottom, 6)

            AppSettingsView()

            Divider()
                .padding(.bottom, 6)

            EmailButton()

            Spacer(minLength: 0)
                .layoutPriority(1)
        }
    }
}

struct SettingsMenu_Previews: PreviewProvider {
    static var previews: some View {
        SettingsMenu()
    }
}
