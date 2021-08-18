//
// Created by Sean Wolford on 7/6/21.
//

import Foundation
import struct SwiftUI.CGFloat
import struct SwiftUI.CGSize

typealias KeyboardRowCharacterSet = [KeyGroupCharacterSet]

final class KeyboardRowViewModel: Identifiable, ObservableObject {
    let id = UUID()

    private(set) var keyCharacters: KeyboardRowCharacterSet
    @Published private(set) var keyGroupViewModels: [KeyGroupViewModel]
    var keyViewModels: [KeyViewModel] { keyGroupViewModels.reduce([], { $0 + $1.keyViewModels }) }

    var keyboardRowSize: CGSize {
        CGSize(width: keyGroupViewModels.reduce(0, { $0 + $1.keyGroupSize.width }),
               height: keyGroupViewModels.reduce(0, { max($0, $1.keyGroupSize.height) }))
    }

    fileprivate init(keyCharacters: KeyboardRowCharacterSet,
         keyboardActionsKeyDelegate: KeyboardKeyActionsDelegate? = nil) {
        self.keyCharacters = keyCharacters
        keyGroupViewModels = KeyGroupViewModelFactory.createRowOfGroupViewModels(keyRowCharacters: keyCharacters,
                                                                       keyboardActionsKeyDelegate: keyboardActionsKeyDelegate)
    }

    fileprivate init(keyGroupViewModels: [KeyGroupViewModel]) {
        self.keyGroupViewModels = keyGroupViewModels
        keyCharacters = keyGroupViewModels.map({ $0.keyCharacters })
    }
}

final class KeyboardRowViewModelFactory {
    static func createRowViewModels(keyboardCharacters: KeyboardCharacterSet,
                                    keyboardActionsKeyDelegate: KeyboardKeyActionsDelegate? = nil) -> [KeyboardRowViewModel] {
        keyboardCharacters.map({
            createRowViewModel(keyRowCharacters: $0,
                               keyboardActionsKeyDelegate: keyboardActionsKeyDelegate)
        })
    }

    static func createRowViewModel(keyRowCharacters: KeyboardRowCharacterSet,
                                   keyboardActionsKeyDelegate: KeyboardKeyActionsDelegate? = nil) -> KeyboardRowViewModel {
        KeyboardRowViewModel(keyCharacters: keyRowCharacters,
                             keyboardActionsKeyDelegate: keyboardActionsKeyDelegate)
    }
}
