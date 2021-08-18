//
//  Key.swift
//  Typyst 
//
//  Created by Sean Wolford on 4/17/21.
//

import Foundation

public enum Key {

    // MARK: - Letters
    case a
    case b
    case c
    case d
    case e
    case f
    case g
    case h
    case i
    case j
    case k
    case l
    case m
    case n
    case o
    case p
    case q
    case r
    case s
    case t
    case u
    case v
    case w
    case x
    case y
    case z

    // MARK: - Numbers
    case zero
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine

    // MARK: - Symbols
    case ampersand
    case atSymbol
    case backslash
    case binaryVerticalBar
    case leftBrace
    case rightBrace
    case leftBracket
    case rightBracket
    case bulletMark
    case caretLeft
    case caretRight
    case caretUp
    case colon
    case semicolon
    case comma
    case dollarSign
    case equal
    case euroCurrencySymbol
    case exclamationPoint
    case grave // Backtick
    case minus
    case leftParenthesis
    case rightParenthesis
    case percentage
    case period
    case poundCurrencySymbol
    case poundSign
    case plus
    case questionMark
    case quote
    case doubleQuotes
    case slash
    case star
    case tilda
    case underscore
    case yenCurrencySymbol

    // MARK: - Whitespace
    case space
    case tab
    case `return`

    // MARK: - Modifiers
    case command
    case rightCommand
    case option
    case rightOption
    case control
    case rightControl
    case shift
    case rightShift
    case function
    case capsLock

    // MARK: - Navigation
    case pageUp
    case pageDown
    case home
    case end
    case upArrow
    case rightArrow
    case downArrow
    case leftArrow

    // MARK: - Functions
    case f1
    case f2
    case f3
    case f4
    case f5
    case f6
    case f7
    case f8
    case f9
    case f10
    case f11
    case f12
    case f13
    case f14
    case f15
    case f16
    case f17
    case f18
    case f19
    case f20

    // MARK: - Keypad
    case keypad0
    case keypad1
    case keypad2
    case keypad3
    case keypad4
    case keypad5
    case keypad6
    case keypad7
    case keypad8
    case keypad9
    case keypadClear
    case keypadDecimal
    case keypadDivide
    case keypadEnter
    case keypadEquals
    case keypadMinus
    case keypadMultiply
    case keypadPlus

    // MARK: - Misc
    case escape
    case delete
    case forwardDelete
    case help
    case volumeUp
    case volumeDown
    case mute

    // MARK: - iOS / iPadOS / TvOS / WatchOS
    case letters
    case numbers
    case settings
    case specials
    case nextKeyboardGlobe

