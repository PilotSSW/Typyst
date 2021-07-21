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

final class KeyboardViewModel: Identifiable, ObservableObject {
    let id = UUID()
    private var subscriptions = Set<AnyCancellable>()

    private(set) var model: KeyboardModel = KeyboardModel()
    var delegate: KeyboardViewModelActionsDelegate? = nil {
        didSet { model.delegate = delegate }
    }

    @Published private(set) var keyboardRowViewModels: [KeyboardRowViewModel] = []
    var keyViewModels: [KeyViewModel] { keyboardRowViewModels.reduce([], { $0 + $1.keyViewModels }) }

    private(set) var keyboardSize: CGSize = CGSize(width: 250, height: 100)
    var maxKeySize: CGSize = CGSize(width: 35, height: 35) {
        didSet { keyViewModels.forEach({ $0.setSuggestedKeySize(maxKeySize) }) }
    }
    var uiProperties: KeyboardUIProperties

    fileprivate init(modelType: TypeWriterModel.ModelType) {
        uiProperties = KeyboardProperties.getPropertiesFor(modelType)

        let characters = model.getKeyboardCharacters()
        keyboardRowViewModels = KeyboardRowViewModelFactory.createRowViewModels(keyboardCharacters: characters,
                                                                                keyboardActionsKeyDelegate: self)

        model.$state
            .sink { [weak self] state in
                guard let self = self else { return }

                state == .letters
                    ? self.model.lettersState = .lowercased
                    : nil
                self.setupKeyboardViewModels()
            }
            .store(in: &subscriptions)

        model.$lettersState
            .sink { [weak self] lettersState in
                guard let self = self else { return }
                self.keyViewModels.forEach({ $0.setIsUppercased(lettersState != .lowercased) })
            }
            .store(in: &subscriptions)
    }

    func set(_ viewDimensions: GeometryProxy) {
        keyboardSize = viewDimensions.size
        let numCharInLongestRow = keyboardRowViewModels.reduce(0, { max($0, $1.keyViewModels.count) })
        let keyWidth = keyboardSize.width / CGFloat(numCharInLongestRow)
        let keyHeight = ((keyboardSize.height - uiProperties.bottomSpacing) / CGFloat(keyboardRowViewModels.count)) - uiProperties.rowSpacing
        maxKeySize = CGSize(width: keyWidth, height: keyHeight)
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

    private func setupKeyboardViewModels() {
        keyboardRowViewModels = []
        keyboardRowViewModels = KeyboardRowViewModelFactory.createRowViewModels(keyboardCharacters: model.getKeyboardCharacters(),
                                                                                keyboardActionsKeyDelegate: self)
    }
}

protocol KeyboardViewModelActionsDelegate {
    func keyWasPressed(_ event: KeyEvent)
}

// MARK: Handle keypresses and keyboard state logic
extension KeyboardViewModel: KeyboardKeyActionsDelegate {
    func keyWasPressed(_ event: KeyEvent) {
        model.keyWasPressed(event)
    }
}

final class KeyboardViewModelFactory {
    static func createKeyboardViewModel(forTypeWriterModel modelType: TypeWriterModel.ModelType) -> KeyboardViewModel {
        KeyboardViewModel(modelType: modelType)
    }
}
