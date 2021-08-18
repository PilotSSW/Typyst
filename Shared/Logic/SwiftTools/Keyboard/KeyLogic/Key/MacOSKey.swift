//
//  MacOSKey.swift
//  Typyst (macOS)
//
//  Created by Sean Wolford on 4/17/21.
//

import Carbon
import Foundation

extension Key {
    public init?(carbonKeyCode: UInt32) {
        switch carbonKeyCode {
        case UInt32(kVK_ANSI_A): self = .a
        case UInt32(kVK_ANSI_S): self = .s
        case UInt32(kVK_ANSI_D): self = .d
        case UInt32(kVK_ANSI_F): self = .f
        case UInt32(kVK_ANSI_H): self = .h
        case UInt32(kVK_ANSI_G): self = .g
        case UInt32(kVK_ANSI_Z): self = .z
        case UInt32(kVK_ANSI_X): self = .x
        case UInt32(kVK_ANSI_C): self = .c
        case UInt32(kVK_ANSI_V): self = .v
        case UInt32(kVK_ANSI_B): self = .b
        case UInt32(kVK_ANSI_Q): self = .q
        case UInt32(kVK_ANSI_W): self = .w
        case UInt32(kVK_ANSI_E): self = .e
        case UInt32(kVK_ANSI_R): self = .r
        case UInt32(kVK_ANSI_Y): self = .y
        case UInt32(kVK_ANSI_T): self = .t
        case UInt32(kVK_ANSI_1): self = .one
        case UInt32(kVK_ANSI_2): self = .two
        case UInt32(kVK_ANSI_3): self = .three
        case UInt32(kVK_ANSI_4): self = .four
        case UInt32(kVK_ANSI_6): self = .six
        case UInt32(kVK_ANSI_5): self = .five
        case UInt32(kVK_ANSI_Equal): self = .equal
        case UInt32(kVK_ANSI_9): self = .nine
        case UInt32(kVK_ANSI_7): self = .seven
        case UInt32(kVK_ANSI_Minus): self = .minus
        case UInt32(kVK_ANSI_8): self = .eight
        case UInt32(kVK_ANSI_0): self = .zero
        case UInt32(kVK_ANSI_RightBracket): self = .rightBracket
        case UInt32(kVK_ANSI_O): self = .o
        case UInt32(kVK_ANSI_U): self = .u
        case UInt32(kVK_ANSI_LeftBracket): self = .leftBracket 
        case UInt32(kVK_ANSI_I): self = .i
        case UInt32(kVK_ANSI_P): self = .p
        case UInt32(kVK_ANSI_L): self = .l
        case UInt32(kVK_ANSI_J): self = .j
        case UInt32(kVK_ANSI_Quote): self = .quote
        case UInt32(kVK_ANSI_K): self = .k
        case UInt32(kVK_ANSI_Semicolon): self = .semicolon
        case UInt32(kVK_ANSI_Backslash): self = .backslash
        case UInt32(kVK_ANSI_Comma): self = .comma
        case UInt32(kVK_ANSI_Slash): self = .slash
        case UInt32(kVK_ANSI_N): self = .n
        case UInt32(kVK_ANSI_M): self = .m
        case UInt32(kVK_ANSI_Period): self = .period
        case UInt32(kVK_ANSI_Grave): self = .grave
        case UInt32(kVK_ANSI_KeypadDecimal): self = .keypadDecimal
        case UInt32(kVK_ANSI_KeypadMultiply): self = .keypadMultiply
        case UInt32(kVK_ANSI_KeypadPlus): self = .keypadPlus
        case UInt32(kVK_ANSI_KeypadClear): self = .keypadClear
        case UInt32(kVK_ANSI_KeypadDivide): self = .keypadDivide
        case UInt32(kVK_ANSI_KeypadEnter): self = .keypadEnter
        case UInt32(kVK_ANSI_KeypadMinus): self = .keypadMinus
        case UInt32(kVK_ANSI_KeypadEquals): self = .keypadEquals
        case UInt32(kVK_ANSI_Keypad0): self = .keypad0
        case UInt32(kVK_ANSI_Keypad1): self = .keypad1
        case UInt32(kVK_ANSI_Keypad2): self = .keypad2
        case UInt32(kVK_ANSI_Keypad3): self = .keypad3
        case UInt32(kVK_ANSI_Keypad4): self = .keypad4
        case UInt32(kVK_ANSI_Keypad5): self = .keypad5
        case UInt32(kVK_ANSI_Keypad6): self = .keypad6
        case UInt32(kVK_ANSI_Keypad7): self = .keypad7
        case UInt32(kVK_ANSI_Keypad8): self = .keypad8
        case UInt32(kVK_ANSI_Keypad9): self = .keypad9
        case UInt32(kVK_Return): self = .`return`
        case UInt32(kVK_Tab): self = .tab
        case UInt32(kVK_Space): self = .space
        case UInt32(kVK_Delete): self = .delete
        case UInt32(kVK_Escape): self = .escape
        case UInt32(kVK_Command): self = .command
        case UInt32(kVK_Shift): self = .shift
        case UInt32(kVK_CapsLock): self = .capsLock
        case UInt32(kVK_Option): self = .option
        case UInt32(kVK_Control): self = .control
        case UInt32(kVK_RightCommand): self = .rightCommand
        case UInt32(kVK_RightShift): self = .rightShift
        case UInt32(kVK_RightOption): self = .rightOption
        case UInt32(kVK_RightControl): self = .rightControl
        case UInt32(kVK_Function): self = .function
        case UInt32(kVK_F17): self = .f17
        case UInt32(kVK_VolumeUp): self = .volumeUp
        case UInt32(kVK_VolumeDown): self = .volumeDown
        case UInt32(kVK_Mute): self = .mute
        case UInt32(kVK_F18): self = .f18
        case UInt32(kVK_F19): self = .f19
        case UInt32(kVK_F20): self = .f20
        case UInt32(kVK_F5): self = .f5
        case UInt32(kVK_F6): self = .f6
        case UInt32(kVK_F7): self = .f7
        case UInt32(kVK_F3): self = .f3
        case UInt32(kVK_F8): self = .f8
        case UInt32(kVK_F9): self = .f9
        case UInt32(kVK_F11): self = .f11
        case UInt32(kVK_F13): self = .f13
        case UInt32(kVK_F16): self = .f16
        case UInt32(kVK_F14): self = .f14
        case UInt32(kVK_F10): self = .f10
        case UInt32(kVK_F12): self = .f12
        case UInt32(kVK_F15): self = .f15
        case UInt32(kVK_Help): self = .help
        case UInt32(kVK_Home): self = .home
        case UInt32(kVK_PageUp): self = .pageUp
        case UInt32(kVK_ForwardDelete): self = .forwardDelete
        case UInt32(kVK_F4): self = .f4
        case UInt32(kVK_End): self = .end
        case UInt32(kVK_F2): self = .f2
        case UInt32(kVK_PageDown): self = .pageDown
        case UInt32(kVK_F1): self = .f1
        case UInt32(kVK_LeftArrow): self = .leftArrow
        case UInt32(kVK_RightArrow): self = .rightArrow
        case UInt32(kVK_DownArrow): self = .downArrow
        case UInt32(kVK_UpArrow): self = .upArrow
        default: return nil
        }
    }

