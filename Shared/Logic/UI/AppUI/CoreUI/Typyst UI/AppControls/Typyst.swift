//
//  Typyst.swift
//  Typyst
//
//  Created by Sean Wolford on 3/13/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct Typyst: View {
    @ObservedObject
    var appSettings = AppSettings.shared

    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            TitleCard()
                .layoutPriority(2)

            if (appSettings.logUsageAnalytics) {
                AnalyticsInfoCard()
                    .layoutPriority(3)
            }

            TypeWriterMenu()
                .layoutPriority(4)

            SettingsMenu()
                .layoutPriority(1)
        }
        .frame(minWidth: 300, idealWidth: 320, maxWidth: 450,
               minHeight: 320, maxHeight: .infinity,
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
