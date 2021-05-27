//
// Created by Sean Wolford on 4/16/21.
//

import Foundation
import UIKit

extension Key {
    public init?(_ key: UIKey) {
        self.init(keyCode: key.keyCode)
    }

    public init?(keyCode: UIKeyboardHIDUsage) {
        switch keyCode {

        /* Letters - Middle Row */
        case .keyboardA: self = .a
        case .keyboardS: self = .s
        case .keyboardD: self = .d
        case .keyboardF: self = .f
        case .keyboardG: self = .g
        case .keyboardH: self = .h
        case .keyboardJ: self = .j
        case .keyboardK: self = .k
        case .keyboardL: self = .l

        /* Letters - Top Row */
        case .keyboardQ: self = .q
        case .keyboardW: self = .w
        case .keyboardE: self = .e
        case .keyboardR: self = .r
        case .keyboardT: self = .t
        case .keyboardY: self = .y
        case .keyboardU: self = .u
        case .keyboardI: self = .i
        case .keyboardO: self = .o
        case .keyboardP: self = .p

        /* Letters - Bottom Row */
        case .keyboardZ: self = .z
        case .keyboardX: self = .x
        case .keyboardC: self = .c
        case .keyboardV: self = .v
        case .keyboardB: self = .b
        case .keyboardN: self = .n
        case .keyboardM: self = .m

        /* Numbers */
        case .keyboard0: self = .zero
        case .keyboard1: self = .one
        case .keyboard2: self = .two
        case .keyboard3: self = .three
        case .keyboard4: self = .four
        case .keyboard5: self = .five
        case .keyboard6: self = .six
        case .keyboard7: self = .seven
        case .keyboard8: self = .eight
        case .keyboard9: self = .nine

        /* Symbols */
        case .keyboardReturnOrEnter: self = .return
        case .keyboardEscape: self = .escape
        case .keyboardDeleteOrBackspace: self = .delete
        case .keyboardTab: self = .tab
        case .keyboardSpacebar: self = .space
        case .keyboardHyphen: self = .minus
        case .keyboardEqualSign: self = .equal
        case .keyboardOpenBracket: self = .leftBracket
        case .keyboardCloseBracket: self = .rightBracket
        case .keyboardBackslash: self = .backslash
//        case .keyboardNonUSPound: self =
        case .keyboardSemicolon: self = .semicolon
        case .keyboardQuote: self = .quote
        case .keyboardGraveAccentAndTilde: self = .grave
        case .keyboardComma: self = .comma
        case .keyboardPeriod: self = .period
        case .keyboardSlash: self = .slash
        case .keyboardCapsLock: self = .capsLock

        /* Function Keys */
//        case .keyboardF: self = .function
        case .keyboardF1: self = .f1
        case .keyboardF2: self = .f2
        case .keyboardF3: self = .f3
        case .keyboardF4: self = .f4
        case .keyboardF5: self = .f5
        case .keyboardF6: self = .f6
        case .keyboardF7: self = .f7
        case .keyboardF8: self = .f8
        case .keyboardF9: self = .f9
        case .keyboardF10: self = .f10
        case .keyboardF11: self = .f11
        case .keyboardF12: self = .f12
        case .keyboardF13: self = .f13
        case .keyboardF14: self = .f14
        case .keyboardF15: self = .f15
        case .keyboardF16: self = .f16
        case .keyboardF17: self = .f17
        case .keyboardF18: self = .f18
        case .keyboardF19: self = .f19
        case .keyboardF20: self = .f20
//        case .keyboardPrintScreen: self = .
//        case .keyboardScrollLock: self = .
//        case keyboardPause: self = .
//        case keyboardInsert: self =
        case .keyboardHome: self = .home
        case .keyboardPageUp: self = .pageUp
        case .keyboardDeleteForward: self = .forwardDelete
        case .keyboardEnd: self = .end
        case .keyboardPageDown: self = .pageDown
        case .keyboardRightArrow: self = .rightArrow
        case .keyboardLeftArrow: self = .leftArrow
        case .keyboardDownArrow: self = .downArrow
        case .keyboardUpArrow: self = .upArrow

        /* Keypad (numpad) keys */
//        case .keypadNumLock: self = .keyp
        case .keypadSlash: self = .keypadDivide
        case .keypadAsterisk: self = .keypadMultiply
        case .keypadHyphen: self = .keypadMinus
        case .keypadPlus: self = .keypadPlus
        case .keypadEnter: self = .keypadEnter
        case .keypad1: self = .keypad1
        case .keypad2: self = .keypad2
        case .keypad3: self = .keypad3
        case .keypad4: self = .keypad4
        case .keypad5: self = .keypad5
        case .keypad6: self = .keypad6
        case .keypad7: self = .keypad7
        case .keypad8: self = .keypad8
        case .keypad9: self = .keypad9
        case .keypad0: self = .keypad0
        case .keypadPeriod: self = .keypadDecimal
        case .keypadComma: self = .comma
//        case .: self = .keypadClear
//        case .keyboardNonUSBackslash: self = .
//        case .keyboardApplication: self = .
//        case keyboardPower: self = .

        /* Additional keys */
//        case keyboardExecute: self = .
        case .keyboardHelp: self = .help
//        case .keyboardMenu: self = .
//        case .keyboardSelect: self = .
//        case .keyboardStop: self = .
//        case .keyboardAgain: self = .
//        case .keyboardUndo: self = .
//        case .keyboardCut: self = .
//        case .keyboardCopy: self = .
//        case .keyboardPaste: self = .
//        case .keyboardFind: self = .
        case .keyboardMute: self = .mute
        case .keyboardVolumeUp: self = .volumeUp
        case .keyboardVolumeDown: self = .volumeDown

//        case keyboardLockingCapsLock = 130 /* Locking Caps Lock */
//        case keyboardLockingNumLock = 131 /* Locking Num Lock */
//        /* Implemented as a locking key; sent as a toggle button. Available for legacy support;
//           however, most systems should use the non-locking version of this key. */
//        case keyboardLockingScrollLock = 132 /* Locking Scroll Lock */
//        case keypadComma = 133 /* Keypad Comma */
//        case keypadEqualSignAS400 = 134 /* Keypad Equal Sign for AS/400 */
          /* See the footnotes in the USB specification for what keys these are commonly mapped to.
           * https://www.usb.org/sites/default/files/documents/hut1_12v2.pdf */
//        case keyboardInternational1 = 135 /* International1 */
//        case keyboardInternational2 = 136 /* International2 */
//        case keyboardInternational3 = 137 /* International3 */
//        case keyboardInternational4 = 138 /* International4 */
//        case keyboardInternational5 = 139 /* International5 */
//        case keyboardInternational6 = 140 /* International6 */
//        case keyboardInternational7 = 141 /* International7 */
//        case keyboardInternational8 = 142 /* International8 */
//        case keyboardInternational9 = 143 /* International9 */

//        /* LANG1: On Apple keyboard for Japanese, this is the kana switch (かな) key */
//        /* On Korean keyboards, this is the Hangul/English toggle key. */
//        case keyboardLANG1 = 144 /* LANG1 */
//        /* LANG2: On Apple keyboards for Japanese, this is the alphanumeric (英数) key */
//        /* On Korean keyboards, this is the Hanja conversion key. */
//        case keyboardLANG2 = 145 /* LANG2 */
//        /* LANG3: Defines the Katakana key for Japanese USB word-processing keyboards. */
//        case keyboardLANG3 = 146 /* LANG3 */
//        /* LANG4: Defines the Hiragana key for Japanese USB word-processing keyboards. */
//        case keyboardLANG4 = 147 /* LANG4 */
//        /* LANG5: Defines the Zenkaku/Hankaku key for Japanese USB word-processing keyboards. */
//        case keyboardLANG5 = 148 /* LANG5 */
//        /* LANG6-9: Reserved for language-specific functions, such as Front End Processors and Input Method Editors. */
//        case keyboardLANG6 = 149 /* LANG6 */
//        case keyboardLANG7 = 150 /* LANG7 */
//        case keyboardLANG8 = 151 /* LANG8 */
//        case keyboardLANG9 = 152 /* LANG9 */
        case .keyboardAlternateErase: self = .forwardDelete
//        case keyboardSysReqOrAttention = 154 /* SysReq/Attention */
//        case keyboardCancel = 155 /* Cancel */
        case .keyboardClear: self = .keypadClear
//        case keyboardPrior = 157 /* Prior */
        case .keyboardReturn: self = .return
//        case keyboardSeparator = 159 /* Separator */
//        case keyboardOut = 160 /* Out */
//        case keyboardOper = 161 /* Oper */
//        case keyboardClearOrAgain = 162 /* Clear/Again */
//        case keyboardCrSelOrProps = 163 /* CrSel/Props */
//        case keyboardExSel = 164 /* ExSel */

        /* 0xA5-0xDF: Reserved */
        case .keyboardLeftControl: self = .control
        case .keyboardLeftShift: self = .shift
        case .keyboardLeftAlt: self = .option
        case .keyboardLeftGUI: self = .command
        case .keyboardRightControl: self = .rightControl
        case .keyboardRightShift: self = .rightShift
        case .keyboardRightAlt: self = .rightOption
        case .keyboardRightGUI: self = .rightCommand
        default: return nil
        }
    }
}
