//
//  ModifierFlags.swift
//  Typyst 
//
//  Created by Sean Wolford on 4/17/21.
//

import Foundation

struct ModifierFlags: OptionSet {
    internal let rawValue: Int16

    public static var capsLock: ModifierFlags = ModifierFlags(rawValue: 1)
    public static var command: ModifierFlags = ModifierFlags(rawValue: 1 << 1)
    public static var control: ModifierFlags = ModifierFlags(rawValue: 1 << 2)
    public static var function: ModifierFlags = ModifierFlags(rawValue: 1 << 3)
    public static var help: ModifierFlags = ModifierFlags(rawValue: 1 << 4)
    public static var numericPad: ModifierFlags = ModifierFlags(rawValue: 1 << 5)
    public static var optionOrAlternate: ModifierFlags = ModifierFlags(rawValue: 1 << 6)
    public static var shift: ModifierFlags = ModifierFlags(rawValue: 1 << 7)
    public static var deviceIndependentFlagsMask: ModifierFlags = ModifierFlags(rawValue: 1 << 8)
}

extension ModifierFlags: CustomStringConvertible {
    public var description: String {
        var output = [String]()

        if contains(.capsLock) { output.append(Key.capsLock.description) }
        if contains(.command) { output.append(Key.command.description) }
        if contains(.control) { output.append(Key.control.description) }
        if contains(.function) { output.append(Key.function.description) }
        if contains(.help) { output.append(Key.help.description) }
        if contains(.optionOrAlternate) { output.append(Key.option.description) }
        if contains(.shift) { output.append(Key.shift.description) }

        return output.joined(separator: ", ")
    }
}
