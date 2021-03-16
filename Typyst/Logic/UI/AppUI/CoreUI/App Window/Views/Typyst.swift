//
//  Typyst.swift
//  Typyst
//
//  Created by Sean Wolford on 3/13/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct Typyst: View {
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            TitleCard()
                .shadow(color: AppColor.objectShadow, radius: 3)
                .layoutPriority(1)

            TypeWriterMenu(options: TypeWriterMenuOptions.typeWriters)
                .shadow(color: AppColor.objectShadow, radius: 3)
                .layoutPriority(2)

            SettingsMenu()
                .shadow(color: AppColor.objectShadow, radius: 3)
                .layoutPriority(1)

            Spacer(minLength: 4)
        }
        .frame(minWidth: 300, idealWidth: 320, maxWidth: 450,
               minHeight: 600, maxHeight: .infinity,
               alignment: .center)
        .animation(.interactiveSpring(response: 0.25,
                                      dampingFraction: 0.9,
                                      blendDuration: 0.05))
    }
}

struct Typyst_Previews: PreviewProvider {
    static var previews: some View {
        Typyst()
    }
}
