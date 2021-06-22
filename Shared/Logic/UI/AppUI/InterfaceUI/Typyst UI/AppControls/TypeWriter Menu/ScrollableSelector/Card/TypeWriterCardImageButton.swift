//
// Created by Sean Wolford on 3/8/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

struct TypeWriterImageButton: View {
    @State private var showVectorImage = true

    var onClick: () -> Void
    var imagePath: String

    var body: some View {
        Button(action: onClick) {
            ZStack {
                Image("TypeWriterTransparencies/\(imagePath)")
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .offset(x: 12, y: 12)
                    .blur(radius: 40)
                    .blendMode(.exclusion)
                    .layoutPriority(2)

                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(AppColor.ImageBackground)
                    .blendMode(.multiply)
                    .layoutPriority(1)

                if !showVectorImage {
                    Image("TypeWriterTransparencies/\(imagePath)")
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.93)
                        .padding(8)
                        .layoutPriority(3)
                        .animation(.easeIn(duration: 0.1))
                }

                if showVectorImage {
                    Image("TypeWriterVectors/\(imagePath)")
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.93)
                        .padding(8)
                        .layoutPriority(3)
                        .animation(.easeOut(duration: 0.5))
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .circular))
        .frame(minWidth: 60,
               minHeight: 60,
               alignment: .center)
        .onHover(perform: { hovering in
            showVectorImage = !hovering
        })
    }
}

struct TypeWriterImageButton_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterImageButton(onClick: { },
                              imagePath: "RoyalModelP")
    }
}
