//
// Created by Sean Wolford on 3/8/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

struct Card: ViewModifier {
    var backgroundColor: Color
    var cornerRadius: CGFloat = 24
    var insetBackgroundColor: Color = AppColor.cardOutlineRoundedScrollerBackground
    var insetSize: CGFloat = 4.0
    var padding: CGFloat = 0.0
    var showInsetStrokeBorder: Bool = false
    var showStrokeBorder: Bool = true

    func body(content: Content) -> some View {
        ZStack(alignment: .center, content: {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(showInsetStrokeBorder
                        ? AppColor.buttonBorder
                        : backgroundColor)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .layoutPriority(1)

            if (showStrokeBorder) {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(AppGradients.cardOutlineGradient, lineWidth: 1.66, antialiased: true)
                    .layoutPriority(2)
            }

            if (showInsetStrokeBorder) {
                RoundedRectangle(cornerRadius: cornerRadius - insetSize, style: .continuous)
                    .fill(backgroundColor)
                    .padding(insetSize)
                    .layoutPriority(3)

                RoundedRectangle(cornerRadius: cornerRadius - insetSize, style: .continuous)
                    .strokeBorder(AppGradients.cardOutlineGradient, lineWidth: 0.66, antialiased: true)
                    .opacity(0.66)
                    .padding(insetSize)
                    .layoutPriority(3)
            }

            content
                .layoutPriority(4)
        })
    }
}

extension View {
    func asCard(withColor color: Color) -> some View {
        modifier(Card(backgroundColor: color))
    }

    func asParentCard(withColor color: Color) -> some View {
        #if os(macOS)
        modifier(Card(backgroundColor: color))
            .neumorphicShadow()
            .padding(.horizontal, 8)
        #elseif os(iOS) || KEYBOARD_EXTENSION
        modifier(Card(backgroundColor: color))
            .padding(.horizontal, 8)
        #endif
    }

    func asChildCard(withColor color: Color) -> some View {
        #if os(macOS)
        modifier(Card(backgroundColor: color, cornerRadius: 20, showStrokeBorder: false))
            .neumorphicShadow()
        #elseif os(iOS) || KEYBOARD_EXTENSION
        modifier(Card(backgroundColor: color))
        #endif
    }

    func asScrollableCard(withColor color: Color) -> some View {
        modifier(Card(backgroundColor: color, showInsetStrokeBorder: true))
            .neumorphicShadow()
            .padding(.horizontal, 8)
    }
}
