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
                                       startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15.0)
    }
}
