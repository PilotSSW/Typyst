//
//  CardHeader.swift
//  Typyst
//
//  Created by Sean Wolford on 3/13/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct CardHeaderModifier: ViewModifier {
    var backgroundColor: Color
    var maxHeight: CGFloat = 36
    var onClickAction: (() -> Void)? = nil

    func body(content: Content) -> some View {
        if onClickAction != nil {
            Button(action: { onClickAction?() }) {
                content
                    .frame(maxHeight: .infinity)
            }
            .buttonStyle(NeumorphicButtonStyle(backgroundColor: backgroundColor))
            .frame(maxWidth: .infinity, minHeight: 26, maxHeight: maxHeight)
        }
        else {
            ZStack {
                RoundedRectangle(cornerRadius: maxHeight / 2, style: .continuous)
                    .fill(backgroundColor)
                    .padding(maxHeight * 0.03)

                RoundedRectangle(cornerRadius: maxHeight / 2, style: .continuous)
                    .strokeBorder(AppGradients.cardOutlineGradient,
                                  lineWidth: 1.0,
                                  antialiased: true)

                content
            }
            .frame(maxWidth: .infinity, minHeight: 26, maxHeight: maxHeight)
        }
    }
}

extension View {
    func asCardHeader(withBackgroundColor color: Color,
                      maxHeight: CGFloat = 48.0,
                      onClickAction: (() -> Void)? = nil) -> some View {
        modifier(CardHeaderModifier(backgroundColor: color,
                                    maxHeight: maxHeight,
                                    onClickAction: onClickAction))
    }

    func asStyledCardHeader(withBackgroundColor color: Color = AppColor.cardHeaderBackground,
                            maxHeight: CGFloat = 48.0,
                            onClickAction: (() -> Void)? = nil) -> some View {
        modifier(CardHeaderModifier(backgroundColor: color,
                                    maxHeight: maxHeight,
                                    onClickAction: onClickAction))
            .asStyledText(with: .largeTitle,
                          textSize: TextSize.veryLarge.rawValue)
    }
}


