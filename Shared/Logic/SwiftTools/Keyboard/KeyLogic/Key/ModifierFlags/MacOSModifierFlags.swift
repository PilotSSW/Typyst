//
//  MacOSModifierFlags.swift
//  Typyst (macOS)
//
//  Created by Sean Wolford on 4/17/21.
//

import AppKit
import Carbon
import Foundation

extension ModifierFlags {
    public init(_ flags: NSEvent.ModifierFlags) {
        self.init()
        
        if flags.contains(.capsLock) {
            insert(.capsLock)
        }

        if flags.contains(.command) {
            insert(.command)
        }

        if flags.contains(.control) {
            insert(.control)
        }

        if flags.contains(.function) {
            insert(.function)
        }

        if flags.contains(.help) {
            insert(.help)
        }

        if flags.contains(.numericPad) {
            insert(.numericPad)
        }

        if flags.contains(.option) {
            insert(.optionOrAlternate)
        }

        if flags.contains(.shift) {
            insert(.shift)
        }

        if flags.contains(.deviceIndependentFlagsMask) {
            insert(.deviceIndependentFlagsMask)
        }
    }

    public init(carbonFlags: UInt32) {
        self.init()

        if carbonFlags & UInt32(alphaLock) == UInt32(alphaLock) {
            insert(.capsLock)
        }

        if carbonFlags & UInt32(cmdKey) == UInt32(cmdKey) {
            insert(.command)
        }

        if carbonFlags & UInt32(controlKey) == UInt32(controlKey) {
            insert(.control)
        }

        if carbonFlags & UInt32(kFunctionKeyCharCode) == UInt32(kFunctionKeyCharCode) {
            insert(.function)
        }

        if carbonFlags & UInt32(kVK_Help) == UInt32(kVK_Help) {
            insert(.help)
        }

        if carbonFlags & UInt32(optionKey) == UInt32(optionKey) {
            insert(.optionOrAlternate)
        }

        if carbonFlags & UInt32(shiftKey) == UInt32(shiftKey) {
            insert(.shift)
        }
    }
}

extension NSEvent.ModifierFlags {
    public var carbonFlags: UInt32 {
        var carbonFlags: UInt32 = 0

        if contains(.capsLock) {
            carbonFlags |= UInt32(alphaLock)
        }

        if contains(.command) {
            carbonFlags |= UInt32(cmdKey)
        }

        if contains(.control) {
            carbonFlags |= UInt32(controlKey)
        }

        if contains(.function) {
            carbonFlags |= UInt32(kFunctionKeyCharCode)
        }

        if contains(.help) {
            carbonFlags |= UInt32(kVK_Help)
        }

//        if contains(.numericPad) {
//            carbonFlags |= UInt32(optionKey)
//        }

        if contains(.option) {
            carbonFlags |= UInt32(optionKey)
        }

        if contains(.shift) {
            carbonFlags |= UInt32(shiftKey)
        }

        return carbonFlags
    }
}

