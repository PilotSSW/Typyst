//
//  Gradients.swift
//  Typyst
//
//  Created by Sean Wolford on 3/28/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

class AppGradients {
    public static var cardOutlineGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [AppColor.cardOutlinePrimary, AppColor.cardOutlineSecondary]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    public static func buttonOutlineGradient(isPressed: Bool = false) -> LinearGradient {
        var colors: [Color] {
            isPressed
                ? [AppColor.cardOutlineSecondary, AppColor.cardOutlinePrimary]
                : [AppColor.cardOutlinePrimary, AppColor.cardOutlineSecondary]
        }

        return LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
