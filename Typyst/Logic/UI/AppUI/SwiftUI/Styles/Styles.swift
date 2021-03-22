//
//  Styles.swift
//  Typyst
//
//  Created by Sean Wolford on 3/11/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

struct GradientButtonStyle: ButtonStyle {
    var primaryColor = Color.primary
    var secondaryColor: Color = Color.secondary
    var textColor: Color = AppColor.textBody

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(textColor)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [primaryColor, secondaryColor]),
                                       startPoint: .leading,
                                       endPoint: .trailing))
            .cornerRadius(24.0)
    }
}

struct NeumorphicButtonStyle: ButtonStyle {
    var radiusPressed: CGFloat = 5
    var radiusUnpressed: CGFloat = 5
    var xPressed: CGFloat = 2
    var xUnpressed: CGFloat = 2
    var yPressed: CGFloat = 2
    var yUnpressed: CGFloat = 2

    var backgroundColor: Color
    var textColor: Color = AppColor.textBody

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(8)
            .foregroundColor(textColor)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .shadow(color: AppColor.objectShadowLight,
                                radius: configuration.isPressed ? radiusPressed : radiusUnpressed,
                                x: configuration.isPressed ? xPressed : -xUnpressed,
                                y: configuration.isPressed ? yPressed : -yUnpressed)
                        .shadow(color: AppColor.objectShadowDark,
                                radius: configuration.isPressed ? radiusPressed : radiusUnpressed,
                                x: configuration.isPressed ? -xPressed : xUnpressed,
                                y: configuration.isPressed ? -yPressed : yUnpressed)
                        .blendMode(.luminosity)
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(backgroundColor)
                        .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous)
                                 .strokeBorder(AppColor.buttonBorder, lineWidth:3.0, antialiased: true))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
            .scaleEffect(configuration.isPressed ? 0.92 : 1)
            .animation(.interactiveSpring())
    }
}