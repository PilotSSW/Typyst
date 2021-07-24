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
                        lettersMode: LettersMode? = nil,
                        textDocumentProxy: UITextDocumentProxy) {
        let key = keyEvent.key

        if keyEvent.direction == .keyUp {
            return
        }
        else if [.capsLock, .command, .control, .rightCommand, .rightControl, .rightShift, .shift, .letters, .numbers, .specials].contains(key) {
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
            var isUppercased = false
            if let lettersMode = lettersMode,
               lettersMode == .shiftUppercased || lettersMode == .capsLocked {
                isUppercased = true
            }
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
