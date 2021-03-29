//
// Created by Sean Wolford on 3/28/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

struct StyledText: ViewModifier {
    var textStyle: Font.TextStyle
    var textColor: Color = AppColor.textBody

    func body(content: Content) -> some View {
        let newView = content
            .font(.custom("AmericanTypewriter", size: 16, relativeTo: textStyle))
            .foregroundColor(textColor)
            .lineSpacing(1.33)
            .allowsTightening(true)
            .minimumScaleFactor(0.8)
            .shadow(color: AppColor.textShadow, radius: 6)

        return newView
    }
}

extension View {
    func asStyledText(with textStyle: Font.TextStyle = .body,
                      textColor: Color = AppColor.textBody) -> some View {
        modifier(StyledText(textStyle: textStyle,
                            textColor: textColor))
    }

    func asLightStyledText(with textStyle: Font.TextStyle = .body) -> some View {
        modifier(StyledText(textStyle: textStyle,
                            textColor: AppColor.textBodyLight))
    }

    func asStyledHeader(with textStyle: Font.TextStyle = .headline,
                        textColor: Color = AppColor.textHeader) -> some View {
        modifier(StyledText(textStyle: textStyle,
                            textColor: textColor))
    }
}
