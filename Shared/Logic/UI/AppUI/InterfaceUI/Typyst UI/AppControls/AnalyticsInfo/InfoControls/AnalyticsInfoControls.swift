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
            Spacer()
                .frame(minWidth: 0, maxWidth: .infinity)

            AnalyticsInfoControlButton(
                text: "Start",
                backgroundColor: AppColor.buttonPrimary,
                action: { viewModel.startTimer() })
                .layoutPriority(2)

            Spacer()
                .frame(minWidth: 12, maxWidth: 20)
                .layoutPriority(1)

            AnalyticsInfoControlButton(
                text: "Stop",
                backgroundColor: AppColor.buttonWarning,
                action: { viewModel.stopTimer() })
                .layoutPriority(2)

            Spacer()
                .frame(minWidth: 12, maxWidth: 20)
                .layoutPriority(1)

            AnalyticsInfoControlButton(
                text: "Reset",
                backgroundColor: AppColor.buttonTertiary,
                action: { viewModel.reset() })
                .layoutPriority(2)

            Spacer()
                .frame(minWidth: 0, maxWidth: .infinity)
        }
        .padding(8)
        .asParentCard(withColor: AppColor.cardSecondaryBackground)

    }
}

//struct AnalyticsInfoControls_Previews: PreviewProvider {
//    static var previews: some View {
//        AnalyticsInfoControls(viewModel: AnalyticsInfoCardViewModel())
//    }
//}
