//
//  AnalyticsInfoCard.swift
//  Typyst
//
//  Created by Sean Wolford on 3/19/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct AnalyticsInfoCard: View {
    @ObservedObject var viewModel = AnalyticsInfoCardViewModel(subscriptions: &RootDependencyContainer.get().subscriptions)
    var showInfo: Bool {
        viewModel.state == .logging
    }

    var body: some View {
        VStack(spacing: 8) {
            Text(showInfo ? "Your amazing typing skills over the past: " : "See your typing speed")
                .lineLimit(nil)
                .multilineTextAlignment(.center)
                .asStyledText(with: .title)
                .padding(8)
                .frame(maxWidth: .infinity,
                       minHeight: 60, maxHeight: 60)
                .asParentCard(withColor: AppColor.cardHeaderBackground)
                .layoutPriority(2)

            if (showInfo) {
                ForEach(viewModel.analyticsInfoItems, id:\.timeElapsed) { analyticsInfo in
                    AnalyticsInfoView(viewModel: analyticsInfo)
                        .layoutPriority(1)
                }
            }

            AnalyticsInfoControls(viewModel: viewModel)
                .layoutPriority(3)
        }
        .padding(.vertical, 8)
        .asParentCard(withColor: AppColor.cardPrimaryBackground)
    }
}

struct AnalyticsInfoCard_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsInfoCard()
    }
}
