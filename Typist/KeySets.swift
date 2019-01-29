//
// Created by Sean Wolford on 2019-01-16.
// Copyright (c) 2019 wickedPropeller. All rights reserved.
//

import Foundation
import HotKey

// Recognized keypresses
let letterSet: [Key] =
    [.a, .b, .c, .d, .e, .f, .g, .h, .i, .j, .k, .l, .m, .n, .o, .p, .q, .r, .s, .t, .u, .v, .x, .y, .z]

let numberSet: [Key] =
    [.zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine,
     .keypad0, .keypad1, .keypad2, .keypad3, .keypad4, .keypad5, .keypad6, .keypad7, .keypad8, .keypad9]

let keypadSet: [Key] =
    [.keypadEnter, .keypadDecimal, .keypadDivide, .keypadDivide,
     .keypadEquals, .keypadMinus, .keypadMultiply, .keypadPlus]

let functionSet: [Key] =
    [.f1, .f2, .f3, .f4, .f5, .f6, .f7, .f8, .f9, .f10, .f11, .f12, .f13, .f14, .f15, .f16, .f17, .f18, .f19, .f20]

let commandSet: [Key] =
    [.command, .rightCommand, .control, .rightControl, .option, .rightOption]

let specialKeys: [Key] =
    []

let shiftSet: [Key] =
    [.shift, .rightShift]

let bellSet: [Key] =
    [.home, .help]