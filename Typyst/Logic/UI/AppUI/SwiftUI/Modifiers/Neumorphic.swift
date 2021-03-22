//
// Created by Sean Wolford on 3/21/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

struct Neumorphic: ViewModifier {
    var radiusPressed: CGFloat = 5
    var radiusUnpressed: CGFloat = 5
    var xPressed: CGFloat = 2
    var xUnpressed: CGFloat = 2
    var yPressed: CGFloat = 2
    var yUnpressed: CGFloat = 2

    var backgroundColor: Color
    @Binding var isPressed: Bool

    func body(content: Content) -> some View {
        content
            .padding(8)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .shadow(color: AppColor.objectShadowLight,
                                radius: isPressed ? radiusPressed : radiusUnpressed,
                                x: isPressed ? xPressed : -xUnpressed,
                                y: isPressed ? yPressed : -yUnpressed)
                        .shadow(color: AppColor.objectShadowDark,
                                radius: isPressed ? radiusPressed : radiusUnpressed,
                                x: isPressed ? -xPressed : xUnpressed,
                                y: isPressed ? -yPressed : yUnpressed)
                        .blendMode(.luminosity)
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(backgroundColor)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
            .scaleEffect(isPressed ? 0.92 : 1)
            .animation(.interactiveSpring())
    }
}

extension View {
    func neumorphic(isPressed: Binding<Bool>, backgroundColor: Color) -> some View {
        self.modifier(Neumorphic(backgroundColor: backgroundColor, isPressed: isPressed))
    }
}
