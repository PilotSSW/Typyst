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

            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .strokeBorder(AppColor.tertiaryBackground, lineWidth: 1.0, antialiased: true)

            content
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
            .shadow(color: AppColor.objectShadow, radius: 4, x: 0, y: 0)
            .padding(8)
            .frame(maxHeight: 52)
    }
}


