//
// Created by Sean Wolford on 2/14/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation

class TypeWriterKeyLogic {
    private var appSettings: AppSettings
    private var keyboardService: KeyboardService

    let state: TypeWriterState
    private let modelType: TypeWriterModel.ModelType
    private var keyListenerTag: String { "TypeWriterLogic-\(modelType)" }

    init(modelType: TypeWriterModel.ModelType,
         state: TypeWriterState,
         sounds: Sounds,
         appSettings: AppSettings,
         keyboardService: KeyboardService) {
        self.modelType = modelType
        self.state = state

        self.appSettings = appSettings
        self.keyboardService = keyboardService

        keyboardService.registerKeyPressCallback(withTag: keyListenerTag) { [weak self] keyEvent in
            guard let self = self else { return }
            DispatchQueue.main.async(execute: {
                self.assignKeyPresses(for: keyEvent, sounds: sounds)
            })
        }
    }

    deinit {
        keyboardService.removeListenerCallback(withTag: keyListenerTag)
    }

    func assignKeyPresses(for keyPressed: KeyEvent, sounds: Sounds) {
        if (keyPressed.isRepeat) { return }

        handlePaperReturn(for: keyPressed, sounds: sounds)

        // These should be ordered by likelihood they were the key pressed. The fewer the searches, the faster the
        // sound plays ;)

        switch(keyPressed.key, keyPressed.direction) {
        case (Key.shift, _): handleShift(for: keyPressed, sounds: sounds); break
        case (Key.space, _): handleSpace(for: keyPressed, sounds: sounds); break
        case (Key.delete, _): fallthrough
        case (Key.forwardDelete, _): handleBackspace(for: keyPressed, sounds: sounds); break
        case (Key.return, _): fallthrough
        case (Key.keypadEnter, _): handleEnter(for: keyPressed, sounds: sounds); break
        case (Key.escape, _): handleEscape(for: keyPressed, sounds: sounds); break
        case (Key.capsLock, _): handleCapsLock(sounds: sounds); break
        case (Key.tab, _): handleTab(for: keyPressed, sounds: sounds); break
        case let keyPressed where KeySets.special.contains(keyPressed.0): sounds.playSound(for: .Bell); break
        case (Key.function, _): sounds.playSound(for: .RibbonSelector); break
        case (Key.keypadClear, _): sounds.playSound(for: .MarginRelease); break
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
            sounds.playSound(fromOneOfAny: [.SingleLineReturn, .DoubleLineReturn, .TripleLineReturn])

            if appSettings.paperFeedEnabled {
                DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 1) { [weak sounds] in
                    guard let sounds = sounds else { return }
                    sounds.playSound(for: .PaperLoad, completion: { [weak sounds] in
                        guard let sounds = sounds else { return }
                        sounds.playSound(for: .PaperFeed)
                    })
                }
            }
        }
        else {
            // Only count the key press once - not on both up and down
            if keyPressed.direction == .keyDown {
                state.newLine()
                sounds.playSound(fromOneOfAny: [.SingleLineReturn, .DoubleLineReturn, .TripleLineReturn])
            }
        }   
    }

    func handleEscape(for keyPressed: KeyEvent, sounds: Sounds) {
        keyPressed.direction == .keyUp ?
            sounds.playSound(for: .PaperRelease) :
            sounds.playSound(for: .PaperReturn)
    }

    func handleKeyPress(for keyPressed: KeyEvent, sounds: Sounds) {
        if keyPressed.direction == .keyDown {
            state.incrementCursor()
            sounds.playSound(for: .KeyDown)
        } else {
            sounds.playSound(for: .KeyUp)
        }
    }

    func handlePaperReturn(for keyPressed: KeyEvent, sounds: Sounds) {
        if state.cursorIndex >= state.marginWidth {
            state.resetCursorIndex()
            state.newLine()

            let paperReturnCB = { [weak self, weak sounds] in
                guard let self = self, let sounds = sounds else { return }
                if self.appSettings.paperReturnEnabled {
                    sounds.playSound(fromOneOfAny: [
                        .SingleLineReturn, .DoubleLineReturn, .TripleLineReturn
                    ])
                }
            }

            appSettings.bell
                ? sounds.playSound(for: .Bell, completion: paperReturnCB)
                : paperReturnCB()
        }
    }

    func handleShift(for keyPressed: KeyEvent, sounds: Sounds) {
        keyPressed.direction == .keyDown
            ? sounds.playSound(for: .ShiftDown)
            : sounds.playSound(for: .ShiftUp)
    }

    func handleSpace(for keyPressed: KeyEvent, sounds: Sounds) {
        if keyPressed.direction == .keyDown {
            state.incrementCursor()
            sounds.playSound(for: .SpaceDown)
        }
        else {
            sounds.playSound(for: .SpaceUp)
        }
    }

    func handleTab(for keyPressed: KeyEvent, sounds: Sounds) {
        if keyPressed.direction == .keyDown{
            state.incrementCursor(numberOfPositions: 5)
            sounds.playSound(for: .TabDown)
        }
        else {
            sounds.playSound(for: .TabUp)
        }
    }
}
