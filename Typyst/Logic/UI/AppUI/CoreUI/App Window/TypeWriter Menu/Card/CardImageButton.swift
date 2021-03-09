//
// Created by Sean Wolford on 3/8/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

struct TypeWriterImageButton: View {
    var onClick: () -> Void
    var imagePath: String

    var body: some View {
        Button(action: onClick) {
            ZStack {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(AppColor.typeWriterCardImageBackground)
                    .blendMode(.color)

                Image(imagePath)
                    .resizable()
                    .scaledToFit()
                    .blendMode(.overlay)
                    .blur(radius: 6)
                    .opacity(0.5)

                Image(imagePath)
                    .resizable()
                    .scaledToFit()
            }
            .shadow(color: AppColor.objectShadow, radius: 8, x: 0, y: 0)
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.horizontal, 18)
    }
}