    // MARK: - Initializers
    public init?(string: String) {
        switch string.lowercased() {
        // MARK: Letters
        case "a": self = .a
        case "b": self = .b
        case "c": self = .c
        case "d": self = .d
        case "e": self = .e
        case "f": self = .f
        case "g": self = .g
        case "h": self = .h
        case "i": self = .i
        case "j": self = .j
        case "k": self = .k
        case "l": self = .l
        case "m": self = .m
        case "n": self = .n
        case "o": self = .o
        case "p": self = .p
        case "q": self = .q
        case "r": self = .r
        case "s": self = .s
        case "t": self = .t
        case "u": self = .u
        case "v": self = .v
        case "w": self = .w
        case "x": self = .x
        case "y": self = .y
        case "z": self = .z

        // MARK: Numbers
        case "one", "1": self = .one
        case "two", "2": self = .two
        case "three", "3": self = .three
        case "four", "4": self = .four
        case "five", "5": self = .five
        case "six", "6": self = .six
        case "seven", "7": self = .seven
        case "eight", "8": self = .eight
        case "nine", "9": self = .nine
        case "zero", "0": self = .zero

        // MARK: Operators
        case "equal", "=": self = .equal
        case "minus", "-": self = .minus
        case "leftBracket", "[": self = .leftBracket
        case "rightBracket", "]": self = .rightBracket
        case "quote", "\"": self = .quote
        case "semicolon", ";": self = .semicolon
        case "backslash", "\\": self = .backslash
        case "comma", ",": self = .comma
        case "slash", "/": self = .slash
        case "period", ".": self = .period
        case "grave", "`", "ˋ", "｀": self = .grave
        case "return", "\r", "↩︎", "⏎", "⮐": self = .return
        case "tab", "\t", "⇥": self = .tab
        case "space", " ", "␣": self = .space
        case "delete", "⌫": self = .delete
        case "escape", "⎋": self = .escape
        case "capslock", "⇪": self = .capsLock

        // MARK: OS Modifier Keys
        case "command", "⌘", "": self = .command
        case "rightcommand": self = .rightCommand
        case "option", "⌥": self = .option
        case "rightoption": self = .rightOption
        case "shift", "⇧": self = .shift
        case "rightshift": self = .rightShift
        case "control", "⌃": self = .control
        case "rightcontrol": self = .rightControl

        case "volumeup", "🔊": self = .volumeUp
        case "volumedown", "🔉": self = .volumeDown
        case "mute", "🔇": self = .mute

        // MARK: Function keys
        case "function", "fn": self = .function
        case "f1", "F1": self = .f1
        case "f2", "F2": self = .f2
        case "f3", "F3": self = .f3
        case "f4", "F4": self = .f4
        case "f5", "F5": self = .f5
        case "f6", "F6": self = .f6
        case "f7", "F7": self = .f7
        case "f8", "F8": self = .f8
        case "f9", "F9": self = .f9
        case "f10", "F10": self = .f10
        case "f11", "F11": self = .f11
        case "f12", "F12": self = .f12
        case "f13", "F13": self = .f13
        case "f14", "F14": self = .f14
        case "f15", "F15": self = .f15
        case "f16", "F16": self = .f16
        case "f17", "F17": self = .f17
        case "f18", "F18": self = .f18
        case "f19", "F19": self = .f19
        case "f20", "F20": self = .f20

        // MARK: Mid-keyboard controls
        case "help", "?⃝": self = .help
        case "home", "↖": self = .home
        case "pageup", "⇞": self = .pageUp
        case "forwarddelete", "⌦": self = .forwardDelete
        case "end", "↘": self = .end
        case "pagedown", "⇟": self = .pageDown
        case "leftarrow", "←": self = .leftArrow
        case "rightarrow", "→": self = .rightArrow
        case "downarrow", "↓": self = .downArrow
        case "uparrow", "↑": self = .upArrow

        // MARK : Mobile / Software-only keys
        case "letters": self = .letters
        case "numbers": self = .numbers
        case "specials": self = .specials
        case "nextKeyboardGlobe": self = .nextKeyboardGlobe

        // MARK: Keypad
        case "keypaddecimal": self = .keypadDecimal
        case "keypadmultiply": self = .keypadMultiply
        case "keypaddivide": self = .keypadDivide
        case "keypadplus": self = .keypadPlus
        case "keypadminus": self = .keypadMinus
        case "keypadequals": self = .keypadEquals
        case "keypadenter": self = .keypadEnter
        case "keypadclear", "⌧": self = .keypadClear
        case "keypad0": self = .keypad0
        case "keypad1": self = .keypad1
        case "keypad2": self = .keypad2
        case "keypad3": self = .keypad3
        case "keypad4": self = .keypad4
        case "keypad5": self = .keypad5
        case "keypad6": self = .keypad6
        case "keypad7": self = .keypad7
        case "keypad8": self = .keypad8
        case "keypad9": self = .keypad9
        default: return nil
        }
    }
}