    public var carbonKeyCode: UInt32 {
        switch self {
        case .a: return UInt32(kVK_ANSI_A)
        case .s: return UInt32(kVK_ANSI_S)
        case .d: return UInt32(kVK_ANSI_D)
        case .f: return UInt32(kVK_ANSI_F)
        case .h: return UInt32(kVK_ANSI_H)
        case .g: return UInt32(kVK_ANSI_G)
        case .z: return UInt32(kVK_ANSI_Z)
        case .x: return UInt32(kVK_ANSI_X)
        case .c: return UInt32(kVK_ANSI_C)
        case .v: return UInt32(kVK_ANSI_V)
        case .b: return UInt32(kVK_ANSI_B)
        case .q: return UInt32(kVK_ANSI_Q)
        case .w: return UInt32(kVK_ANSI_W)
        case .e: return UInt32(kVK_ANSI_E)
        case .r: return UInt32(kVK_ANSI_R)
        case .y: return UInt32(kVK_ANSI_Y)
        case .t: return UInt32(kVK_ANSI_T)
        case .one: return UInt32(kVK_ANSI_1)
        case .two: return UInt32(kVK_ANSI_2)
        case .three: return UInt32(kVK_ANSI_3)
        case .four: return UInt32(kVK_ANSI_4)
        case .six: return UInt32(kVK_ANSI_6)
        case .five: return UInt32(kVK_ANSI_5)
        case .equal: return UInt32(kVK_ANSI_Equal)
        case .nine: return UInt32(kVK_ANSI_9)
        case .seven: return UInt32(kVK_ANSI_7)
        case .minus: return UInt32(kVK_ANSI_Minus)
        case .eight: return UInt32(kVK_ANSI_8)
        case .zero: return UInt32(kVK_ANSI_0)
        case .rightBracket: return UInt32(kVK_ANSI_RightBracket)
        case .o: return UInt32(kVK_ANSI_O)
        case .u: return UInt32(kVK_ANSI_U)
        case .leftBracket: return UInt32(kVK_ANSI_LeftBracket)
        case .i: return UInt32(kVK_ANSI_I)
        case .p: return UInt32(kVK_ANSI_P)
        case .l: return UInt32(kVK_ANSI_L)
        case .j: return UInt32(kVK_ANSI_J)
        case .quote: return UInt32(kVK_ANSI_Quote)
        case .k: return UInt32(kVK_ANSI_K)
        case .semicolon: return UInt32(kVK_ANSI_Semicolon)
        case .backslash: return UInt32(kVK_ANSI_Backslash)
        case .comma: return UInt32(kVK_ANSI_Comma)
        case .slash: return UInt32(kVK_ANSI_Slash)
        case .n: return UInt32(kVK_ANSI_N)
        case .m: return UInt32(kVK_ANSI_M)
        case .period: return UInt32(kVK_ANSI_Period)
        case .grave: return UInt32(kVK_ANSI_Grave)
        case .keypadDecimal: return UInt32(kVK_ANSI_KeypadDecimal)
        case .keypadMultiply: return UInt32(kVK_ANSI_KeypadMultiply)
        case .keypadPlus: return UInt32(kVK_ANSI_KeypadPlus)
        case .keypadClear: return UInt32(kVK_ANSI_KeypadClear)
        case .keypadDivide: return UInt32(kVK_ANSI_KeypadDivide)
        case .keypadEnter: return UInt32(kVK_ANSI_KeypadEnter)
        case .keypadMinus: return UInt32(kVK_ANSI_KeypadMinus)
        case .keypadEquals: return UInt32(kVK_ANSI_KeypadEquals)
        case .keypad0: return UInt32(kVK_ANSI_Keypad0)
        case .keypad1: return UInt32(kVK_ANSI_Keypad1)
        case .keypad2: return UInt32(kVK_ANSI_Keypad2)
        case .keypad3: return UInt32(kVK_ANSI_Keypad3)
        case .keypad4: return UInt32(kVK_ANSI_Keypad4)
        case .keypad5: return UInt32(kVK_ANSI_Keypad5)
        case .keypad6: return UInt32(kVK_ANSI_Keypad6)
        case .keypad7: return UInt32(kVK_ANSI_Keypad7)
        case .keypad8: return UInt32(kVK_ANSI_Keypad8)
        case .keypad9: return UInt32(kVK_ANSI_Keypad9)
        case .`return`: return UInt32(kVK_Return)
        case .tab: return UInt32(kVK_Tab)
        case .space: return UInt32(kVK_Space)
        case .delete: return UInt32(kVK_Delete)
        case .escape: return UInt32(kVK_Escape)
        case .command: return UInt32(kVK_Command)
        case .shift: return UInt32(kVK_Shift)
        case .capsLock: return UInt32(kVK_CapsLock)
        case .option: return UInt32(kVK_Option)
        case .control: return UInt32(kVK_Control)
        case .rightCommand: return UInt32(kVK_RightCommand)
        case .rightShift: return UInt32(kVK_RightShift)
        case .rightOption: return UInt32(kVK_RightOption)
        case .rightControl: return UInt32(kVK_RightControl)
        case .function: return UInt32(kVK_Function)
        case .f17: return UInt32(kVK_F17)
        case .volumeUp: return UInt32(kVK_VolumeUp)
        case .volumeDown: return UInt32(kVK_VolumeDown)
        case .mute: return UInt32(kVK_Mute)
        case .f18: return UInt32(kVK_F18)
        case .f19: return UInt32(kVK_F19)
        case .f20: return UInt32(kVK_F20)
        case .f5: return UInt32(kVK_F5)
        case .f6: return UInt32(kVK_F6)
        case .f7: return UInt32(kVK_F7)
        case .f3: return UInt32(kVK_F3)
        case .f8: return UInt32(kVK_F8)
        case .f9: return UInt32(kVK_F9)
        case .f11: return UInt32(kVK_F11)
        case .f13: return UInt32(kVK_F13)
        case .f16: return UInt32(kVK_F16)
        case .f14: return UInt32(kVK_F14)
        case .f10: return UInt32(kVK_F10)
        case .f12: return UInt32(kVK_F12)
        case .f15: return UInt32(kVK_F15)
        case .help: return UInt32(kVK_Help)
        case .home: return UInt32(kVK_Home)
        case .pageUp: return UInt32(kVK_PageUp)
        case .forwardDelete: return UInt32(kVK_ForwardDelete)
        case .f4: return UInt32(kVK_F4)
        case .end: return UInt32(kVK_End)
        case .f2: return UInt32(kVK_F2)
        case .pageDown: return UInt32(kVK_PageDown)
        case .f1: return UInt32(kVK_F1)
        case .leftArrow: return UInt32(kVK_LeftArrow)
        case .rightArrow: return UInt32(kVK_RightArrow)
        case .downArrow: return UInt32(kVK_DownArrow)
        case .upArrow: return UInt32(kVK_UpArrow)
            
        // Unimplemented
        case .letters: return UInt32(2 >> 32)
        case .numbers: return UInt32(2 >> 32)
        case .specials: return UInt32(2 >> 32)
        case .ampersand: return UInt32(2 >> 32)
        case .atSymbol: return UInt32(2 >> 32)
        case .binaryVerticalBar: return UInt32(2 >> 32)
        case .leftBrace: return UInt32(2 >> 32)
        case .rightBrace: return UInt32(2 >> 32)
        case .bulletMark: return UInt32(2 >> 32)
        case .caretLeft: return UInt32(2 >> 32)
        case .caretRight: return UInt32(2 >> 32)
        case .caretUp: return UInt32(2 >> 32)
        case .colon: return UInt32(2 >> 32)
        case .dollarSign: return UInt32(2 >> 32)
        case .doubleQuotes: return UInt32(2 >> 32)
        case .euroCurrencySymbol: return UInt32(2 >> 32)
        case .exclamationPoint: return UInt32(2 >> 32)
        case .nextKeyboardGlobe: return UInt32(2 >> 32)
        case .leftParenthesis: return UInt32(2 >> 32)
        case .rightParenthesis: return UInt32(2 >> 32)
        case .percentage: return UInt32(2 >> 32)
        case .poundCurrencySymbol: return UInt32(2 >> 32)
        case .poundSign: return UInt32(2 >> 32)
        case .plus: return UInt32(2 >> 32)
        case .questionMark: return UInt32(2 >> 32)
        case .settings: return UInt32(2 >> 32)
        case .star: return UInt32(2 >> 32)
        case .tilda: return UInt32(2 >> 32)
        case .underscore: return UInt32(2 >> 32)
        case .yenCurrencySymbol: return UInt32(2 >> 32)
        }
    }
}
