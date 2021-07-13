//
// Created by Sean Wolford on 7/6/21.
//

import Foundation
import struct SwiftUI.CGFloat
import struct SwiftUI.CGSize

final class KeyboardRowViewModel: ObservableObject {
    private(set) var keyCharacters: [Key]
    private(set) var keyViewModels: [KeyViewModel]

    init(keyCharacters: [Key], keyboardActionsKeyDelegate: KeyboardKeyActionsDelegate? = nil) {
        self.keyCharacters = keyCharacters

        keyViewModels = KeyViewModelFactory.createViewModels(keyCharacters: keyCharacters,
                                                             keyDelegate: keyboardActionsKeyDelegate)
    }

    init(keyViewModels: [KeyViewModel]) {
        self.keyViewModels = keyViewModels
        keyCharacters = keyViewModels.map({ $0.key })
    }
}

final class KeyboardRowViewModelFactory {
    static func createSpaceBarRow(keyboardActionsKeyDelegate: KeyboardKeyActionsDelegate? = nil) -> KeyboardRowViewModel {
        let spaceKeyVM = KeyViewModelFactory.createSpaceBar(keyDelegate: keyboardActionsKeyDelegate)
        return KeyboardRowViewModel(keyViewModels: [spaceKeyVM])
    }

    static func createViewModels(keyboardCharacters: [[Key]],
                                 keyboardActionsKeyDelegate: KeyboardKeyActionsDelegate? = nil) -> [KeyboardRowViewModel] {
        var letterRows: [KeyboardRowViewModel] = keyboardCharacters.map({
            let rowCharacters = $0
            return KeyboardRowViewModel(keyCharacters: rowCharacters,
                                        keyboardActionsKeyDelegate: keyboardActionsKeyDelegate)
        })

        letterRows.append(createSpaceBarRow(keyboardActionsKeyDelegate: keyboardActionsKeyDelegate))
        return letterRows
    }
}
