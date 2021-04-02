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
//                    .layoutPriority(1)


                Image(imagePath)
                    .resizable()
                    .scaledToFit()
                    .blendMode(.destinationOver)
                    .opacity(0.66)
                    .blur(radius: 16)
                    .layoutPriority(2)


                Image(imagePath)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: AppColor.objectShadowDark, radius: 6)
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
