//
// Created by Sean Wolford on 2019-01-16.
// Copyright (c) 2019 wickedPropeller. All rights reserved.
//

import Foundation
import HotKey

typealias KeySet = Set<Key>
// Recognized keypresses
class KeySets {
    static let letters: [Key] =
            [.a, .b, .c, .d, .e, .f, .g, .h, .i, .j, .k, .l, .m,
             .n, .o, .p, .q, .r, .s, .t, .u, .v, .x, .y, .z]

    static let numbers: [Key] =
            [.zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine,
             .keypad0, .keypad1, .keypad2, .keypad3, .keypad4, .keypad5, .keypad6,
             .keypad7, .keypad8, .keypad9]

    static let keypads: [Key] =
            [.keypadEnter, .keypadDecimal, .keypadDivide, .keypadDivide,
             .keypadEquals, .keypadMinus, .keypadMultiply, .keypadPlus]

    static let functions: [ Key] =
            [.f1, .f2, .f3, .f4, .f5, .f6, .f7, .f8, .f9, .f10, .f11,
             .f12, .f13, .f14, .f15, .f16, .f17, .f18, .f19, .f20]

    static let commands: [Key] =
            [.command, .rightCommand, .control, .rightControl, .option, .rightOption]

    static let special: [Key] =
            []

    static let shift: [Key] =
            [.shift, .rightShift]

    static let bell: [Key] =
            [.home, .help]
}
