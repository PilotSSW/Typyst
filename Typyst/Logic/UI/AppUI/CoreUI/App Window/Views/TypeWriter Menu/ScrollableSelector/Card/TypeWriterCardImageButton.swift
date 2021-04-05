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
//                RoundedRectangle(cornerRadius: 16, style: .continuous)
//                    .fill(AppColor.ImageBackground)
//                    .blendMode(.multiply)
//                    .opacity(0.15)
//                    .blur(radius: 2, opaque: false)
//                    .layoutPriority(1)

                Image(imagePath)
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(1.00)
                    .shadow(color: AppColor.objectShadowLight, radius: 24)
                    .offset(x: 12, y: 12)
                    .blur(radius: 40)
                    .blendMode(.exclusion)
//                    .opacity(0.8)
//                    .neumorphicShadow()
                    .layoutPriority(2)

                Image(imagePath)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: AppColor.objectShadowLight, radius: 4)
                    .padding(.horizontal, 18)
                    .layoutPriority(3)
                    .padding(8)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .frame(minWidth: 60,
               minHeight: 60,
               alignment: .center)
    }
}

struct TypeWriterImageButton_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterImageButton(onClick: { },
                              imagePath: "RoyalModelP")
    }
}
