//
//  Labels.swift
//  Typyst
//
//  Created by Sean Wolford on 3/13/21.
//  Copyright © 2021 wickedPropeller. All rights reserved.
//

import SwiftUI

struct PrimaryLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(AppColor.textBody)
            .shadow(color: AppColor.textShadow, radius: 12)
            .padding()
    }
}

extension View {
    func asLabel() -> some View {
        modifier(PrimaryLabel())
    }
}
