//
// Created by Sean Wolford on 3/23/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

struct NeumorphicShadow: ViewModifier {
    var radius: CGFloat = 2
    var x: CGFloat = 0.33
    var y: CGFloat = 0.33

    func body(content: Content) -> some View {
        content
            .shadow(color: AppColor.objectShadowLight,
                    radius: radius,
                    x: -x,
                    y: -y)
            .shadow(color: AppColor.objectShadowDark,
                    radius: radius,
                    x: x,
                    y: y)
//            .blendMode(.overlay)
//            .background(
//                ZStack {
//                    RoundedRectangle(cornerRadius: 24, style: .continuous)
//                        .inverseMask(RoundedRectangle(cornerRadius: 24, style: .continuous))
//                    .shadow(color: AppColor.objectShadowLight,
//                            radius: radius,
//                            x: -x,
//                            y: -y)
//                    .shadow(color: AppColor.objectShadowDark,
//                            radius: radius,
//                            x: x,
//                            y: y)
//                    .blendMode(.overlay)
//                }
//            )

    }
}

extension View {
    func neumorphicShadow(radius: CGFloat = 3, x: CGFloat = 1.33, y: CGFloat = 1.33) -> some View {
        self.modifier(NeumorphicShadow(radius: radius, x: x, y: y))
    }
}
