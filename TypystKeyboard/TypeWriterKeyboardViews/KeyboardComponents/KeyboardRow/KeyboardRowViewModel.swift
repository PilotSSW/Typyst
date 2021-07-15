//
// Created by Sean Wolford on 7/6/21.
//

import Foundation
import struct SwiftUI.CGFloat
import struct SwiftUI.CGSize

typealias KeyboardRowCharacterSet = [[Key]]

final class KeyboardRowViewModel: Identifiable, ObservableObject {
    let id = UUID()

    private(set) var keyCharacters: KeyboardRowCharacterSet
    private(set) var keyViewModels: [[KeyViewModel]]

    init(keyCharacters: KeyboardRowCharacterSet, keyboardActionsKeyDelegate: KeyboardKeyActionsDelegate? = nil) {
        self.keyCharacters = keyCharacters
        keyViewModels = []

        for groupOfKeyCharacters in keyCharacters {
            let vms = KeyViewModelFactory.createViewModels(keyCharacters: groupOfKeyCharacters,
                                                                 keyDelegate: keyboardActionsKeyDelegate)
            keyViewModels.append(vms)
        }
    }

    init(keyViewModels: [[KeyViewModel]]) {
        self.keyViewModels = keyViewModels
        keyCharacters = []

        for groupOfCharacters in keyViewModels {
            keyCharacters.append(groupOfCharacters.map({ $0.key }))
        }
    }

    func getAllKeyViewModels() -> [KeyViewModel] {
        keyViewModels.reduce([]) {
            var array = $0
            let arrayOfKeyVm = $1

            array.append(contentsOf: arrayOfKeyVm)
            return array
        }
    }
}

final class KeyboardRowViewModelFactory {
    static func createSpaceBarRow(keyboardActionsKeyDelegate: KeyboardKeyActionsDelegate? = nil) -> KeyboardRowViewModel {
        let spaceKeyVM = KeyViewModelFactory.createSpaceBar(keyDelegate: keyboardActionsKeyDelegate)
        return KeyboardRowViewModel(keyViewModels: [[spaceKeyVM]])
    }

    static func createViewModels(keyboardCharacters: KeyboardCharacterSet,
                                 keyboardActionsKeyDelegate: KeyboardKeyActionsDelegate? = nil) -> [KeyboardRowViewModel] {
        keyboardCharacters.reduce([], {
            var array = $0
            let rowOfCharacters = $1

            let rowViewModel = KeyboardRowViewModel(keyCharacters: rowOfCharacters,
                                                    keyboardActionsKeyDelegate: keyboardActionsKeyDelegate)
            array.append(rowViewModel)
            return array
        })
    }
}
