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
//                RoundedRectangle(cornerRadius: 88, style: .continuous)
//                    .fill(AppColor.ImageBackground)
//                    .blendMode(.saturation)
//                    .blur(radius: 1, opaque: false)

                Image(imagePath)
                    .resizable()
                    .scaledToFit()
                    .blendMode(.destinationOver)
                    .opacity(0.66)
                    .blur(radius: 16)
                    .frame(minWidth: 0, maxWidth: .infinity,
                           minHeight: 0, maxHeight: .infinity,
                           alignment: .center)

                Image(imagePath)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: AppColor.objectShadowDark, radius: 6)
                    .padding(.horizontal, 18)
                    .frame(minWidth: 200, maxWidth: .infinity,
                           minHeight: 200, maxHeight: .infinity,
                           alignment: .center)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct TypeWriterImageButton_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterImageButton(onClick: { },
                              imagePath: "RoyalModelP")
    }
}
