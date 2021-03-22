//
// Created by Sean Wolford on 3/8/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

struct Card: ViewModifier {
    var backgroundColor: Color
    var maxWidth: CGFloat = 600

    func body(content: Content) -> some View {
        ZStack(alignment: .center, content: {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(backgroundColor)
                .shadow(color: AppColor.objectShadowDark, radius: 8, x: 0, y: 0)

            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .strokeBorder(AppColor.tertiaryBackground, lineWidth: 1.0, antialiased: true)
                .shadow(color: AppColor.objectShadowDark, radius: 1, x: 0, y: 0)

            content
                .clipped(antialiased: true)
        })
    }
}

extension View {
    func asCard(withColor color: Color) -> some View {
        modifier(Card(backgroundColor: color))
    }

    func asParentCard(withColor color: Color) -> some View {
        modifier(Card(backgroundColor: color))
            .padding(.horizontal, 8)
    }

    func asChildCard(withColor color: Color) -> some View {
        modifier(Card(backgroundColor: color))
            .padding(.horizontal, 8)
    }
}
