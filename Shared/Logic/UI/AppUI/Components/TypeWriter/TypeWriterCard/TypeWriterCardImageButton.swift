//
// Created by Sean Wolford on 3/8/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftUI

struct TypeWriterImageButton: View {
    @State private var showVectorImage = true

    var onClick: (() -> Void)?
    var presentTypeWriterModal: Bool = false
    var optionInfo: TypeWriterMenuOption
    var imageSize: AppImages.ImageSize = .medium
    var showBlurredImage: Bool = true
    @State var showTypeWriterInfoWindow: Bool = false

    init(onClick: (() -> Void)? = nil,
         presentTypeWriterModal: Bool = false,
         optionInfo: TypeWriterMenuOption,
         imageSize: AppImages.ImageSize = .medium,
         showBlurredImage: Bool = true) {
        self.onClick = onClick
        self.optionInfo = optionInfo
        self.presentTypeWriterModal = presentTypeWriterModal
        self.imageSize = imageSize
        self.showBlurredImage = showBlurredImage
    }

    var body: some View {
        Button(action: {
            onClick?()
            if (presentTypeWriterModal && OSHelper.runtimeEnvironment == .macOS) { showTypeWriterInfoWindow = true }
        }) {
            ZStack {
                if showBlurredImage {
                    if let image = AppImages.TypeWriters.getImageFor(optionInfo.modelType,
                                                                     imageType: .transparency,
                                                                     imageSize: imageSize) {
                        image//.interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .offset(x: 12, y: 12)
                            .blur(radius: 40)
                            .blendMode(.exclusion)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }

                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(AppColor.ImageBackground)
                    .blendMode(.multiply)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                if let image = AppImages.TypeWriters.getImageFor(optionInfo.modelType,
                                                                 imageType: showVectorImage
                                                                         ? .vector
                                                                         : .transparency,
                                                                 imageSize: imageSize) {
                    image.interpolation(Image.Interpolation.high)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.93)
                        .padding(8)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .animation(.interactiveSpring(response: 0.25,
                                                      dampingFraction: 0.45,
                                                      blendDuration: 1.5))
                }
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
            TypeWriterInfoModal(optionInfo: optionInfo,
                                onClose: {
                    showTypeWriterInfoWindow = false
                })
                .frame(minWidth: 610, minHeight: 480)
            #endif
        })
    }
}

struct TypeWriterImageButton_Previews: PreviewProvider {
    static var previews: some View {
        TypeWriterImageButton(onClick: { },
                              optionInfo: TypeWriterMenuOption(.Olympia_SM3),
                              imageSize: .medium,
                              showBlurredImage: false)
    }
}
