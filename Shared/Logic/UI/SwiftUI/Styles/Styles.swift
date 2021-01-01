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
                                       startPoint: .top,
                                       endPoint: .bottom))
            .cornerRadius(24.0)
    }
}

struct NeumorphicButtonStyle: ButtonStyle {
    enum InteractionMode {
        case noInteraction
        case isHovering
        case isPressed
    }
    @State var isHovering: Bool = false

    var backgroundColor: Color
    var textColor: Color = AppColor.textBody

    func makeBody(configuration: Self.Configuration) -> some View {
        var interactionMode: InteractionMode = .noInteraction
        if configuration.isPressed { interactionMode = .isPressed }
        else if (isHovering) { interactionMode = .isHovering }

        var shadowIntensity: ShadowIntensity
        var shadowRadius: CGFloat
        var xOffset: CGFloat
        var yOffSet: CGFloat

        switch (interactionMode) {
        case .isPressed:
            shadowIntensity = .mediumStrong
            shadowRadius = 3.0
            xOffset = -1.0
            yOffSet = -3.0
        case .isHovering:
            shadowIntensity = .veryStrong
            shadowRadius = 4.0
            xOffset = 2.0
            yOffSet = 4.0
        case .noInteraction:
            shadowIntensity = .medium
            shadowRadius = 2.0
            xOffset = 1.0
            yOffSet = 2.0
        }

        return  configuration.label
            .padding(8)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(backgroundColor)
                        .blendMode(.overlay)
                        .shadow(color: AppColor.objectShadowLight.opacity(shadowIntensity.rawValue),
                                radius: shadowRadius,
                                x: -xOffset,
                                y: -yOffSet)
                        .shadow(color: AppColor.objectShadowDark.opacity(shadowIntensity.rawValue),
                                radius: shadowRadius,
                                x: xOffset,
                                y: yOffSet)

                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.clear)
                        .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .strokeBorder(AppGradients.buttonOutlineGradient(isPressed: configuration.isPressed),
                                                  lineWidth: 0.75, antialiased: true))
                }
            )
            .foregroundColor(textColor)
            .onHover(perform: { isHovering in
                self.isHovering = isHovering
            })
            .scaleEffect(interactionMode == .isPressed
                             ? 0.95
                             : interactionMode == .isHovering
                                 ? 1.025
                                 : 1.0)
            .animation(.easeOut(duration: 0.15))
    }
}
