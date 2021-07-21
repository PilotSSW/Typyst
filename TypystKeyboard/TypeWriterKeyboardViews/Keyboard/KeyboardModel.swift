//
// Created by Sean Wolford on 7/20/21.
//

import Combine
import Foundation

enum KeyboardMode {
    case letters
    case numbers
    case specials
}

enum LettersMode {
    case lowercased
    case shiftUppercased
    case capsLocked
}

typealias KeyboardCharacterSet = [KeyboardRowCharacterSet]

class KeyboardModel: Identifiable, ObservableObject {
    let id = UUID()

    @Published var state: KeyboardMode = .letters
    @Published var lettersState: LettersMode? = .lowercased

    var delegate: KeyboardViewModelActionsDelegate? = nil

    fileprivate var letterCharacters: KeyboardCharacterSet {
        [
            [[.q, .w, .e, .r, .t, .y, .u, .i, .o, .p]],
            [[.a, .s, .d, .f, .g, .h, .j, .k, .l]],
            [[.shift], [.z, .x, .c, .v, .b, .n, .m], [.delete]],
            [[.numbers], [.space], [.return]]
        ]
    }

    fileprivate var numberCharacters: KeyboardCharacterSet {
        [
            [[.one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero]],
            [[.minus, .backslash, /*.colon,*/ .semicolon, .leftBracket, .rightBracket]], //.$, .&, .@, .\],
            [[], [.period, .comma, /*.questionmark, .exclamationPoint,*/ .grave], [.delete]],
            [[.specials], [.space], [.return]]
        ]
    }

    fileprivate var specialCharacters: KeyboardCharacterSet {
        [
            [.leftBracket, .rightBracket, ],//[,],{,},#,%,^,*,+,=],
            [],//_,\,|,~,<,>],//,j,k,l],
            [],//,.,,,?,!,\']
            [[.letters], [.space], [.return]]
        ]
    }

    func getKeyboardCharacters() -> KeyboardCharacterSet {
        switch(state) {
        case .letters: return letterCharacters
        case .numbers: return numberCharacters
        case .specials: return specialCharacters
        }
    }

    func keyWasPressed(_ event: KeyEvent) {
        // Handle keyboardMode change
        if ([.letters, .numbers, .specials].contains(event.key)) {
            switch (state) {
            case .letters:
                state = .numbers
                lettersState = nil
            case .numbers:
                state = .specials
            case .specials:
                state = .letters
                lettersState = .lowercased
            }
        }
        else if (state == .letters) {
            if ([.capsLock, .rightShift, .shift].contains(event.key)) {
                switch (lettersState) {
                case .lowercased:
                    lettersState = .shiftUppercased
                    break
                case .shiftUppercased:
                    lettersState = .capsLocked
                    break
                case .capsLocked:
                    lettersState = .lowercased
                    break
                default: lettersState = .lowercased
                }
            }
            else if (KeySets.letters.contains(event.key) ||
                    KeySets.numbers.contains(event.key)) {
                lettersState = lettersState == .shiftUppercased
                        ? .lowercased
                        : lettersState
            }
        }

        delegate?.keyWasPressed(event)
    }
}