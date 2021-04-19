//
//  iOSModifierFlags.swift
//  Typyst (iOS)
//
//  Created by Sean Wolford on 4/17/21.
//

import Foundation

//
//  MacOSModifierFlags.swift
//  Typyst (macOS)
//
//  Created by Sean Wolford on 4/17/21.
//

import UIKit
import Foundation

extension ModifierFlags {
    public convenience init(_ flags: UIKeyModifierFlags) {
        if flags.contains(.alphaShift) {
            insert(.capsLock)
        }

        if flags.contains(.shift) {
            insert(.shift)
        }

        if flags.contains(.control) {
            insert(.control)
        }

        if flags.contains(.alternate) {
            insert(.optionOrAlternate)
        }

        if flags.contains(.command) {
            insert(.command)
        }

        if flags.contains(.numericPad) {
            insert(.numericPad)
        }
    }
}