//
// Created by Sean Wolford on 3/8/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

struct TypeWriterImageButton: View {
    @State private var showVectorImage = true

    var onClick: (() -> Void)?
    var typeWriterModel: TypeWriterModel.ModelType
    var imageSize: AppImages.ImageSize = .large
    var showBlurredImage: Bool = true
    @State var showTypeWriterInfoWindow: Bool = false

    init(onClick: (() -> Void)? = nil,
         typeWriterModel: TypeWriterModel.ModelType,
         imageSize: AppImages.ImageSize = .medium,
         showBlurredImage: Bool = true) {
        self.onClick = onClick
        self.typeWriterModel = typeWriterModel
        self.imageSize = imageSize
        self.showBlurredImage = showBlurredImage
    }

    var body: some View {
        Button(action: {
            if let onClick = onClick {
                onClick()
                if (OSHelper.runtimeEnvironment == .macOS) { showTypeWriterInfoWindow = !showTypeWriterInfoWindow }
            }
        }) {
            ZStack {
                if showBlurredImage {
                    if let image = AppImages.TypeWriters.getImageFor(typeWriterModel,
                                                                     imageType: .transparency,
                                                                     imageSize: imageSize) {
                        image.interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .offset(x: 12, y: 12)
                            .blur(radius: 40)
                            .blendMode(.exclusion)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .layoutPriority(2)
                    }
                }

                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(AppColor.ImageBackground)
                    .blendMode(.multiply)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .layoutPriority(1)

//                if !showVectorImage {
                    if let image = AppImages.TypeWriters.getImageFor(typeWriterModel,
                                                                     imageType: showVectorImage
                                                                             ? .vector
                                                                             : .transparency,
                                                                     imageSize: imageSize) {
                        image.interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(0.93)
                            .padding(8)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .layoutPriority(3)
                            .animation(.interactiveSpring())
                    }
//                }

//                if showVectorImage {
//                    if let image = AppImages.TypeWriters.getImageFor(typeWriterModel,
//                                                                     imageType: .vector,
//                                                                     imageSize: imageSize) {
//                        image.interpolation(.none)
//                            .resizable()
//                            .scaledToFit()
//                            .scaleEffect(0.93)
//                            .padding(8)
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                            .layoutPriority(3)
//                            .animation(.easeOut(duration: 0.5))
//                    }
//                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .circular))
        .frame(minWidth: 60,
               maxWidth: .infinity,
               minHeight: 60,
               maxHeight: .infinity,
               alignment: .center)
        .onHover(perform: { hovering in
            showVectorImage = !hovering
        })
        .drawingGroup()
        .sheet(isPresented: $showTypeWriterInfoWindow,
               content: {
            #if os(macOS)
                TypeWriterInfoModal(optionInfo: TypeWriterMenuOptions().typeWriters.first!)
            #endif
        })
    }
}

struct TypeWriterImageButton_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterImageButton(onClick: { },
                              typeWriterModel: .Smith_Corona_Silent,
                              imageSize: .medium,
                              showBlurredImage: false)
    }
}
