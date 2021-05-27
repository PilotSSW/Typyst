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

    case period
    case quote
    case rightBracket
    case semicolon
    case slash
    case backslash
    case comma
    case equal
    case grave // Backtick
    case leftBracket
    case minus

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

    // MARK: - Initializers

    public init?(string: String) {
        switch string.lowercased() {
            case "a": self = .a
            case "s": self = .s
            case "d": self = .d
            case "f": self = .f
            case "h": self = .h
            case "g": self = .g
            case "z": self = .z
            case "x": self = .x
            case "c": self = .c
            case "v": self = .v
            case "b": self = .b
            case "q": self = .q
            case "w": self = .w
            case "e": self = .e
            case "r": self = .r
            case "y": self = .y
            case "t": self = .t
            case "one", "1": self = .one
            case "two", "2": self = .two
            case "three", "3": self = .three
            case "four", "4": self = .four
            case "six", "6": self = .six
            case "five", "5": self = .five
            case "equal", "=": self = .equal
            case "nine", "9": self = .nine
            case "seven", "7": self = .seven
            case "minus", "-": self = .minus
            case "eight", "8": self = .eight
            case "zero", "0": self = .zero
            case "rightBracket", "]": self = .rightBracket
            case "o": self = .o
            case "u": self = .u
            case "leftBracket", "[": self = .leftBracket
            case "i": self = .i
            case "p": self = .p
            case "l": self = .l
            case "j": self = .j
            case "quote", "\"": self = .quote
            case "k": self = .k
            case "semicolon", ";": self = .semicolon
            case "backslash", "\\": self = .backslash
            case "comma", ",": self = .comma
            case "slash", "/": self = .slash
            case "n": self = .n
            case "m": self = .m
            case "period", ".": self = .period
            case "grave", "`", "ˋ", "｀": self = .grave
            case "keypaddecimal": self = .keypadDecimal
            case "keypadmultiply": self = .keypadMultiply
            case "keypadplus": self = .keypadPlus
            case "keypadclear", "⌧": self = .keypadClear
            case "keypaddivide": self = .keypadDivide
            case "keypadenter": self = .keypadEnter
            case "keypadminus": self = .keypadMinus
            case "keypadequals": self = .keypadEquals
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
            case "return", "\r", "↩︎", "⏎", "⮐": self = .return
            case "tab", "\t", "⇥": self = .tab
            case "space", " ", "␣": self = .space
            case "delete", "⌫": self = .delete
            case "escape", "⎋": self = .escape
            case "command", "⌘", "": self = .command
            case "shift", "⇧": self = .shift
            case "capslock", "⇪": self = .capsLock
            case "option", "⌥": self = .option
            case "control", "⌃": self = .control
            case "rightcommand": self = .rightCommand
            case "rightshift": self = .rightShift
            case "rightoption": self = .rightOption
            case "rightcontrol": self = .rightControl
            case "function", "fn": self = .function
            case "f17", "F17": self = .f17
            case "volumeup", "🔊": self = .volumeUp
            case "volumedown", "🔉": self = .volumeDown
            case "mute", "🔇": self = .mute
            case "f18", "F18": self = .f18
            case "f19", "F19": self = .f19
            case "f20", "F20": self = .f20
            case "f5", "F5": self = .f5
            case "f6", "F6": self = .f6
            case "f7", "F7": self = .f7
            case "f3", "F3": self = .f3
            case "f8", "F8": self = .f8
            case "f9", "F9": self = .f9
            case "f11", "F11": self = .f11
            case "f13", "F13": self = .f13
            case "f16", "F16": self = .f16
            case "f14", "F14": self = .f14
            case "f10", "F10": self = .f10
            case "f12", "F12": self = .f12
            case "f15", "F15": self = .f15
            case "help", "?⃝": self = .help
            case "home", "↖": self = .home
            case "pageup", "⇞": self = .pageUp
            case "forwarddelete", "⌦": self = .forwardDelete
            case "f4", "F4": self = .f4
            case "end", "↘": self = .end
            case "f2", "F2": self = .f2
            case "pagedown", "⇟": self = .pageDown
            case "f1", "F1": self = .f1
            case "leftarrow", "←": self = .leftArrow
            case "rightarrow", "→": self = .rightArrow
            case "downarrow", "↓": self = .downArrow
            case "uparrow", "↑": self = .upArrow
            default: return nil
        }
    }
}

extension Key: CustomStringConvertible {
    public var description: String {
        switch  self {
            case .a: return "A"
            case .s: return "S"
            case .d: return "D"
            case .f: return "F"
            case .h: return "H"
            case .g: return "G"
            case .z: return "Z"
            case .x: return "X"
            case .c: return "C"
            case .v: return "V"
            case .b: return "B"
            case .q: return "Q"
            case .w: return "W"
            case .e: return "E"
            case .r: return "R"
            case .y: return "Y"
            case .t: return "T"
            case .one, .keypad1: return "1"
            case .two, .keypad2: return "2"
            case .three, .keypad3: return "3"
            case .four, .keypad4: return "4"
            case .six, .keypad6: return "6"
            case .five, .keypad5: return "5"
            case .equal: return "="
            case .nine, .keypad9: return "9"
            case .seven, .keypad7: return "7"
            case .minus: return "-"
            case .eight, .keypad8: return "8"
            case .zero, .keypad0: return "0"
            case .rightBracket: return "]"
            case .o: return "O"
            case .u: return "U"
            case .leftBracket: return "["
            case .i: return "I"
            case .p: return "P"
            case .l: return "L"
            case .j: return "J"
            case .quote: return "\""
            case .k: return "K"
            case .semicolon: return ";"
            case .backslash: return "\\"
            case .comma: return ","
            case .slash: return "/"
            case .n: return "N"
            case .m: return "M"
            case .period: return "."
            case .grave: return "`"
            case .keypadDecimal: return "."
            case .keypadMultiply: return "𝗑"
            case .keypadPlus: return "+"
            case .keypadClear: return "⌧"
            case .keypadDivide: return "/"
            case .keypadEnter: return "↩︎"
            case .keypadMinus: return "-"
            case .keypadEquals: return "="
            case .`return`: return "↩︎"
            case .tab: return "⇥"
            case .space: return "␣"
            case .delete: return "⌫"
            case .escape: return "⎋"
            case .command, .rightCommand: return "⌘"
            case .shift, .rightShift: return "⇧"
            case .capsLock: return "⇪"
            case .option, .rightOption: return "⌥"
            case .control, .rightControl: return "⌃"
            case .function: return "fn"
            case .f17: return "F17"
            case .volumeUp: return "🔊"
            case .volumeDown: return "🔉"
            case .mute: return "🔇"
            case .f18: return "F18"
            case .f19: return "F19"
            case .f20: return "F20"
            case .f5: return "F5"
            case .f6: return "F6"
            case .f7: return "F7"
            case .f3: return "F3"
            case .f8: return "F8"
            case .f9: return "F9"
            case .f11: return "F11"
            case .f13: return "F13"
            case .f16: return "F16"
            case .f14: return "F14"
            case .f10: return "F10"
            case .f12: return "F12"
            case .f15: return "F15"
            case .help: return "?⃝"
            case .home: return "↖"
            case .pageUp: return "⇞"
            case .forwardDelete: return "⌦"
            case .f4: return "F4"
            case .end: return "↘"
            case .f2: return "F2"
            case .pageDown: return "⇟"
            case .f1: return "F1"
            case .leftArrow: return "←"
            case .rightArrow: return "→"
            case .downArrow: return "↓"
            case .upArrow: return "↑"
        }
    }
}
