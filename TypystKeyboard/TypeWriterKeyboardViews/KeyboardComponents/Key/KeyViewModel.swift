//
//  KeyViewModel.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 7/6/21.
//

import Foundation
import struct SwiftUI.CGFloat
import struct SwiftUI.CGSize

protocol KeyboardKeyActionsDelegate {
    func keyWasPressed(_ event: KeyEvent)
}

final class KeyViewModel: ObservableObject {
    let key: Key
    private(set) var delegate: KeyboardKeyActionsDelegate? = nil

    // Stored Properties
    private(set) var displayText: String
    @Published var isHovering: Bool = false
    @Published private(set) var keySize: CGSize = CGSize(width: 50, height: 50)

    // Computed Properties
    var cornerRadius: CGFloat { ((keySize.height / 2.0) + (keySize.width / 2.0)) / 2.0 }
    var innerPadding: CGFloat { isHovering ? 0.0 : 2.0 }

    init(_ key: Key, displayText: String = "", customKeySize: CGSize? = nil,
         delegate: KeyboardKeyActionsDelegate? = nil) {
        self.key = key
        self.delegate = delegate
        self.displayText = displayText.count == 0 ? key.description : displayText
        if let customKeySize = customKeySize {
            keySize = customKeySize
        }
    }

    func onTap(_ completion: (() -> Void)? = nil) {
        delegate?.keyWasPressed(createKeyEvent())
    }

    func setKeySize(_ keySize: CGSize) {
        self.keySize = keySize
    }
}

extension KeyViewModel {
    func createKeyEvent() -> KeyEvent {
        KeyEvent(key, .keyDown, [])
    }
}

final class KeyViewModelFactory {
    static func createViewModels(keyCharacters: [Key], keyDelegate: KeyboardKeyActionsDelegate? = nil) -> [KeyViewModel] {
        keyCharacters.map({ KeyViewModel($0, delegate: keyDelegate) })
    }

    static func createSpaceBar(keyDelegate: KeyboardKeyActionsDelegate? = nil) -> KeyViewModel {
        KeyViewModel(.space, displayText: "Space", delegate: keyDelegate)
    }
}
