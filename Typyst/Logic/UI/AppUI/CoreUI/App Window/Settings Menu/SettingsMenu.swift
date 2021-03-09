//
//  SettingsMenu.swift
//  Typyst
//
//  Created by Sean Wolford on 3/8/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct SettingsMenu: View {
    var body: some View {
        CardView(cardBackgroundColor: AppColor.typeWriterMenuBackground,
                 contentView: AnyView (
                    VStack(alignment: .center, content: {
                        Spacer(minLength: 12)
                        SettingsMenuHeader()
                        Spacer(minLength: 2)
                        SettingsCard()
                        Spacer(minLength: 24)
                    })
                 ))
    }
}

struct SettingsMenu_Previews: PreviewProvider {
    static var previews: some View {
        SettingsMenu()
    }
}
