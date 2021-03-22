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
    var analyticsInfo: AnalyticsInfo

    var textBody: AnalyticsInfoTextBody {
        analyticsInfo.getAsTextBody()
    }

    var body: some View {
        VStack {
            Text(textBody.totalUptimeText)
                .font(.title)
                .fontWeight(.semibold)
                .lineLimit(nil)
                .foregroundColor(AppColor.textBody)
                .shadow(color: AppColor.textShadow, radius: 4)
                .layoutPriority(1)

            Spacer()
                .frame(maxHeight: 10)

            Text(textBody.totalKeyPressesText)
                .font(.title3)
                .lineLimit(nil)
                .foregroundColor(AppColor.textBody)
                .shadow(color: AppColor.textShadow, radius: 4)

            Text(textBody.averageKeyPressesText)
                .font(.title3)
                .lineLimit(nil)
                .foregroundColor(AppColor.textBody)
                .shadow(color: AppColor.textShadow, radius: 4)
        }
        .padding(.vertical, 8)
        .asChildCard(withColor: AppColor.secondaryBackground)

    }
}
