//
// Created by Sean Wolford on 3/28/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

enum TextSize: Double {
    case verySmall = 8.0
    case small = 10.0
    case normal = 12.0
    case large = 14.0
    case veryLarge = 16.0
    case extraLarge = 18.0
    case doublyLarge = 24.0
    case enormous = 36.0
    case ungodlyLarge = 48.0
}

struct StyledText: ViewModifier {
    var compressable: Bool = false
    var lineLimit: Int? = nil
    var textSize: Double = TextSize.normal.rawValue
    var textStyle: Font.TextStyle
    var textColor: Color = AppColor.textBody

    func body(content: Content) -> some View {
        let newView = content
            .font(.custom("AmericanTypewriter",
                          size: CGFloat(textSize),
                          relativeTo: textStyle))
            .foregroundColor(textColor)
            .lineLimit(lineLimit)
            .lineSpacing(1.66)
            .allowsTightening(compressable)
            .minimumScaleFactor(compressable ? 0.85 : 1)
//            .shadow(color: AppColor.textShadow, radius: 2)
//            .shadow(color: AppColor.objectShadowLight, radius: 1.2)

        return newView
    }
}

extension View {
    func asStyledText(with textStyle: Font.TextStyle = .body,
                      textSize: Double = TextSize.normal.rawValue,
                      textColor: Color = AppColor.textBody,
                      lineLimit: Int? = nil,
                      isCompressable: Bool = false) -> some View {
        modifier(StyledText(
            compressable: isCompressable,
            lineLimit: lineLimit,
            textSize: textSize,
            textStyle: textStyle,
            textColor: textColor))
    }

    func asLightStyledText(with textStyle: Font.TextStyle = .body,
                           textSize: Double = TextSize.normal.rawValue,
                           lineLimit: Int? = nil,
                           isCompressable: Bool = false) -> some View {
        modifier(StyledText(
            compressable: isCompressable,
            lineLimit: lineLimit,
            textSize: textSize,
            textStyle: textStyle,
            textColor: AppColor.textBodyLight))
    }

    func asStyledHeader(with textStyle: Font.TextStyle = .headline,
                        textSize: Double = TextSize.veryLarge.rawValue,
                        textColor: Color = AppColor.textHeader,
                        lineLimit: Int? = nil,
                        isCompressable: Bool = false) -> some View {
        modifier(StyledText(
            compressable: isCompressable,
            lineLimit: lineLimit,
            textSize: textSize,
            textStyle: textStyle,
            textColor: textColor))
    }
}
