//
//  Typyst.swift
//  Typyst
//
//  Created by Sean Wolford on 3/13/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct InterfaceAndControls: View {
    @ObservedObject var appSettings = appDependencyContainer.appSettings

    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            TitleCard()
                .layoutPriority(2)

            TypeWriterMenu()
                .layoutPriority(4)

            if (appSettings.logUsageAnalytics) {
                AnalyticsInfoCard()
                    .layoutPriority(3)
            }

            SettingsMenu()
                .layoutPriority(1)
        }
        .frame(minWidth: 300, idealWidth: 320, //maxWidth: 450,
               minHeight: 320, maxHeight: .infinity,
               alignment: .center)
    }
}

struct Typyst_Previews: PreviewProvider {
    static var previews: some View {
        InterfaceAndControls()
    }
}
