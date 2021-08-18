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

protocol KeyboardModelActionsDelegate: AnyObject {
    func keyWasPressed(_ event: KeyEvent)
}

final class KeyboardModel: Identifiable, ObservableObject {
    let id = UUID()
    
    private(set) var requiresNextKeyboardButton: Bool = true
    @Published private(set) var mode: KeyboardMode = .letters
    @Published private(set) var lettersMode: LettersMode? = .lowercased

    weak var keyActionsDelegate: KeyboardModelActionsDelegate? = nil
    private var requestToShowSettings: (() -> Void)? = nil
    
    init(requiresNextKeyboardButton: Bool,
         requestToShowSettings: (() -> Void)? = nil) {
        self.requiresNextKeyboardButton = requiresNextKeyboardButton
        self.requestToShowSettings = requestToShowSettings
    }

    func keyWasPressed(_ event: KeyEvent) {
        let key = event.key

        // Handle keyboardMode change
        if (event.direction == .keyDown) {
            if (key == .settings) {
                requestToShowSettings?()
            }
            else if (mode == .letters) {
                if keyShouldSetKeyboardLettersMode(key),
                   let newLettersMode = getNextLettersMode() { setLettersMode(newLettersMode) }
            }
        }
        else {
            if let mode = mapKeyToKeyboardMode(key) { setMode(mode) }
        }

        keyActionsDelegate?.keyWasPressed(event)

        if (event.direction == .keyUp && mode == .letters) {
            // If previous key was shift-uppercased
            if (![.shift, .rightShift, .capsLock].contains(key) && lettersMode == .shiftUppercased) {
                setLettersMode(.lowercased)
            }
        }
    }

    func setRequestToShowSettings(_ requestToShowSettings: @escaping () -> Void) {
        self.requestToShowSettings = requestToShowSettings
    }
}

// MARK: KeyboardMode functions
extension KeyboardModel {
    func mapKeyToKeyboardMode(_ key: Key) -> KeyboardMode? {
        if .letters == key { return .letters }
        else if .numbers == key { return .numbers }
        else if .specials == key { return .specials }

        return nil
    }

    func setMode(_ newMode: KeyboardMode) {
        mode = newMode
        lettersMode = mode == .letters
            ? .lowercased
            : nil
    }
}

// MARK: LettersMode functions
extension KeyboardModel {
    func keyShouldSetKeyboardLettersMode(_ key: Key) -> Bool {
        [.capsLock, .rightShift, .shift].contains(key)
    }

    func getNextLettersMode() -> LettersMode? {
        if mode != .letters { return nil }

        if lettersMode == .lowercased { return .shiftUppercased }
        else if lettersMode == .shiftUppercased { return .capsLocked }
        else if lettersMode == .capsLocked { return .lowercased }

        return nil
    }

    func setLettersMode(_ newMode: LettersMode = .lowercased) {
        if mode != .letters {
            lettersMode = nil
            return
        }

        lettersMode = newMode
    }
}

// MARK: KeyboardCharacterSets
extension KeyboardModel {
    func getKeyboardCharacters(forMode mode: KeyboardMode? = nil) -> KeyboardCharacterSet {
        var getMode = self.mode
        if let mode = mode {
            getMode = mode
        }
        switch(getMode) {
            case .letters: return letterCharacters
            case .numbers: return numberCharacters
            case .specials: return specialCharacters
        }
    }

    fileprivate var letterCharacters: KeyboardCharacterSet {
        let upperCaseButton: Key = lettersMode == .capsLocked
            ? .capsLock : .shift
        let bottomGroup: KeyGroupCharacterSet = requiresNextKeyboardButton
            ? [.numbers, .nextKeyboardGlobe]
            : [.numbers]
        return [
            [[.q, .w, .e, .r, .t, .y, .u, .i, .o, .p]],
            [[.a, .s, .d, .f, .g, .h, .j, .k, .l]],
            [[upperCaseButton], [.z, .x, .c, .v, .b, .n, .m], [.delete]],
            [bottomGroup, [.space], [.return, .settings]]
        ]
    }

    fileprivate var numberCharacters: KeyboardCharacterSet {
        let bottomGroup: KeyGroupCharacterSet = requiresNextKeyboardButton
            ? [.letters, .nextKeyboardGlobe]
            : [.letters]
        return [
            [[.one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero]],
            [[.minus, .backslash, .colon, .semicolon, .leftParenthesis, .rightParenthesis, .dollarSign, .ampersand, .atSymbol, .doubleQuotes]],
            [[.specials], [.period, .comma, .questionMark, .exclamationPoint, .grave], [.delete]],
            [bottomGroup, [.space], [.return, .settings]]
        ]
    }

    fileprivate var specialCharacters: KeyboardCharacterSet {
        let bottomGroup: KeyGroupCharacterSet = requiresNextKeyboardButton
            ? [.letters, .nextKeyboardGlobe]
            : [.letters]
        return [
            [[.leftBracket, .rightBracket, .leftBrace, .rightBrace, .poundSign, .percentage, .caretUp ,.star , .plus ,.equal]],
            [[.underscore, .backslash, .binaryVerticalBar, .tilda, .caretLeft, .caretRight, .euroCurrencySymbol, .poundCurrencySymbol, .yenCurrencySymbol, .bulletMark]],
            [[.numbers], [.period, .comma, .questionMark, .exclamationPoint, .grave], [.delete]],
            [bottomGroup, [.space], [.return, .settings]]
        ]
    }
}
