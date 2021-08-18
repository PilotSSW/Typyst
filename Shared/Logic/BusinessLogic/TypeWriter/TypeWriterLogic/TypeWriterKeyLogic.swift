//
// Created by Sean Wolford on 2/14/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation

final class TypeWriterKeyLogic {
    private var appSettings: AppSettings
    private var keyboardService: KeyboardService
    private var soundsService: SoundsService

    let state: TypeWriterState
    private let modelType: TypeWriterModel.ModelType
    private var keyListenerTag: String { "TypeWriterLogic-\(modelType)" }

    init(modelType: TypeWriterModel.ModelType,
         state: TypeWriterState,
         soundsService: SoundsService,
         appSettings: AppSettings,
         keyboardService: KeyboardService) {
        self.modelType = modelType
        self.state = state

        self.appSettings = appSettings
        self.keyboardService = keyboardService
        self.soundsService = soundsService

        keyboardService.registerKeyPressCallback(withTag: keyListenerTag) { [weak self] keyEvent in
            guard let self = self else { return }
            self.assignKeyPresses(for: keyEvent)
        }
    }

    deinit {
        keyboardService.removeListenerCallback(withTag: keyListenerTag)
    }

    func assignKeyPresses(for keyPressed: KeyEvent) {
        if (keyPressed.isRepeat) { return }

        handlePaperReturn(for: keyPressed)

        // These should be ordered by likelihood they were the key pressed. The fewer the searches, the faster the
        // sound plays ;)

        switch(keyPressed.key, keyPressed.direction) {
        case (Key.shift, _): handleShift(for: keyPressed); break
        case (Key.space, _): handleSpace(for: keyPressed); break
        case (Key.delete, _): fallthrough
        case (Key.forwardDelete, _): handleBackspace(for: keyPressed); break
        case (Key.return, _): fallthrough
        case (Key.keypadEnter, _): handleEnter(for: keyPressed); break
        case (Key.escape, _): handleEscape(for: keyPressed); break
        case (Key.capsLock, _): handleCapsLock(); break
        case (Key.tab, _): handleTab(for: keyPressed); break
        case let keyPressed where KeySets.special.contains(keyPressed.0): soundsService.playSound(for: .Bell); break
        case (Key.function, _): soundsService.playSound(for: .RibbonSelector); break
        case (Key.keypadClear, _): soundsService.playSound(for: .MarginRelease); break
        default:
            handleKeyPress(for: keyPressed); break
        }
    }

    func handleBackspace(for keyPressed: KeyEvent) {
        if keyPressed.direction == .keyUp {
            soundsService.playSound(for: .BackspaceUp)
        }
        else {
            soundsService.playSound(for: .BackspaceDown)
            state.newLine()
        }
    }

    func handleCapsLock() {
        state.capsOn ?
            soundsService.playSound(for: .ShiftLock) :
            soundsService.playSound(for: .ShiftRelease)
        state.setCaps()
    }

    func handleEnter(for keyPressed: KeyEvent) {
        if state.isLineIndexIsOnLastLine {
            state.resetLineIndex()
            soundsService.playSound(fromOneOfAny: [.SingleLineReturn, .DoubleLineReturn, .TripleLineReturn]) { [weak self] in
                guard let self = self else { return }
                self.soundsService.playSound(for: .PaperLoad) { [weak self] in
                    guard let self = self else { return }
                    self.soundsService.playSound(for: .PaperFeed)
                }
            }
        }
        else {
            // Only count the key press once - not on both up and down
            if keyPressed.direction == .keyDown {
                state.newLine()
                soundsService.playSound(fromOneOfAny: [.SingleLineReturn, .DoubleLineReturn, .TripleLineReturn])
            }
        }   
    }

    func handleEscape(for keyPressed: KeyEvent) {
        keyPressed.direction == .keyUp ?
            soundsService.playSound(for: .PaperRelease) :
            soundsService.playSound(for: .PaperReturn)
    }

    func handleKeyPress(for keyPressed: KeyEvent) {
        if keyPressed.direction == .keyDown {
            state.incrementCursor()
            soundsService.playSound(for: .KeyDown)
        } else {
            soundsService.playSound(for: .KeyUp)
        }
    }

    func handlePaperReturn(for keyPressed: KeyEvent) {
        if state.cursorIndex >= state.marginWidth {
            state.resetCursorIndex()
            state.newLine()

            let paperReturnCB = { [weak self] in
                guard let self = self else { return }
                if self.appSettings.paperReturnEnabled {
                    self.soundsService.playSound(fromOneOfAny: [
                        .SingleLineReturn, .DoubleLineReturn, .TripleLineReturn
                    ])
                }
            }

            appSettings.bell
                ? soundsService.playSound(for: .Bell, completion: paperReturnCB)
                : paperReturnCB()
        }
    }

    func handleShift(for keyPressed: KeyEvent) {
        keyPressed.direction == .keyDown
            ? soundsService.playSound(for: .ShiftDown)
            : soundsService.playSound(for: .ShiftUp)
    }

    func handleSpace(for keyPressed: KeyEvent) {
        if keyPressed.direction == .keyDown {
            state.incrementCursor()
            soundsService.playSound(for: .SpaceDown)
        }
        else {
            soundsService.playSound(for: .SpaceUp)
        }
    }

    func handleTab(for keyPressed: KeyEvent) {
        if keyPressed.direction == .keyDown{
            state.incrementCursor(numberOfPositions: 5)
            soundsService.playSound(for: .TabDown)
        }
        else {
            soundsService.playSound(for: .TabUp)
        }
    }
}
