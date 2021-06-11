//
// Created by Sean Wolford on 3/8/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

struct TypeWriterCardBody: View {
    var description: String = ""

    var body: some View {
        Text(description)
            .multilineTextAlignment(.center)
            .asStyledText()
            .padding(.horizontal, 12)
    }
}
