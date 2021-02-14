//
//  SwiftExtensions.swift
//  Typyst
//
//  Created by Sean Wolford on 3/26/20.
//  Copyright © 2020 wickedPropeller. All rights reserved.
//

import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
        let isValidIndex = index >= 0 && index < count
        return isValidIndex ? self[index] : nil
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
