//
//  KeyboardLogic.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 6/27/21.
//

import Foundation
import protocol UIKit.UITextDocumentProxy

class TextDocumentProxyService {

    init() {

    }

    func handleKeyPress(_ keyEvent: KeyEvent,
                        keyboardMode: KeyboardMode,
                        textDocumentProxy: UITextDocumentProxy) {
        let key = keyEvent.key
        if [.capsLock, .command, .control, .rightCommand, .rightControl, .rightShift, .shift, .letters, .numbers, .specials].contains(key) {
            return
        }
        else if [.delete].contains(key) {
            textDocumentProxy.deleteBackward()
        }
        else if [.space].contains(key) {
            textDocumentProxy.insertText(" ")
        }
        else if [.keypadEnter, .return].contains(key) {
            textDocumentProxy.insertText("\n")
        }
        else if keyboardMode == .letters {
            let isUppercased = keyEvent.modifiers.contains(.shift) || keyEvent.modifiers.contains(.capsLock)
            let text = isUppercased
                ? key.stringValue.uppercased()
                : key.stringValue.lowercased()
            textDocumentProxy.insertText(text)
        }
        else if keyboardMode == .numbers {
            let text = key.stringValue
            textDocumentProxy.insertText(text)
        }
        else if keyboardMode == .specials {
            let text = key.stringValue
            textDocumentProxy.insertText(text)
        }
    }
}
