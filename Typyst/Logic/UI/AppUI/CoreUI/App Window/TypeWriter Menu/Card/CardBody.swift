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
            .font(.body)
            .foregroundColor(AppColor.textBody)
            .padding(.horizontal, 18)
            .shadow(color: AppColor.textShadow,
                    radius: 5, x: 0, y: 0)
    }
}