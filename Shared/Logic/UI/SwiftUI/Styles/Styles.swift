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
    var cornerRadius: CGFloat?
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
            shadowIntensity = .veryStrong
            shadowRadius = 10
            xOffset = 0.0
            yOffSet = 6.0
        case .isHovering:
            shadowIntensity = .mediumStrong
            shadowRadius = 5.0
            xOffset = 0.0
            yOffSet = 4.5
        case .noInteraction:
            shadowIntensity = .light
            shadowRadius = 1.0
            xOffset = 0.0
            yOffSet = 0.5
        }

        return  configuration.label
            .background(
                GeometryReader { geometry in
                    let size = geometry.size
                    let avgSize = size.height + size.width / 2
                    let buttonCornerRadius = cornerRadius ?? (min(size.width, size.height) / 2)

                    ZStack {
                        let button = RoundedRectangle(cornerRadius: buttonCornerRadius, style: .continuous)
                            .fill(backgroundColor)
                            .blendMode(.overlay)
                            .scaleEffect(interactionMode == .isPressed
                                     ? (avgSize / (avgSize + 3))
                                     : interactionMode == .isHovering
                                         ? (avgSize / (avgSize - 3))
                                         : 1.0)
                        
                        if interactionMode == .isPressed {
                            let lightGradient = LinearGradient(gradient: Gradient(colors: [Color.clear, Color.white]),
                                                          startPoint: .top,
                                                          endPoint: .bottom)
                            
                            let darkGradient = LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]),
                                                               startPoint: .bottom,
                                                               endPoint: .top)
                            button
                                .overlay(RoundedRectangle(cornerRadius: buttonCornerRadius, style: .continuous)
                                            .stroke(AppColor.objectShadowLight.opacity(shadowIntensity.rawValue), lineWidth: size.height * 0.05)
                                            .blur(radius: shadowRadius)
                                            .offset(x: -xOffset, y: -yOffSet)
                                            .mask(RoundedRectangle(cornerRadius: buttonCornerRadius, style: .continuous)
                                                    .fill(lightGradient)))
                                .overlay(RoundedRectangle(cornerRadius: buttonCornerRadius, style: .continuous)
                                            .stroke(AppColor.objectShadowDark.opacity(shadowIntensity.rawValue), lineWidth: size.height * 0.15)
                                            .blur(radius: shadowRadius)
                                            .offset(x: xOffset, y: yOffSet)
                                            .mask(RoundedRectangle(cornerRadius: buttonCornerRadius, style: .continuous)
                                                    .fill(darkGradient)))
                        }
                        else if [.isHovering, .noInteraction].contains(interactionMode) {
                            button
                                .shadow(color: AppColor.objectShadowLight.opacity(shadowIntensity.rawValue),
                                        radius: shadowRadius,
                                        x: -xOffset,
                                        y: -yOffSet)
                                .shadow(color: AppColor.objectShadowDark.opacity(shadowIntensity.rawValue),
                                        radius: shadowRadius,
                                        x: xOffset,
                                        y: yOffSet)
                        }
                        else {
                            button
                        }

                        RoundedRectangle(cornerRadius: buttonCornerRadius, style: .continuous)
                            .strokeBorder(AppGradients.buttonOutlineGradient(isPressed: configuration.isPressed),
                                          lineWidth: configuration.isPressed ? 0.5 : 0.25, antialiased: true)
                            .scaleEffect(interactionMode == .isPressed
                                         ? (avgSize / (avgSize + 3))
                                         : interactionMode == .isHovering
                                         ? (avgSize / (avgSize - 3))
                                         : 1.0)
                        
                        RoundedRectangle(cornerRadius: buttonCornerRadius, style: .continuous)
                            .strokeBorder(AppGradients.cardOutlineGradient,
                                          lineWidth: 0.7, antialiased: true)
                            .scaleEffect(interactionMode == .isPressed
                                         ? (avgSize / (avgSize + 3))
                                         : interactionMode == .isHovering
                                         ? (avgSize / (avgSize - 3))
                                         : 1.0)
                }
            })
            .foregroundColor(textColor)
            .onHover(perform: { isHovering in
                self.isHovering = isHovering
            })
            .animation(.interactiveSpring())
    }
}