extension Key: CustomStringConvertible {
    public var description: String {
        switch  self {
        // MARK: Letters
        case .a: return "A"
        case .b: return "B"
        case .c: return "C"
        case .d: return "D"
        case .e: return "E"
        case .f: return "F"
        case .g: return "G"
        case .h: return "H"
        case .i: return "I"
        case .j: return "J"
        case .k: return "K"
        case .l: return "L"
        case .m: return "M"
        case .n: return "N"
        case .o: return "O"
        case .p: return "P"
        case .q: return "Q"
        case .r: return "R"
        case .s: return "S"
        case .t: return "T"
        case .u: return "U"
        case .v: return "V"
        case .w: return "W"
        case .x: return "X"
        case .y: return "Y"
        case .z: return "Z"

        // MARK: Numbers / Keypad
        case .one, .keypad1: return "1"
        case .two, .keypad2: return "2"
        case .three, .keypad3: return "3"
        case .four, .keypad4: return "4"
        case .five, .keypad5: return "5"
        case .six, .keypad6: return "6"
        case .seven, .keypad7: return "7"
        case .eight, .keypad8: return "8"
        case .nine, .keypad9: return "9"
        case .zero, .keypad0: return "0"

        // MARK: Keypad
        case .keypadDecimal: return "."
        case .keypadMultiply: return "𝗑"
        case .keypadPlus: return "+"
        case .keypadClear: return "⌧"
        case .keypadDivide: return "/"
        case .keypadEnter: return "↩︎"
        case .keypadMinus: return "-"
        case .keypadEquals: return "="

        // MARK: Specials
        case .leftBracket: return "["
        case .rightBracket: return "]"
        case .quote: return "\""
        case .semicolon: return ";"
        case .backslash: return "\\"
        case .comma: return ","
        case .slash: return "/"
        case .period: return "."
        case .grave: return "`"
        case .minus: return "-"
        case .equal: return "="
        case .`return`: return "↩︎"
        case .tab: return "⇥"
        case .space: return "␣"
        case .delete: return "⌫"
        case .escape: return "⎋"
        case .ampersand: return "&"
        case .atSymbol: return "@"
        case .colon: return ":"
        case .dollarSign: return "$"
        case .exclamationPoint: return  "!"
        case .leftParenthesis: return "("
        case .rightParenthesis: return ")"
        case .plus: return "+"
        case .questionMark: return "?"
        case .doubleQuotes: return "\""
        case .binaryVerticalBar: return "|"
        case .leftBrace: return "{"
        case .rightBrace: return "}"
        case .bulletMark: return "•"
        case .caretLeft: return "<"
        case .caretRight: return ">"
        case .caretUp: return "^"
        case .euroCurrencySymbol: return "€"
        case .percentage: return "%"
        case .poundCurrencySymbol: return "£"
        case .poundSign: return "#"
        case .star: return "*"
        case .tilda: return "~"
        case .underscore: return "_"
        case .yenCurrencySymbol: return "¥"

        // MARK: Device Controls
        case .volumeUp: return "🔊"
        case .volumeDown: return "🔉"
        case .mute: return "🔇"

        // MARK: Mid-keyboard Controls
        case .forwardDelete: return "⌦"
        case .help: return "?⃝"
        case .home: return "↖"
        case .end: return "↘"
        case .pageUp: return "⇞"
        case .pageDown: return "⇟"
        case .leftArrow: return "←"
        case .rightArrow: return "→"
        case .downArrow: return "↓"
        case .upArrow: return "↑"

        // MARK: OS Modifier Keys
        case .command, .rightCommand: return "⌘"
        case .shift, .rightShift: return "⇧"
        case .capsLock: return "⇪"
        case .option, .rightOption: return "⌥"
        case .control, .rightControl: return "⌃"

        // MARK: Functions Keys
        case .function: return "fn"
        case .f1: return "F1"
        case .f2: return "F2"
        case .f3: return "F3"
        case .f4: return "F4"
        case .f5: return "F5"
        case .f6: return "F6"
        case .f7: return "F7"
        case .f8: return "F8"
        case .f9: return "F9"
        case .f10: return "F10"
        case .f11: return "F11"
        case .f12: return "F12"
        case .f13: return "F13"
        case .f14: return "F14"
        case .f15: return "F15"
        case .f16: return "F16"
        case .f17: return "F17"
        case .f18: return "F18"
        case .f19: return "F19"
        case .f20: return "F20"

        // MARK: Mobile Keys
        case .letters: return "ABC"
        case .numbers: return "123"
        case .settings: return "⚙"
        case .specials: return "#+="
        case .nextKeyboardGlobe: return "🌐"
        }
    }

