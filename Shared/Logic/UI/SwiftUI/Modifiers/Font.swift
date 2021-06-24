//
// Created by Sean Wolford on 3/28/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

struct StyledText: ViewModifier {
    var compressable: Bool = false
    var lineLimit: Int? = nil
    var textStyle: Font.TextStyle
    var textColor: Color = AppColor.textBody

    func body(content: Content) -> some View {
        let newView = content
            .font(.custom("AmericanTypewriter", size: 14, relativeTo: textStyle))
            .foregroundColor(textColor)
            .lineLimit(lineLimit)
            .lineSpacing(1.66)
            .allowsTightening(compressable)
            .minimumScaleFactor(compressable ? 0.85 : 1)
            .shadow(color: AppColor.textShadow, radius: 2)
            .shadow(color: AppColor.objectShadowLight, radius: 1.2)

        return newView
    }
}

extension View {
    func asStyledText(with textStyle: Font.TextStyle = .body,
                      textColor: Color = AppColor.textBody,
                      lineLimit: Int? = nil,
                      isCompressable: Bool = false) -> some View {
        modifier(StyledText(
            compressable: isCompressable,
            lineLimit: lineLimit,
            textStyle: textStyle,
            textColor: textColor))
    }

    func asLightStyledText(with textStyle: Font.TextStyle = .body,
                           lineLimit: Int? = nil,
                           isCompressable: Bool = false) -> some View {
        modifier(StyledText(
            compressable: isCompressable,
            lineLimit: lineLimit,
            textStyle: textStyle,
            textColor: AppColor.textBodyLight))
    }

    func asStyledHeader(with textStyle: Font.TextStyle = .headline,
                        textColor: Color = AppColor.textHeader,
                        lineLimit: Int? = nil,
                        isCompressable: Bool = false) -> some View {
        modifier(StyledText(
            compressable: isCompressable,
            lineLimit: lineLimit,
            textStyle: textStyle,
            textColor: textColor))
    }
}
