//
// Created by Sean Wolford on 3/21/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

struct AnalyticsInfoControlButton: View {
    var text: String = ""
    var backgroundColor: Color
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .bold()
                .asStyledText(with: .title3)
                .frame(minWidth: 55, maxWidth: 92,
                       minHeight: 55, maxHeight: 66,
                       alignment: .center)
                .padding(12)
        }
        .buttonStyle(NeumorphicButtonStyle(backgroundColor: backgroundColor, cornerRadius: 18))
    }
}

struct AnalyticsInfoControlButton_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsInfoControlButton(text: "Do Something!",
                                   backgroundColor: AppColor.buttonPrimary, action: {})
    }
}