    public var stringValue: String {
        switch  self {
        // MARK: Letters
        case .a: return "A"
        case .b: return "B"
        case .c: return "C"
        case .d: return "D"
        case .e: return "E"
        case .f: return "F"
        case .g: return "G"
        case .h: return "H"
        case .i: return "I"
        case .j: return "J"
        case .k: return "K"
        case .l: return "L"
        case .m: return "M"
        case .n: return "N"
        case .o: return "O"
        case .p: return "P"
        case .q: return "Q"
        case .r: return "R"
        case .s: return "S"
        case .t: return "T"
        case .u: return "U"
        case .v: return "V"
        case .w: return "W"
        case .x: return "X"
        case .y: return "Y"
        case .z: return "Z"

        // MARK: Numbers / Keypad
        case .one, .keypad1: return "1"
        case .two, .keypad2: return "2"
        case .three, .keypad3: return "3"
        case .four, .keypad4: return "4"
        case .five, .keypad5: return "5"
        case .six, .keypad6: return "6"
        case .seven, .keypad7: return "7"
        case .eight, .keypad8: return "8"
        case .nine, .keypad9: return "9"
        case .zero, .keypad0: return "0"

        // MARK: Keypad
        case .keypadDecimal: return "."
        case .keypadMultiply: return "𝗑"
        case .keypadPlus: return "+"
        case .keypadClear: return "⌧"
        case .keypadDivide: return "/"
        case .keypadEnter: return "↩︎"
        case .keypadMinus: return "-"
        case .keypadEquals: return "="

        // MARK: Specials
        case .leftBracket: return "["
        case .rightBracket: return "]"
        case .quote: return "\""
        case .semicolon: return ";"
        case .backslash: return "\\"
        case .comma: return ","
        case .slash: return "/"
        case .period: return "."
        case .grave: return "`"
        case .minus: return "-"
        case .equal: return "="
        case .`return`: return "↩︎"
        case .tab: return "⇥"
        case .space: return "␣"
        case .delete: return "⌫"
        case .escape: return "⎋"
        case .ampersand: return "&"
        case .atSymbol: return "@"
        case .colon: return ":"
        case .dollarSign: return "$"
        case .exclamationPoint: return  "!"
        case .leftParenthesis: return "("
        case .rightParenthesis: return ")"
        case .plus: return "+"
        case .questionMark: return "?"
        case .doubleQuotes: return "\""
        case .binaryVerticalBar: return "|"
        case .leftBrace: return "{"
        case .rightBrace: return "}"
        case .bulletMark: return "•"
        case .caretLeft: return "<"
        case .caretRight: return ">"
        case .caretUp: return "^"
        case .euroCurrencySymbol: return "€"
        case .percentage: return "%"
        case .poundCurrencySymbol: return "£"
        case .poundSign: return "#"
        case .star: return "*"
        case .tilda: return "~"
        case .underscore: return "_"
        case .yenCurrencySymbol: return "¥"

        // MARK: Device Controls
        case .volumeUp: return "🔊"
        case .volumeDown: return "🔉"
        case .mute: return "🔇"

        // MARK: Mid-keyboard Controls
        case .forwardDelete: return "⌦"
        case .help: return "?⃝"
        case .home: return "↖"
        case .end: return "↘"
        case .pageUp: return "⇞"
        case .pageDown: return "⇟"
        case .leftArrow: return "←"
        case .rightArrow: return "→"
        case .downArrow: return "↓"
        case .upArrow: return "↑"

        // MARK: OS Modifier Keys
        case .command, .rightCommand: return "⌘"
        case .shift, .rightShift: return "⇧"
        case .capsLock: return "⇪"
        case .option, .rightOption: return "⌥"
        case .control, .rightControl: return "⌃"

        // MARK: Functions Keys
        case .function: return "fn"
        case .f1: return "F1"
        case .f2: return "F2"
        case .f3: return "F3"
        case .f4: return "F4"
        case .f5: return "F5"
        case .f6: return "F6"
        case .f7: return "F7"
        case .f8: return "F8"
        case .f9: return "F9"
        case .f10: return "F10"
        case .f11: return "F11"
        case .f12: return "F12"
        case .f13: return "F13"
        case .f14: return "F14"
        case .f15: return "F15"
        case .f16: return "F16"
        case .f17: return "F17"
        case .f18: return "F18"
        case .f19: return "F19"
        case .f20: return "F20"

        // MARK: Mobile Keys
        case .letters: return "ABC"
        case .numbers: return "123"
        case .settings: return "⚙"
        case .specials: return "#+="
        case .nextKeyboardGlobe: return "🌐"
        }
    }
}
