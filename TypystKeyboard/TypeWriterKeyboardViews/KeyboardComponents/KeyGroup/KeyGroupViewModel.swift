//
//  KeyGroupViewModel.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 7/15/21.
//

import Foundation
import struct SwiftUI.CGFloat
import struct SwiftUI.CGSize

typealias KeyGroupCharacterSet = [Key]

enum KeyGroupPosition: String {
    case left = "left"
    case center = "center"
    case right = "right"
}

final class KeyGroupViewModel: Identifiable, ObservableObject {
    let id = UUID()

    private(set) var keyCharacters: KeyGroupCharacterSet
    @Published private(set) var keyViewModels: [KeyViewModel]
    var isFunctionGroupSet: Bool
    var groupPositionInRow: KeyGroupPosition = .center

    var keyGroupSize: CGSize {
        CGSize(width: keyViewModels.reduce(0, { $0 + $1.keySize.width }),
               height: keyViewModels.reduce(0, { max($0, $1.keySize.height) }))
    }

    fileprivate init(keyCharacters: KeyGroupCharacterSet,
                     groupPositionInRow: KeyGroupPosition? = nil,
                     keyboardActionsKeyDelegate: KeyboardKeyActionsDelegate? = nil) {
        self.keyCharacters = keyCharacters
        keyViewModels = KeyViewModelFactory.createGroupOfKeyViewModels(keyCharacters: keyCharacters,
                                                                       keyboardActionsKeyDelegate: keyboardActionsKeyDelegate)
        if let groupPositionInRow = groupPositionInRow {
            self.groupPositionInRow = groupPositionInRow
        }
        isFunctionGroupSet = KeyGroupViewModel.setIsFunctionGroupSet(keyCharacters)
    }

    fileprivate init(keyViewModels: [KeyViewModel],
                     groupPositionInRow: KeyGroupPosition? = nil) {
        self.keyViewModels = keyViewModels
        keyCharacters = keyViewModels.map({ $0.key })
        if let groupPositionInRow = groupPositionInRow {
            self.groupPositionInRow = groupPositionInRow
        }
        isFunctionGroupSet = KeyGroupViewModel.setIsFunctionGroupSet(keyCharacters)
    }

    private static func setIsFunctionGroupSet(_ keyCharacters: KeyGroupCharacterSet) -> Bool {
        keyCharacters.contains(where: {
            switch ($0) {
            case .delete: return true
            case .return: return true
            case .shift: return true
            default: return false
            }
        })
    }
}

final class KeyGroupViewModelFactory {
    static func createRowOfGroupViewModels(keyRowCharacters: KeyboardRowCharacterSet,
                                 keyboardActionsKeyDelegate: KeyboardKeyActionsDelegate? = nil) -> [KeyGroupViewModel] {
        keyRowCharacters.enumerated().map({
            let keyCharacters = $1
            let index = $0

            let multipleGroups = keyRowCharacters.count > 1
            let isLeft = index == 0 && multipleGroups
            let isRight = index == (keyRowCharacters.count - 1) && multipleGroups

            return createGroupViewModel(keyCharacters: keyCharacters,
                                        groupPositionInRow: isLeft
                                                ? .left
                                                : isRight
                                                     ? .right
                                                     : .center,
                                        keyboardActionsKeyDelegate: keyboardActionsKeyDelegate)
        })
    }

    static func createGroupViewModel(keyCharacters: KeyGroupCharacterSet,
                                     groupPositionInRow: KeyGroupPosition? = nil,
                                     keyboardActionsKeyDelegate: KeyboardKeyActionsDelegate? = nil) -> KeyGroupViewModel {
        KeyGroupViewModel(keyCharacters: keyCharacters,
                          groupPositionInRow: groupPositionInRow,
                          keyboardActionsKeyDelegate: keyboardActionsKeyDelegate)
    }
}
