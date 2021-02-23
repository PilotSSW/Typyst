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

class TypeWriter {
    enum Model: String {
        case Olympia_SM3 = "Olympia_SM3"
        case Royal_Model_P = "Royal_Model_P"
        case Smith_Corona_Silent = "Smith_Corona_Silent"
    }

    static let defaultTypeWriter: TypeWriter.Model = .Royal_Model_P
    let model: Model
    var modelFilePath: String { "Soundsets/\(String(describing: model))/ "}

    var keyLogic: TypeWriterKeyLogic
    let sounds: Sounds
    var state: TypeWriterState

    init(model: Model, marginWidth: Int = 80, errorHandler: (([SoundError]) -> ())?) {
        self.model = model

        sounds = Sounds()
        sounds.loadSounds(for: model, completion: { loadedSounds in
            loadedSounds.playSound(for: .LidUp)
        }, errorHandler: errorHandler)

        state = TypeWriterState(marginWidth: marginWidth)
        keyLogic = TypeWriterKeyLogic(state: state, sounds: sounds)
    }

    deinit {
        sounds.playSound(for: .LidDown)
        sounds.unloadSounds()
    }
}
