//
//  KeyboardLogic.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 6/27/21.
//

import Foundation
import UIKit

enum PressType {
    case touchBegan
    case touchEnded
    case touchCancelled
}

class KeyboardExtensionService {
    func handleUIPressesEvent(_ event: UIPressesEvent?, _ pressType: PressType, keyboardService: KeyboardService) {
        if let event = event {
            let keyEvents = mapUIPressesToKeyEvents(event.allPresses, pressType)

            keyEvents.forEach({ keyEvent in
                keyboardService.handleEvent(keyEvent)
            })
        }
    }

    private func mapUIPressesToKeyEvents(_ uiPresses: Set<UIPress>, _ pressType: PressType) -> [KeyEvent] {
        return uiPresses.compactMap({ press in
            uiPressToKeyEvent(press, pressType)
        })
    }

    private func uiPressToKeyEvent(_ keyPress: UIPress, _ pressType: PressType) -> KeyEvent? {
        guard let keyPress = keyPress.key,
              let key = Key(keyCode: keyPress.keyCode) else { return nil }
        let modifierFlags = ModifierFlags(keyPress.modifierFlags)
        return KeyEvent(key, .keyDown, modifierFlags)
    }
}