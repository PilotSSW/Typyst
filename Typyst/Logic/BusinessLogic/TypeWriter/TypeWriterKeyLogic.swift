//
// Created by Sean Wolford on 2/14/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation
import HotKey

class TypeWriterKeyLogic {
    let state: TypeWriterState

    init(state: TypeWriterState, sounds: Sounds) {
        self.state = state

        KeyListener.instance.listenForAllKeyPresses(completion: { [weak self] (keyEvent) in
            guard let self = self else { return }
            self.assignKeyPresses(for: keyEvent, sounds: sounds)
            KeyAnalytics.shared.logEvent(keyEvent)
        })
    }

    func assignKeyPresses(for keyPressed: KeyEvent, sounds: Sounds) {
        handlePaperReturn(for: keyPressed, sounds: sounds)

        // These should be ordered by likelihood they were the key pressed. The fewer the searches, the faster the
        // sound plays ;)

        switch(keyPressed.key, keyPressed.direction) {
        case (Key.shift, _):
            handleShift(sounds: sounds); break
        case (Key.space, _):
            handleSpace(for: keyPressed, sounds: sounds); break
        case (Key.return, _): fallthrough
        case (Key.keypadEnter, _):
            handleEnter(for: keyPressed, sounds: sounds); break
        case (Key.delete, _): fallthrough
        case (Key.forwardDelete, _):
            handleBackspace(for: keyPressed, sounds: sounds); break
        case (Key.escape, _):
            handleEscape(for: keyPressed, sounds: sounds); break
        case (Key.capsLock, _):
            handleCapsLock(sounds: sounds); break
        case (Key.tab, _):
            handleTab(for: keyPressed, sounds: sounds); break
        case let keyPressed where KeySets.bell.contains(keyPressed.0):
            sounds.playSound(for: .Bell); break
        case (Key.keypadClear, _):
            sounds.playSound(for: .RibbonSelector); break
        case let keyPressed where keyPressed.1 == .systemDefined:
            sounds.playSound(for: .MarginRelease); break
        default:
            handleKeyPress(for: keyPressed, sounds: sounds); break
        }
    }

    func handleBackspace(for keyPressed: KeyEvent, sounds: Sounds) {
        if keyPressed.direction == .keyUp {
            sounds.playSound(for: .BackspaceUp)
        }
        else {
            sounds.playSound(for: .BackspaceDown)
            state.newLine()
        }
    }

    func handleCapsLock(sounds: Sounds) {
        state.capsOn ?
            sounds.playSound(for: .ShiftLock) :
            sounds.playSound(for: .ShiftRelease)
        state.setCaps()
    }

    func handleEnter(for keyPressed: KeyEvent, sounds: Sounds) {
        if state.isLineIndexIsOnLastLine {
            state.resetLineIndex()
            if AppSettings.paperFeedEnabled {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak sounds] in
                    guard let sounds = sounds else { return }
                    sounds.playSound(for: .PaperLoad, completion: { [weak sounds] in
                        guard let sounds = sounds else { return }
                        sounds.playSound(for: .PaperFeed)
                    })
                }
            }
            else {
                sounds.playSound(from: [.SingleLineReturn, .DoubleLineReturn, .TripleLineReturn])
            }
        }
        else {
            // Only count the key press once - not on both up and down
            if keyPressed.direction == .keyDown {
                state.newLine()
                sounds.playSound(from: [.SingleLineReturn, .DoubleLineReturn, .TripleLineReturn])
            }
        }   
    }

    func handleEscape(for keyPressed: KeyEvent, sounds: Sounds) {
        keyPressed.direction == .keyUp ?
            sounds.playSound(for: .PaperRelease) :
            sounds.playSound(for: .PaperReturn)
    }

    func handleKeyPress(for keyPressed: KeyEvent, sounds: Sounds) {
        if keyPressed.direction == .keyUp {
            sounds.playSound(for: .KeyUp)
        } else {
            state.incrementCursor()
            sounds.playSound(for: .KeyDown)
        }
    }

    func handlePaperReturn(for keyPressed: KeyEvent, sounds: Sounds) {
        if state.cursorIndex >= state.marginWidth {
            state.resetCursorIndex()
            state.newLine()

            if AppSettings.paperReturnEnabled {
                sounds.playSound(for: .Bell, completion: { [weak sounds] in
                    guard let sounds = sounds else { return }
                    sounds.playSound(from: [
                        .SingleLineReturn, .DoubleLineReturn, .TripleLineReturn
                    ])
                })
            }
        }
    }

    func handleShift(sounds: Sounds) {
        state.shiftIsPressed == false ?
            sounds.playSound(for: .ShiftDown) :
            sounds.playSound(for: .ShiftUp)

        // Flag key directions aren't tracked - we need to do that.
        state.setShift()
    }

    func handleSpace(for keyPressed: KeyEvent, sounds: Sounds) {
        state.incrementCursor()
        keyPressed.direction == .keyUp ?
            sounds.playSound(for: .SpaceUp) :
            sounds.playSound(for: .SpaceDown)
    }

    func handleTab(for keyPressed: KeyEvent, sounds: Sounds) {
        if keyPressed.direction == .keyUp {
            sounds.playSound(for: .TabUp)
        }
        else {
            state.incrementCursor(numberOfPositions: 5)
            sounds.playSound(for: .TabDown)
        }
    }
}
