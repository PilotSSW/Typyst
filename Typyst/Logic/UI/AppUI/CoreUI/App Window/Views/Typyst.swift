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
            TypeWriterMenu(options: TypeWriterMenuOptions.typeWriters)
                .shadow(color: AppColor.objectShadow, radius: 3)
                .layoutPriority(1)

            SettingsMenu()
                .shadow(color: AppColor.objectShadow, radius: 3)

            TitleCard()
                .shadow(color: AppColor.objectShadow, radius: 3)
            Spacer(minLength: 4)
        }
//        .frame(height: 2800, alignment: .center)
        .frame(minWidth: 300, idealWidth: 320, maxWidth: 3840,
               minHeight: 300, idealHeight: 1200, maxHeight: 3840)
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
