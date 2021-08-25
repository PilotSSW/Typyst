//
//  Images.swift
//  Typyst
//
//  Created by Sean Wolford on 8/24/21.
//

import Foundation
import struct SwiftUI.Image

class AppImages {
    enum ImageSize: Int {
        case large = 0
        case medium = 1
        case small = 2
        case thumbnail = 3
    }
}

/// Mark: TypeWriter Images
extension AppImages {
    struct TypeWriters {
        enum ImageType {
            case transparency
            case vector
        }

        public static func getImagePathFor(_ typeWriter: TypeWriterModel.ModelType, imageType: ImageType, imageSize: ImageSize) -> String? {

            var imagePath = "TypeWriter/\(typeWriter.rawValue)"
            let typeWriterImage = imageType == .transparency
                ? "Transparencies"
                : "Vectors"

            imagePath += "/\(typeWriterImage)"

            switch(imageSize) {
                case .large: imagePath += "/large"
                case .medium: imagePath += "/medium"
                case .small: imagePath += "/small"
                case .thumbnail: imagePath += "/thumbnail"
            }

            return imagePath
        }

        public static func getImageFor(_ typeWriter: TypeWriterModel.ModelType, imageType: ImageType, imageSize: ImageSize) -> Image? {
            if let path = getImagePathFor(typeWriter, imageType: imageType, imageSize: imageSize) {
                return Image(path)
            }

            return nil
        }
    }
}
