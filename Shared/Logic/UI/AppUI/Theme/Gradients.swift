//
//  Gradients.swift
//  Typyst
//
//  Created by Sean Wolford on 3/28/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

final class AppGradients {
    public static var cardOutlineGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [AppColor.cardOutlinePrimary.opacity(0.8), AppColor.cardOutlineSecondary.opacity(0.8)]),
            startPoint: .top,
            endPoint: .bottom
        )
    }

    public static func buttonOutlineGradient(isPressed: Bool = false, opacity opacityValue: Double = 1.0) -> LinearGradient {
        var colors: [Color] {
            isPressed
                ? [
                    AppColor.cardOutlineSecondary
                        .opacity(opacityValue),
                    AppColor.cardOutlinePrimary
                        .opacity(opacityValue)
                ]
                : [
                    AppColor.cardOutlinePrimary
                        .opacity(opacityValue),
                    AppColor.cardOutlineSecondary
                        .opacity(opacityValue)
                ]
        }

        return LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}
