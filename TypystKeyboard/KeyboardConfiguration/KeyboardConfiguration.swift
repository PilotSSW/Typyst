//
//  KeyboardConfiguration.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 7/17/21.
//

import Foundation
import struct SwiftUI.CGFloat
import struct SwiftUI.CGSize

protocol KeyboardUIProperties {
    var bottomSpacing: CGFloat { get set }
    var rowSpacing: CGFloat { get set }
}

class KeyboardProperties {
    static func getPropertiesFor(_ model: TypeWriterModel.ModelType) -> KeyboardUIProperties {
        switch (model) {
        case .Olympia_SM3: return RoyalModelP()
        case .Royal_Model_P: return RoyalModelP()
        case .Smith_Corona_Silent: return RoyalModelP()
        default: return RoyalModelP()
        }
    }

    struct RoyalModelP: KeyboardUIProperties {
        var bottomSpacing: CGFloat = 1.0
        var rowSpacing: CGFloat = 3.0
    }
}
