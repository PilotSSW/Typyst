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
    var viewModel = AnalyticsInfoViewModel()

    var body: some View {
        VStack {
            if (viewModel.state == .inactive) {
                Text("See your typing speed")
                    .font(.title)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .foregroundColor(AppColor.textBody)
                    .shadow(color: AppColor.textShadow, radius: 4)
                    .padding(8)
                    .asChildCard(withColor: AppColor.secondaryBackground)
            }
            else {
                Text("Your amazing typing skills over the past: ")
                    .font(.title)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .foregroundColor(AppColor.textBody)
                    .shadow(color: AppColor.textShadow, radius: 4)
                    .padding(8)
                    .asChildCard(withColor: AppColor.secondaryBackground)

                ForEach(viewModel.analyticsInfoItems, id:\.timeStamp) { analyticsInfo in
                    AnalyticsInfoView(analyticsInfo: analyticsInfo)
                }
            }

            AnalyticsInfoControls(viewModel: viewModel)
        }
        .padding(.vertical, 8)
        .asParentCard(withColor: AppColor.primaryBackground)
    }
}

struct AnalyticsInfoCard_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsInfoCard()
    }
}
