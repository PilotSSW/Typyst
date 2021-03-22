//
// Created by Sean Wolford on 3/21/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

struct AnalyticsInfoViewButton: View {
    var text: String = ""
    var backgroundColor: Color
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.title3)
                .bold()
                .foregroundColor(AppColor.textBody)
                .shadow(color: AppColor.textShadow, radius: 6)
                .frame(minWidth: 55, maxWidth: 105,
                       minHeight: 48, maxHeight: 90,
                       alignment: .center)
        }
        .buttonStyle(NeumorphicButtonStyle(backgroundColor: backgroundColor))
    }
}