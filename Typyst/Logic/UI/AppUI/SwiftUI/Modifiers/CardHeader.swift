//
//  CardHeader.swift
//  Typyst
//
//  Created by Sean Wolford on 3/13/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct CardHeader: ViewModifier {
    var backgroundColor: Color

    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(backgroundColor)

            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .strokeBorder(AppGradients.cardOutlineGradient, lineWidth: 2.0, antialiased: true)

            content
//                .clipped(antialiased: true)
                .frame(height: 40)
        }
    }
}

extension View {
    func asCardHeader(withBackgroundColor color: Color) -> some View {
        modifier(CardHeader(backgroundColor: color))
    }

    func asStyledCardHeader(withBackgroundColor color: Color) -> some View {
        modifier(CardHeader(backgroundColor: color))
            .neumorphicShadow()
            .padding(8)
            .frame(maxHeight: 56)
    }
}


