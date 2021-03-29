//
//  AnalyticsInfo.swift
//  Typyst
//
//  Created by Sean Wolford on 3/19/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct AnalyticsInfoView: View {
    @ObservedObject
    var viewModel: AnalyticsInfoViewModel

    var body: some View {
        VStack {
            Text(viewModel.textBody.totalUptimeText)
                .fontWeight(.semibold)
                .lineLimit(nil)
                .asStyledText(with:.title)
                .layoutPriority(1)

            Divider()
                .padding(.horizontal, 24)

            Text(viewModel.textBody.totalKeyPressesText)
                .lineLimit(nil)
                .asStyledText(with:.title3)

            Text(viewModel.textBody.averageKeyPressesPerMinuteText)
                .lineLimit(nil)
                .asStyledText(with:.title3)

            Text(viewModel.textBody.averageKeyPressesPerSecondText)
                .lineLimit(nil)
                .asStyledText(with:.title3)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 8)
        .asParentCard(withColor: AppColor.cardSecondaryBackground)
    }
}
