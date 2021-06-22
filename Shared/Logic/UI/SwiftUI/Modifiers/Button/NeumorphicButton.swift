//
// Created by Sean Wolford on 3/21/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//
//
//import Foundation
//import SwiftUI
//
//struct Neumorphic: ViewModifier {
//    enum interactionMode {
//        case noInteraction
//        case isHovering
//        case isPressed
//    }
//
//    private static var defaultShadowIntensity: ShadowIntensity = .light
//    @State var shadowIntensity: ShadowIntensity = defaultShadowIntensity
//    var radiusPressed: CGFloat = 5
//    var radiusUnpressed: CGFloat = 2
//    var xPressed: CGFloat = 4
//    var xUnpressed: CGFloat = 2
//    var yPressed: CGFloat = 4
//    var yUnpressed: CGFloat = 2
//
//    var backgroundColor: Color = .clear
//    @Binding var isPressed: Bool
//    @State var isHovering: Bool = false
//
//    func body(content: Content) -> some View {
//        let shadowRadius: interactionMode = isPressed
//            ? interactionMode.isPressed
//            : isHovering
//                ? interactionMode.isHovering
//                : interactionMode.noInteraction
//
//        return content
//            .padding(8)
//            .background(
//                RoundedRectangle(cornerRadius: 24, style: .continuous)
//                    .shadow(color: AppColor.objectShadowLight.opacity(shadowIntensity.rawValue),
//                            radius: shadowRadius.rawValue,
//                            x: isPressed ? xPressed : -xUnpressed,
//                            y: isPressed ? yPressed : -yUnpressed)
//                    .shadow(color: AppColor.objectShadowDark.opacity(shadowIntensity.rawValue),
//                            radius: shadowRadius.rawValue,
//                            x: isPressed ? -xPressed : xUnpressed,
//                            y: isPressed ? -yPressed : yUnpressed)
//                    .blendMode(.color)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//            )
//            .onHover(perform: { isHovering in
//                self.isHovering = isHovering
//                shadowIntensity = isHovering
//                    ? .veryStrong
//                    : Neumorphic.defaultShadowIntensity
//            })
//            .scaleEffect(isPressed ? 0.95 : 1)
//            .animation(.easeOut(duration: 0.15))
//    }
//}
//
//extension View {
//    func neumorphic(isPressed: Binding<Bool>, backgroundColor: Color) -> some View {
//        self.modifier(Neumorphic(backgroundColor: backgroundColor, isPressed: isPressed))
//    }
//}
