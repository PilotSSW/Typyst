//
//  AnalyticsInfoCard.swift
//  Typyst
//
//  Created by Sean Wolford on 3/19/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct AnalyticsInfoCard: View {
    @ObservedObject
    var viewModel = AnalyticsInfoCardViewModel()

    var body: some View {
        VStack {
            if (viewModel.state == .inactive) {
                Text("See your typing speed")
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .asStyledText(with: .title)
                    .padding(8)
                    .asParentCard(withColor: AppColor.cardSecondaryBackground)
            }
            else {
                Text("Your amazing typing skills over the past: ")
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .asStyledText(with: .title)
                    .padding(8)
                    .asParentCard(withColor: AppColor.cardSecondaryBackground)

                ForEach(viewModel.analyticsInfoItems, id:\.timeElapsed) { analyticsInfo in
                    AnalyticsInfoView(viewModel: analyticsInfo)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }

            AnalyticsInfoControls(viewModel: viewModel)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 8)
        .asParentCard(withColor: AppColor.cardPrimaryBackground)
    }
}

struct AnalyticsInfoCard_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsInfoCard()
    }
}
