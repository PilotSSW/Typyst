//
//  Typewriter.swift
//  Typyst
//
//  Created by Sean Wolford on 1/14/19.
//  Copyright © 2019 wickedPropeller. All rights reserved.
//

import Foundation
import HotKey
import SwiftySound

class Typewriter {
    static let defaultTypeWriter: Typewriter.Model = .Royal_Model_P
    let sounds: Sounds

    enum Model: String {
        case Olympia_SM3 = "Olympia_SM3"
        case Royal_Model_P = "Royal_Model_P"
        case Smith_Corona_Silent = "Smith_Corona_Silent"
    }

    var modelFilePath: String { "Soundsets/\(String(describing: model))/ "}

    // Typewriter variables / constants
    var model: Model?
    var marginWidth = 80
    
    var numberOfNewLines = 0
    var lineIndex = 0

    var shiftIsPressed = false
    var capsOn         = false

    init(model: Model, marginWidth: Int = 80, errorHandler: (([SoundError]) -> ())?) {
        self.model = model
        self.marginWidth = marginWidth

        sounds = Sounds()
        sounds.loadSounds(for: model, completion: { [weak self] in
            guard let self = self else { return }
            self.sounds.playSound(for: .LidUp)
        }, errorHandler: errorHandler)

        KeyListener.instance.listenForAllKeyPresses(completion: { [weak self] (keyEvent) in
            self?.assignKeyPresses(for: keyEvent)
            //KeyAnalytics.shared.logEvent(keyEvent)
        })
    }

    deinit {
        sounds.playSound(for: .LidDown)
    }

    func assignKeyPresses(for keyPressed: KeyEvent) {
        if lineIndex >= marginWidth {
            lineIndex = 0
            if AppSettings.paperReturnEnabled {
                sounds.playSound(for: .Bell, completion: { [weak self] in
                    guard let self = self else { return }
                    self.sounds.playSound(from: [
                        .SingleLineReturn, .DoubleLineReturn, .TripleLineReturn
                    ])
                })
            }
        }

        // These should be ordered by likelihood they were the key pressed. The fewer the searches, the faster the
        // sound plays ;)

        if keyPressed.0 == Key.shift {
            shiftIsPressed == false ?
                    sounds.playSound(for: .ShiftDown) :
                    sounds.playSound(for: .ShiftUp)

            // Flag key directions aren't tracked - we need to do that.
            shiftIsPressed = !shiftIsPressed
        } else if keyPressed.0 == Key.space {
            keyPressed.1 == .keyUp ?
                    sounds.playSound(for: .SpaceUp) :
                    sounds.playSound(for: .SpaceDown)
        }
        else if keyPressed.0 == Key.return || keyPressed.0 == Key.keypadEnter {
            lineIndex = 0
            sounds.playSound(from: [.SingleLineReturn, .DoubleLineReturn, .TripleLineReturn])

            if numberOfNewLines == 25 {
                numberOfNewLines = 0
                if AppSettings.paperFeedEnabled {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                        guard let self = self else { return }
                        self.sounds.playSound(for: .PaperLoad, completion: { [weak self] in
                            guard let self = self else { return }
                            self.sounds.playSound(for: .PaperFeed)
                        })
                    }
                }
            }
            else {
                // Only count the key press once - not on both up and down
                if keyPressed.1 == .keyDown {
                    numberOfNewLines += 1
                }
            }
        }
        else if keyPressed.0 == Key.delete || keyPressed.0 == Key.forwardDelete {
            if keyPressed.1 == .keyUp {
                sounds.playSound(for: .BackspaceUp)
            }
            else {
                sounds.playSound(for: .BackspaceDown)
                if lineIndex > 0 {
                    lineIndex += -1
                }
            }
        }
        else if keyPressed.0 == Key.escape {
            keyPressed.1 == .keyUp ?
                sounds.playSound(for: .PaperRelease) :
                sounds.playSound(for: .PaperReturn)
        }
        else if keyPressed.0 == Key.capsLock {
            capsOn ?
                sounds.playSound(for: .ShiftLock) :
                sounds.playSound(for: .ShiftRelease)
            capsOn = !capsOn
        }
        else if keyPressed.0 == Key.tab {
            if keyPressed.1 == .keyUp {
                sounds.playSound(for: .TabUp)
            }
            else {
                lineIndex += 5
                sounds.playSound(for: .TabDown)
            }
        }
        else if KeySets.bell.contains(keyPressed.0) {
            sounds.playSound(for: .Bell)
        }
        else if keyPressed.0 == Key.keypadClear {
            sounds.playSound(for: .RibbonSelector)
        }
        else if keyPressed.1 == .systemDefined {
            sounds.playSound(for: .MarginRelease)
        }
        else {
            if keyPressed.1 == .keyUp {
                sounds.playSound(for: .KeyUp)
            } else {
                lineIndex += 1
                sounds.playSound(for: .KeyDown)
            }
        }
    }
}
