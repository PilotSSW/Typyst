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
            startPoint: UnitPoint(x: 0.0, y: 0.0),
            endPoint: .bottomTrailing
        )
    }
}
