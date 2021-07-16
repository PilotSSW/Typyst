//
//  KeyboardViewModel.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 7/6/21.
//

import Foundation
import struct SwiftUI.CGFloat
import struct SwiftUI.CGSize
import struct SwiftUI.GeometryProxy

enum KeyboardConfiguration {
    case letters
    case numbers
    case specials
}

enum LettersConfiguration {
    case lowercased
    case shiftUppercased
    case capsLocked
}

typealias KeyboardCharacterSet = [KeyboardRowCharacterSet]

final class KeyboardViewModel: Identifiable, ObservableObject {
    let id = UUID()

    private(set) var state: KeyboardConfiguration = .letters {
        didSet {
            state == .letters
                ? lettersState = .lowercased
                : nil
            setupKeyboardViewModels()
        }
    }
    private(set) var lettersState: LettersConfiguration? = .lowercased {
        didSet {
            keyViewModels.forEach({ $0.setIsUppercased(lettersState != .lowercased) })
        }
    }

    var delegate: KeyboardViewModelActionsDelegate? = nil

    private(set) var keyboardRowViewModels: [KeyboardRowViewModel] = []
    var keyViewModels: [KeyViewModel] { keyboardRowViewModels.reduce([], { $0 + $1.keyViewModels }) }

    private(set) var keyboardSize: CGSize = CGSize(width: 250, height: 100)
    var maxKeySize: CGSize = CGSize(width: 35, height: 35) {
        didSet { keyViewModels.forEach({ $0.setSuggestedKeySize(maxKeySize) }) }
    }
    var rowSpacing: CGFloat = 3.0
    var bottomSpacing: CGFloat = 1.0

    fileprivate init() {
        let characters = getKeyboardCharacters()
        keyboardRowViewModels = KeyboardRowViewModelFactory.createRowViewModels(keyboardCharacters: characters,
                                                                                keyboardActionsKeyDelegate: self)
    }

    func set(_ viewDimensions: GeometryProxy) {
        keyboardSize = viewDimensions.size
        let numCharInLongestRow = keyboardRowViewModels.reduce(0, { max($0, $1.keyViewModels.count) })
        let keyWidth = keyboardSize.width / CGFloat(numCharInLongestRow)
        let keyHeight = ((keyboardSize.height - bottomSpacing) / CGFloat(keyboardRowViewModels.count)) - rowSpacing
        maxKeySize = CGSize(width: keyWidth, height: keyHeight)
    }
}

// MARK: Private
extension KeyboardViewModel {
    fileprivate var bottomRow: KeyboardRowCharacterSet {
        [[.control], [.space], [.return]]
    }

    fileprivate var letterCharacters: KeyboardCharacterSet {
//        let leftShift: Key = lettersState == .capsLocked
//            ? .capsLock : .shift

        [
            [[.q, .w, .e, .r, .t, .y, .u, .i, .o, .p]],
            [[.a, .s, .d, .f, .g, .h, .j, .k, .l]],
            [[.shift], [.z, .x, .c, .v, .b, .n, .m], [.delete]],
            bottomRow
        ]
    }

    fileprivate var numberCharacters: KeyboardCharacterSet {
        [
            [[.one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero]],
            [[.minus, .backslash, /*.colon,*/ .semicolon, .leftBracket, .rightBracket]], //.$, .&, .@, .\],
            [[.period, .comma, /*.questionmark, .exclamationPoint,*/ .grave]],
            bottomRow
        ]
    }

    fileprivate var specialCharacters: KeyboardCharacterSet {
        [
            [],//[,],{,},#,%,^,*,+,=],
            [],//_,\,|,~,<,>],//,j,k,l],
            [],//,.,,,?,!,\']
            bottomRow
        ]
    }

    private func getKeyboardCharacters() -> KeyboardCharacterSet {
        switch(state) {
        case .letters: return letterCharacters
        case .numbers: return numberCharacters
        case .specials: return specialCharacters
        }
    }

    private func numKeysInWidestRow() -> Int {
        var numKeys = 0
        keyboardRowViewModels.forEach({ keyboardRow in
            let numInCurrentRow = keyboardRow.keyCharacters.count
            numKeys = numInCurrentRow > numKeys
                    ? numInCurrentRow
                    : numKeys
        })
        return numKeys
    }

    private func setupKeyboardViewModels() {
        keyboardRowViewModels = KeyboardRowViewModelFactory.createRowViewModels(keyboardCharacters: getKeyboardCharacters(),
                                                                                keyboardActionsKeyDelegate: self)
    }
}

protocol KeyboardViewModelActionsDelegate {
    func keyWasPressed(_ event: KeyEvent)
}

// MARK: Handle keypresses and keyboard state logic 
extension KeyboardViewModel: KeyboardKeyActionsDelegate {
    func keyWasPressed(_ event: KeyEvent) {
        if (state == .letters) {
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

final class KeyboardViewModelFactory {
    static func createKeyboardViewModel() -> KeyboardViewModel {
        KeyboardViewModel()
    }
}

