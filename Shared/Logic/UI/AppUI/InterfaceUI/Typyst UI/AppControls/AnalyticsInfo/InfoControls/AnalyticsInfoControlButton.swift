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
                .frame(minWidth: 55, maxWidth: 105,
                       minHeight: 24, maxHeight: 90,
                       alignment: .center)
        }
        .buttonStyle(NeumorphicButtonStyle(backgroundColor: backgroundColor))
    }
}
