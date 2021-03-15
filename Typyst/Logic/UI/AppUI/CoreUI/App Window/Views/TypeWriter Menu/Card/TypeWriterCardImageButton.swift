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
//                RoundedRectangle(cornerRadius: 24, style: .continuous)
//                    .fill(AppColor.ImageBackground)
//                    .blendMode(.color)
//                    .blur(radius: 36, opaque: false)
//
//                Image(imagePath)
//                    .resizable()
//                    .scaledToFit()
//                    .opacity(0.99)
//                    .blur(radius: 36)
//                    .blendMode(.overlay)

                Image(imagePath)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 200, maxWidth: 600,
                           minHeight: 200, maxHeight: 600,
                           alignment: .center)
                    .scaledToFit()
            }
            .shadow(color: AppColor.objectShadow, radius: 8, x: 0, y: 0)
        }
        .buttonStyle(PlainButtonStyle())
//        .padding(.horizontal, 18)
    }
}

struct TypeWriterImageButton_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterImageButton(onClick: { },
                              imagePath: "RoyalModelP")
    }
}
