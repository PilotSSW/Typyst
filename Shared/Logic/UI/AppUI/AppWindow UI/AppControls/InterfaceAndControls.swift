//
//  Typyst.swift
//  Typyst
//
//  Created by Sean Wolford on 3/13/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import Combine
import SwiftUI

struct InterfaceAndControls: View {
    @ObservedObject var viewModel: InterfaceAndControlsViewModel
    
    init(viewModel: InterfaceAndControlsViewModel = InterfaceAndControlsViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        GeometryReader { geometry in
            let _ = viewModel.setViewDimensions(geometry.size)

            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .center, spacing: 12) {
                    if viewModel.showTitleCard {
                        TitleCard()
                            .layoutPriority(5)
                    }

                    if viewModel.showDocumentsCard {
                        DocumentsCard(documentsListViewModel: $viewModel.documentsListViewModel,
                                      onTitleClick: {
                            viewModel.requestFullViewFor(.documentsCard)
                        })
                            .layoutPriority(2)
                    }

                    if viewModel.showTypeWriterMenuCard {
                        TypeWriterMenuCard(onTitleClick: {
                            viewModel.requestFullViewFor(.typeWriterMenuCard)
                        }, isFullHeight: $viewModel.typeWriterCardFullHeight)
                            .layoutPriority(4)
                    }

                    if viewModel.showAnalyticsInfoCard {
                        AnalyticsInfoCard(viewModel: viewModel.analyticsInfoViewModel,
                                          onTitleClick: {
                            viewModel.requestFullViewFor(.analyticsInfoCard)
                        })
                            .layoutPriority(3)
                    }

                    if viewModel.showSettingsCard {
                        SettingsCard()
                            .layoutPriority(1)
                    }

                    Spacer(minLength: 0)
                }
                .padding(12)
                .animation(.interactiveSpring()
                            .speed(0.5)
                            .delay(0.03))
            }
            .frame(minWidth: 275, idealWidth: 380,
                   maxWidth: OSHelper.runtimeEnvironment == .iOS ? .infinity : 380,
                   minHeight: 275, maxHeight: .infinity,
                   alignment: .center)
        }
    }
}

struct Typyst_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = InterfaceAndControlsViewModel()
        let _ = viewModel.requestFullViewFor(.documentsCard)
        InterfaceAndControls(viewModel: viewModel)
            .previewLayout(.fixed(width: 380, height: 1800))
    }
}
