//
//  SettingCard.swift
//  Typyst
//
//  Created by Sean Wolford on 3/8/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct SettingsCard: View {
    var body: some View {
        Card() {
            SettingsMenu()
                .padding(18)
        }
    }
}

struct SettingsCard_Previews: PreviewProvider {
    static var previews: some View {
        SettingsCard()
            .frame(width: 400.0)
    }
}
