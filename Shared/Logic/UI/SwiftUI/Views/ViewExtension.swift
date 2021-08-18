//
//  ViewExtension.swift
//  Typyst
//
//  Created by Sean Wolford on 3/18/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    #if canImport(UIKit)
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    #endif

    func inverseMask<Mask>(_ mask: Mask) -> some View where Mask: View {
        // 2
        self.mask(mask
          .foregroundColor(.black)
          .background(Color.white)
          .compositingGroup()
          .luminanceToAlpha()
        )
    }

    func multicolorGlow() -> some View {
        ZStack {
            ForEach(0..<2) { i in
                Rectangle()
                    .fill(AngularGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .red]), center: .center))
                    .frame(width: 400, height: 300)
                    .mask(self.blur(radius: 20))
                    .overlay(self.blur(radius: 5 - CGFloat(i * 5)))
            }
        }
    }
}
