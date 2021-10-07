//
//  Typyst.swift
//  Typyst
//
//  Created by Sean Wolford on 3/13/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct InterfaceAndControls: View {
    @StateObject
    var viewModel = InterfaceAndControlsViewModel()

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .center, spacing: 12) {
                if viewModel.showTitleCard {
                    TitleCard()
                        .layoutPriority(5)
                    Spacer()
                }

                if viewModel.showDocumentsCard {
                    DocumentsCard(onTitleClick: {
                        viewModel.requestFullViewFor(.documentsCard)
                    }, isFullHeight: $viewModel.documentsCardFullHeight)
                    .layoutPriority(3)
                    Spacer()
                }

                if viewModel.showTypeWriterMenuCard {
                    TypeWriterMenuCard(onTitleClick: {
                        viewModel.requestFullViewFor(.typeWriterMenuCard)
                    }, isFullHeight: $viewModel.typeWriterCardFullHeight)
                    .layoutPriority(4)
                    Spacer()
                }

                if viewModel.showAnalyticsInfoCard {
                    AnalyticsInfoCard(onTitleClick: {
                        viewModel.requestFullViewFor(.analyticsInfoCard)
                    })
                    .layoutPriority(4)
                    Spacer()
                }

                if viewModel.showSettingsCard {
                    SettingsCard()
                        .layoutPriority(2)
                }

                Spacer(minLength: 0)
                    .layoutPriority(1)
            }
            .padding(12)
            .animation(.interactiveSpring(response: 0.33, dampingFraction: 0.8, blendDuration: 1.75))
        }
        .frame(minWidth: 275, idealWidth: 380,
               maxWidth: OSHelper.runtimeEnvironment == .iOS ? .infinity : 380,
               minHeight: 275, maxHeight: .infinity,
               alignment: .center)
    }
}

struct Typyst_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = InterfaceAndControlsViewModel()
        return InterfaceAndControls(viewModel: viewModel)
            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/, height: 1800))
    }
}
