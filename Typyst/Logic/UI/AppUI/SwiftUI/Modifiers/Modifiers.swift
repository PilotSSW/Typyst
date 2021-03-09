//
// Created by Sean Wolford on 3/8/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }

}