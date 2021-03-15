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
                .padding(.horizontal, 8)
                .shadow(color: AppColor.objectShadow, radius: 6, x: 0, y: 0)

            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .strokeBorder(AppColor.tertiaryBackground, lineWidth: 1.5, antialiased: true)
                .padding(.horizontal, 8)
                .shadow(color: AppColor.objectShadow, radius: 6, x: 0, y: 0)

            content
                .padding(.horizontal, 8)
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
    }

    func asChildCard(withColor color: Color) -> some View {
        modifier(Card(backgroundColor: color))
    }
}
