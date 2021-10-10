//
// Created by Sean Wolford on 3/8/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

struct CardContentModifier: ViewModifier {
    var backgroundColor: Color
    var cornerRadius: CGFloat = 24
    var insetBackgroundColor: Color = AppColor.cardOutlineRoundedScrollerBackground
    var insetSize: CGFloat = 4.0
    var showInsetStrokeBorder: Bool = false
    var showStrokeBorder: Bool = true

    func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            ZStack(alignment: .center, content: {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(showInsetStrokeBorder
                            ? AppColor.buttonBorder
                            : backgroundColor)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(0.667)

                if (showInsetStrokeBorder) {
                    RoundedRectangle(cornerRadius: cornerRadius - insetSize, style: .continuous)
                        .fill(backgroundColor)
                        .padding(insetSize + 0.667)

                    RoundedRectangle(cornerRadius: cornerRadius - insetSize, style: .continuous)
                        .strokeBorder(AppGradients.cardOutlineGradient, lineWidth: 0.667, antialiased: true)
                        .opacity(0.66)
                        .padding(insetSize + 0.667)
                }

                if (showStrokeBorder) {
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .strokeBorder(AppGradients.cardOutlineGradient,
                                      lineWidth: 0.667,
                                      antialiased: true)
                }
            })
                .drawingGroup()
            
            content
                .layoutPriority(1)
        }
    }
}

extension View {
    func asCard(withColor color: Color,
                cornerRadius: CGFloat = 24,
                insetBackgroundColor: Color = AppColor.cardOutlineRoundedScrollerBackground,
                insetSize: CGFloat = 4.0,
                showInsetStrokeBorder: Bool = false,
                showStrokeBorder: Bool = true) -> some View {
        modifier(CardContentModifier(backgroundColor: color,
                      cornerRadius: cornerRadius,
                      insetBackgroundColor: insetBackgroundColor,
                      insetSize: insetSize,
                      showInsetStrokeBorder: showInsetStrokeBorder,
                      showStrokeBorder: showStrokeBorder))
    }

    func asParentCard(withColor color: Color = AppColor.cardPrimaryBackground,
                      withCornerRadius cornerRadius: CGFloat = 24) -> some View {
        #if os(macOS)
        modifier(CardContentModifier(backgroundColor: color, cornerRadius: cornerRadius))
            .neumorphicShadow(shadowIntensity: .mediumStrong)
        #else
        modifier(CardContentModifier(backgroundColor: color, cornerRadius: cornerRadius))
        #endif
    }

    func asChildCard(withColor color: Color = AppColor.cardSecondaryBackground,
                     withCornerRadius cornerRadius: CGFloat = 20) -> some View {
        #if os(macOS)
        modifier(CardContentModifier(backgroundColor: color,
                                     cornerRadius: cornerRadius,
                                     showStrokeBorder: false))
            .neumorphicShadow()
        #else
        modifier(CardContentModifier(backgroundColor: color,
                                     cornerRadius: cornerRadius,
                                     showStrokeBorder: false))
        #endif
    }

    func asScrollableCard(withColor color: Color = AppColor.cardTertiaryBackground,
                          withCornerRadius cornerRadius: CGFloat = 20,
                          withCardInset inset: CGFloat = 0
    ) -> some View {
        #if os(macOS)
        ScrollView(showsIndicators: false) {
            modifier(CardContentModifier(backgroundColor: color,
                                         cornerRadius: cornerRadius,
                                         showInsetStrokeBorder: true))
//                .padding(0)
        }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius + inset, style: .continuous).inset(by: inset))
            .neumorphicShadow()
        #else
        ScrollView(showsIndicators: false) {
            modifier(CardContentModifier(backgroundColor: color,
                                         cornerRadius: cornerRadius,
                                         showInsetStrokeBorder: true))
//                .padding(2)
        }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius + inset, style: .continuous).inset(by: inset))
        #endif
    }
}
