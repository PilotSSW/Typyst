//
// Created by Sean Wolford on 3/23/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

struct NeumorphicShadow: ViewModifier {
    @State var shadowIntensity: ShadowIntensity = .light
    @State var shouldRasterize: Bool = false

    var radius: CGFloat = 2
    var x: CGFloat = 1.33
    var y: CGFloat = 1.33

    func body(content: Content) -> some View {
        let lightShadow = AppColor.objectShadowLight.opacity(shadowIntensity.rawValue)
        let darkShadow = AppColor.objectShadowDark.opacity(shadowIntensity.rawValue)

        let result = content
            .shadow(color: lightShadow,
                    radius: radius,
                    x: -x,
                    y: -y)
            .shadow(color: darkShadow,
                    radius: radius,
                    x: x,
                    y: y)

        if shouldRasterize {
            result.drawingGroup()
        }
        else {
            result
        }
    }
}

extension View {
    func neumorphicShadow(shadowIntensity: ShadowIntensity = .light, radius: CGFloat = 3,
                          x: CGFloat = 1.33, y: CGFloat = 1.33) -> some View {
        self.modifier(NeumorphicShadow(shadowIntensity: shadowIntensity, radius: radius, x: x, y: y))
    }
}

