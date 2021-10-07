//
//  KeyViewModel.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 7/6/21.
//

import Combine
import Foundation
import struct SwiftUI.CGFloat
import struct SwiftUI.CGSize

protocol KeyboardKeyActionsDelegate: AnyObject {
    func keyWasPressed(_ event: KeyEvent)
}

final class KeyViewModel: Identifiable, ObservableObject {
    // Stored Properties
    private var store = Set<AnyCancellable>()
    let typeWriterService: TypeWriterService = RootDependencyContainer.get().typeWriterService
    let id = UUID()
    @Published private(set) var key: Key
    fileprivate(set) weak var delegate: KeyboardKeyActionsDelegate? = nil
    @Published private(set) var selectedTypeWriter: TypeWriterModel.ModelType

    @Published fileprivate(set) var isUppercased: Bool? = false
    @Published var isHovering: Bool = false
    @Published private(set) var isPressed: Bool = false
    @Published private var suggestedMaxKeySize: CGSize = CGSize(width: 35, height: 35)
    @Published private var spacebarKeyWidth: Int = 6
    // Internal properties to handle press action crazy repeating 
    private var keyDownLock = false
    private var keyUpLock = false

    // Computed Properties
    private var _displayText: String = ""
    var displayText: String {
        if (_displayText.count > 0) {
            switch(isUppercased) {
                case true: return _displayText.uppercased()
                case false: return _displayText.lowercased()
                default: return _displayText
            }
        }

        switch(isUppercased) {
            case true: return key.stringValue.uppercased()
            case false: return key.stringValue.lowercased()
            default: return key.stringValue
        }
    }
    var keySize: CGSize {
        let keySize = min(suggestedMaxKeySize.width, suggestedMaxKeySize.height)
        if (key == .space) {
            return CGSize(width: keySize * CGFloat(spacebarKeyWidth),
                          height: keySize)
        }

        return CGSize(width: keySize,
                      height: keySize)
    }
    var cornerRadius: CGFloat { ((keySize.height / 2.0) + (keySize.width / 2.0)) / 2.0 }
    var innerPadding: CGFloat { isHovering ? 0.0 : 2.0 }

    fileprivate init(_ key: Key,
                     displayText: String = "",
                     customKeySize: CGSize? = nil,
                     delegate: KeyboardKeyActionsDelegate? = nil) {
        self.key = key
        self.delegate = delegate
        selectedTypeWriter = typeWriterService.loadedTypewriter?.modelType ?? .Unknown
        _displayText = displayText
        isUppercased = displayText.count > 0
            ? nil
            : isUppercased
        if let customKeySize = customKeySize {
            suggestedMaxKeySize = customKeySize
        }

        typeWriterService.$loadedTypewriter
            .sink { [weak self] typeWriterModel in
                guard let self = self else { return }
                self.selectedTypeWriter = typeWriterModel?.modelType ?? .Unknown
            }
            .store(in: &store)
    }

    func onTap(direction: KeyEvent.KeyDirection,
               sendKeypressToDelegate: Bool = true,
               _ completion: ((KeyEvent) -> Void)? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.onTapOnMain(direction: direction,
                             sendKeypressToDelegate: sendKeypressToDelegate,
                             completion)
        }
    }

    private func onTapOnMain(direction: KeyEvent.KeyDirection,
               sendKeypressToDelegate: Bool = true,
               _ completion: ((KeyEvent) -> Void)? = nil) {
        if (direction == .keyDown) {
            if (keyDownLock == true) { return }
            keyDownLock = true
            keyUpLock = false
            isPressed = true
        }
        else if (direction == .keyUp) {
            if (!keyDownLock || keyUpLock) { return }
            keyUpLock = true
            keyDownLock = false
            isPressed = false
        }

        let keyEvent = createKeyEvent(direction: direction)
        if sendKeypressToDelegate { delegate?.keyWasPressed(keyEvent) }
        completion?(keyEvent)
    }
    
    func setNewKey(_ key: Key) {
        self.key = key
    }

    func setSpacebarKeyWidth(_ width: Int) {
        spacebarKeyWidth = width
    }

    func setSuggestedKeySize(_ keySize: CGSize) {
        suggestedMaxKeySize = keySize
    }

    func setIsUppercased(_ bool: Bool, setForCustomText: Bool = false) {
        if isUppercased != nil || setForCustomText {
            isUppercased = bool
        }
    }

    func hash(into hasher: inout Hasher) {}
}

extension KeyViewModel {
    func createKeyEvent(direction: KeyEvent.KeyDirection) -> KeyEvent {
        let modifiers: ModifierFlags = (KeySets.letters.contains(key) || KeySets.numbers.contains(key))
            && isUppercased == true
                ? [.shift]
                : []
        return KeyEvent(key, direction, modifiers)
    }
}

extension KeyViewModel: Hashable {
    static func ==(lhs: KeyViewModel, rhs: KeyViewModel) -> Bool {
        lhs.id != rhs.id
    }
}

final class KeyViewModelFactory {
    static func createGroupOfKeyViewModels(keyCharacters: KeyGroupCharacterSet,
                                    keyboardActionsKeyDelegate: KeyboardKeyActionsDelegate? = nil) -> [KeyViewModel] {
        keyCharacters.map({ key in
            KeyViewModelFactory.createViewModel(keyCharacter: key,
                                                keyDelegate: keyboardActionsKeyDelegate)
        })
    }

    static func createViewModel(keyCharacter: Key,
                                keyDelegate: KeyboardKeyActionsDelegate? = nil,
                                useFactoryCustomizedKeyViewModels: Bool = true) -> KeyViewModel {
        if (useFactoryCustomizedKeyViewModels) {
            switch (keyCharacter) {
            case .space: return createSpaceBar(keyDelegate: keyDelegate)
            default: return KeyViewModel(keyCharacter, delegate: keyDelegate)
            }
        }

        return KeyViewModel(keyCharacter, delegate: keyDelegate)
    }

    static func createSpaceBar(keyDelegate: KeyboardKeyActionsDelegate? = nil) -> KeyViewModel {
        KeyViewModel(.space, displayText: " ", delegate: keyDelegate)
    }
}
