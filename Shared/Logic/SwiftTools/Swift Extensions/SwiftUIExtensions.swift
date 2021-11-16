//
//  SwiftUIExtensions.swift
//  Typyst
//
//  Created by Sean Wolford on 11/15/21.
//

import Foundation
import SwiftUI

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
