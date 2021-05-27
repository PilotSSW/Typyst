//
//  AnalyticsInfoControls.swift
//  Typyst
//
//  Created by Sean Wolford on 3/20/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct AnalyticsInfoControls: View {
    @ObservedObject
    var viewModel: AnalyticsInfoCardViewModel

    var body: some View {
        HStack() {
            AnalyticsInfoControlButton(text: "Start",
                                    backgroundColor: AppColor.buttonPrimary,
                                    action: { viewModel.startTimer() })
                    .layoutPriority(1)

            Spacer()
                .frame(minWidth: 12, maxWidth: 24)

            AnalyticsInfoControlButton(text: "Stop",
                                    backgroundColor: AppColor.buttonWarning,
                                    action: { viewModel.stopTimer() })
                .layoutPriority(1)

            Spacer()
                .frame(minWidth: 12, maxWidth: 24)

            AnalyticsInfoControlButton(text: "Reset",
                                    backgroundColor: AppColor.buttonTertiary,
                                    action: { viewModel.reset() })
                .layoutPriority(1)
        }
        .padding(12)
        .asParentCard(withColor: AppColor.cardSecondaryBackground)
        .frame(minHeight: 72, maxHeight: 114,
               alignment: .center)
    }
}

struct AnalyticsInfoControls_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsInfoControls(viewModel: AnalyticsInfoCardViewModel())
    }
}
