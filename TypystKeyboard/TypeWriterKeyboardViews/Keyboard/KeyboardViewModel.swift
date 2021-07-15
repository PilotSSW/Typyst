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

typealias KeyboardCharacterSet = [[[Key]]]

fileprivate let letterCharacters: KeyboardCharacterSet = [
    [[.q, .w, .e, .r, .t, .y, .u, .i, .o, .p]],
    [[.a, .s, .d, .f, .g, .h, .j, .k, .l]],
    [[.shift], [.z, .x, .c, .v, .b, .n, .m], [.delete]],
    [[.space]]
]

fileprivate let numberCharacters: KeyboardCharacterSet = [
    [[.one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero]],
    [[.minus, .backslash, /*.colon,*/ .semicolon, .leftBracket, .rightBracket]], //.$, .&, .@, .\],
    [[.period, .comma, /*.questionmark, .exclamationPoint,*/ .grave]],
    [[.space]]
]

fileprivate let specialCharacters: KeyboardCharacterSet = [
    [],//[,],{,},#,%,^,*,+,=],
    [],//_,\,|,~,<,>],//,j,k,l],
    [],//,.,,,?,!,\']
    [[.space]]
]

final class KeyboardViewModel: Identifiable, ObservableObject {
    let id = UUID()
    let maxKeySize: CGSize = CGSize(width: 35, height: 35)

    @Published private(set) var state: KeyboardConfiguration = .letters {
        didSet {
            setupKeyboardViewModels()
        }
    }

    @Published private(set) var keyboardRowViewModels: [KeyboardRowViewModel] = []
    var keyViewModels: [KeyViewModel] {
        keyboardRowViewModels
            .map({ $0.getAllKeyViewModels() })
            .reduce([], {
                var array = $0
                let keyVmArray = $1
                array.append(contentsOf: keyVmArray)
                return array
            })
    }

    init() {
        let characters = getKeyboardCharacters()
        keyboardRowViewModels = KeyboardRowViewModelFactory.createViewModels(keyboardCharacters: characters,
                                                                             keyboardActionsKeyDelegate: self)
    }

    func set(_ viewDimensions: GeometryProxy) {
        let size = viewDimensions.size
        let width = size.width

        let numCharInLongestRow = keyboardRowViewModels.map({ $0.keyCharacters.reduce(0) { $0 + $1.count }}).sorted().last ?? 0
        let keyWidth = width / CGFloat(numCharInLongestRow)
        let keySize = CGSize(width: keyWidth, height: keyWidth)

        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }

            for rowViewModel in self.keyboardRowViewModels {
                for groupOfKeyViewModel in rowViewModel.keyViewModels {
                    for keyViewModel in groupOfKeyViewModel {
                        if keyViewModel.key == .space {
                            keyViewModel.setKeySize(CGSize(width: keyWidth * 5, height: keyWidth))
                        } else {
                            keyViewModel.setKeySize(keySize)
                        }
                    }
                }
            }
        }
    }
}

// MARK: Private
extension KeyboardViewModel {
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
        keyboardRowViewModels = KeyboardRowViewModelFactory.createViewModels(keyboardCharacters: getKeyboardCharacters(),
                                                                             keyboardActionsKeyDelegate: self)
    }
}

extension KeyboardViewModel: KeyboardKeyActionsDelegate {
    func keyWasPressed(_ event: KeyEvent) {
        RootDependencyContainer.get().keyboardService.handleEvent(event)
    }
}

