//
//  KeyboardViewModel.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 7/6/21.
//

import Combine
import Foundation
import struct SwiftUI.CGFloat
import struct SwiftUI.CGSize
import struct SwiftUI.GeometryProxy

final class KeyboardViewModel: Identifiable, ObservableObject, Loggable {
    let id = UUID()
    private var subscriptions = Set<AnyCancellable>()

    private(set) var model: KeyboardModel

    @Published private(set) var keyboardRowViewModels: [KeyboardRowViewModel] = []
    var keyViewModels: [KeyViewModel] { keyboardRowViewModels.reduce([], { $0 + $1.keyViewModels }) }

    var cornerRadius: CGFloat { min(keyboardSize.height, keyboardSize.width) / 18 }
    private(set) var keyboardSize: CGSize = CGSize(width: 250, height: 100)
    var maxKeySize: CGSize = CGSize(width: 35, height: 35) {
        didSet { keyViewModels.forEach({ $0.setSuggestedKeySize(maxKeySize) }) }
    }
    var uiProperties: KeyboardUIProperties

    fileprivate init(modelType: TypeWriterModel.ModelType,
                     requiresNextKeyboardButton: Bool = true) {
        uiProperties = KeyboardProperties.getPropertiesFor(modelType)

        model = KeyboardModel(requiresNextKeyboardButton: requiresNextKeyboardButton)
        model.$mode
            .sink { [weak self] mode in
                guard let self = self else { return }
                self.setupKeyboardViewModels(forKeyboardMode: mode)
            }
            .store(in: &subscriptions)

        model.$lettersMode
            .sink { [weak self] lettersState in
                guard let self = self else { return }
                self.keyViewModels.forEach({ $0.setIsUppercased(lettersState != .lowercased) })
            }
            .store(in: &subscriptions)
    }

    func set(_ viewDimensions: GeometryProxy) {
        let _ = logEvent(.trace, "Set keyboard view model / view size")
        if keyboardSize == viewDimensions.size { return }

        keyboardSize = viewDimensions.size
        let numCharInLongestRow = keyboardRowViewModels.reduce(0, { max($0, $1.keyViewModels.count) })
        let keyWidth = keyboardSize.width / CGFloat(numCharInLongestRow)
        let keyHeight = ((keyboardSize.height - uiProperties.bottomSpacing) / CGFloat(keyboardRowViewModels.count)) - uiProperties.rowSpacing
        maxKeySize = CGSize(width: keyWidth, height: keyHeight)
        let _ = logEvent(.trace, "Keyboard view model / view size updated")
    }
}

// MARK: Private
extension KeyboardViewModel {
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

    private func setupKeyboardViewModels(forKeyboardMode mode: KeyboardMode) {
        keyboardRowViewModels.removeAll()
        let keyboardCharacters = model.getKeyboardCharacters(forMode: mode)
        keyboardRowViewModels = KeyboardRowViewModelFactory.createRowViewModels(keyboardCharacters: keyboardCharacters,
                                                                                keyboardActionsKeyDelegate: self)
        keyViewModels.forEach({ $0.setSuggestedKeySize(maxKeySize) })
    }
}

// MARK: Handle keypresses and keyboard state logic
extension KeyboardViewModel: KeyboardKeyActionsDelegate {
    func keyWasPressed(_ event: KeyEvent) {
        model.keyWasPressed(event)
    }
}

final class KeyboardViewModelFactory {
    static func createKeyboardViewModel(forTypeWriterModel modelType: TypeWriterModel.ModelType,
                                        requiresNextKeyboardButton: Bool = true) -> KeyboardViewModel {
        KeyboardViewModel(modelType: modelType,
                          requiresNextKeyboardButton: requiresNextKeyboardButton)
    }
}
