//
// Created by Sean Wolford on 3/28/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

enum TextSize {
    case verySmall
    case small
    case normal
    case large
    case veryLarge
    case extraLarge
    case doublyLarge
    case enormous
    case ungodlyLarge
    case custom(fontSize: Double)
    
    var doubleSize: Double {
        switch self {
        case .verySmall: return 8.0
        case .small: return 10.0
        case .normal: return 12.0
        case .large: return 14.0
        case .veryLarge: return 16.0
        case .extraLarge: return 18.0
        case .doublyLarge: return 24.0
        case .enormous: return 36.0
        case .ungodlyLarge: return 48.0
        case .custom(let fontSize): return fontSize
        }
    }
    
    var cgFloatSize: CGFloat {
        switch self {
        case .verySmall: return 8.0
        case .small: return 10.0
        case .normal: return 12.0
        case .large: return 14.0
        case .veryLarge: return 16.0
        case .extraLarge: return 18.0
        case .doublyLarge: return 24.0
        case .enormous: return 36.0
        case .ungodlyLarge: return 48.0
        case .custom(let fontSize): return fontSize
        }
    }
}

struct StyledText: ViewModifier {
    var compressable: Bool = false
    var lineLimit: Int? = nil
    var textSize: TextSize = .normal
    var textStyle: Font.TextStyle
    var textColor: Color = AppColor.textBody

    func body(content: Content) -> some View {
        content
            .font(.custom("AmericanTypewriter",
                          size: textSize.cgFloatSize,
                          relativeTo: textStyle))
            .foregroundColor(textColor)
            .lineLimit(lineLimit)
            .lineSpacing(1.66)
            .allowsTightening(compressable)
            .minimumScaleFactor(compressable ? 0.85 : 1)
            .shadow(color: AppColor.textShadow, radius: 3)
    }
}

extension View {
    func asStyledText(with textStyle: Font.TextStyle = .body,
                      textSize: TextSize = .normal,
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
                           textSize: TextSize = .normal,
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
                        textSize: TextSize = .veryLarge,
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
