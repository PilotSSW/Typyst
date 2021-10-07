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

extension Double {
    func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}

extension String {
    func index(from index: Int) -> Index {
        return self.index(startIndex, offsetBy: index)
    }

    func substring(from indexVal: Int) -> String {
        let fromIndex = index(from: indexVal)
        return String(self[fromIndex...])
    }

    func substring(to indexVal: Int) -> String {
        let toIndex = index(from: indexVal)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
