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

fileprivate let letterCharacters: [[Key]] = [
    [.q, .w, .e, .r, .t, .y, .u, .i, .o, .p],
    [.a, .s, .d, .f, .g, .h, .j, .k, .l],
    [.z, .x, .c, .v, .b, .n, .m]
]

fileprivate let numberCharacters: [[Key]] = [
    [.one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero],
    [.minus, .backslash, /*.colon,*/ .semicolon, .leftBracket, .rightBracket], //.$, .&, .@, .\],
    [.period, .comma, /*.questionmark, .exclamationPoint,*/ .grave]
]

fileprivate let specialCharacters: [[Key]] = [
    [],//[,],{,},#,%,^,*,+,=],
    [],//_,\,|,~,<,>],//,j,k,l],
    []//,.,,,?,!,\']
]

class KeyboardViewModel: ObservableObject {
    private var container = KeyboardExtensionDependencyContainer.get()
    @Published private(set) var state: KeyboardConfiguration = .letters {
        didSet {
            keyboardRowViewModels = KeyboardRowViewModelFactory.createViewModels(keyboardCharacters: getKeyboardCharacters(),
                                                                                 keyboardActionsKeyDelegate: self)
        }
    }

    @Published private(set) var keyboardRowViewModels: [KeyboardRowViewModel] = []

    init() {
        let characters = getKeyboardCharacters()
        keyboardRowViewModels = KeyboardRowViewModelFactory.createViewModels(keyboardCharacters: characters,
                                                                             keyboardActionsKeyDelegate: self)
    }

    func set(_ viewDimensions: GeometryProxy) {
        let size = viewDimensions.size
        let width = size.width

        let numCharInLongestRow = keyboardRowViewModels.map({ $0.keyCharacters.count}).sorted().last ?? 0
        let keyWidth = width / CGFloat(numCharInLongestRow)
        let keySize = CGSize(width: keyWidth, height: keyWidth)

        for rowViewModel in keyboardRowViewModels {
            for keyViewModel in rowViewModel.keyViewModels {
                if keyViewModel.key == .space {
                    keyViewModel.setKeySize(CGSize(width: keyWidth * 5, height: keyWidth))
                } else {
                    keyViewModel.setKeySize(keySize)
                }
            }
        }
    }
}

// MARK: Private
extension KeyboardViewModel {
    private func getKeyboardCharacters() -> [[Key]] {
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
}

extension KeyboardViewModel: KeyboardKeyActionsDelegate {
    func keyWasPressed(_ event: KeyEvent) {
        RootDependencyContainer.get().keyboardService.handleEvent(event)
    }
}

