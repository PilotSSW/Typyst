//
// Created by Sean Wolford on 3/8/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

struct Card: ViewModifier {
    var backgroundColor: Color
    var showStrokeBorder: Bool = true

    func body(content: Content) -> some View {
        ZStack(alignment: .center, content: {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(backgroundColor)

            if (showStrokeBorder) {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .strokeBorder(AppGradients.cardOutlineGradient, lineWidth: 2.0, antialiased: true)
            }

            content
//                .clipped(antialiased: true)
        })
    }
}

extension View {
    func asCard(withColor color: Color) -> some View {
        modifier(Card(backgroundColor: color))
    }

    func asParentCard(withColor color: Color) -> some View {
        modifier(Card(backgroundColor: color))
            .neumorphicShadow()
            .padding(.horizontal, 8)
    }

    func asChildCard(withColor color: Color) -> some View {
        modifier(Card(backgroundColor: color, showStrokeBorder: false))
            .neumorphicShadow()
    }
}
