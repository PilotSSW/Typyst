//
//  Typewriter.swift
//  Typyst
//
//  Created by Sean Wolford on 1/14/19.
//  Copyright © 2019 wickedPropeller. All rights reserved.
//

import Combine
import Foundation
import HotKey
import SwiftUI
import SwiftySound

class TypeWriter: ObservableObject {
    static let defaultTypeWriter: TypeWriterModel.ModelType = .Royal_Model_P
    let model: TypeWriterModel.ModelType
    var modelFilePath: String { "Soundsets/\(String(describing: model))/ "}

    private let sounds: Sounds

    var keyLogic: TypeWriterKeyLogic
    @Published var state: TypeWriterState

    init(model: TypeWriterModel.ModelType, marginWidth: Int = 80, errorHandler: (([SoundError]) -> ())?, completion: ((Sounds) -> Void)?) {
        self.model = model

        let so = Sounds()
        sounds = so
        sounds.loadSounds(for: model, completion: { loadedSounds in
            loadedSounds.volume = AppSettings.shared.volumeSetting
            loadedSounds.playSound(for: .LidUp)
            completion?(loadedSounds)
        }, errorHandler: errorHandler)

        AppSettings.shared.$volumeSetting
            .sink { so.volume = $0 }
            .store(in: &App.instance.subscriptions)

        let st = TypeWriterState(marginWidth: marginWidth)
        state = st
        keyLogic = TypeWriterKeyLogic(state: st, sounds: sounds)
    }

    internal func setVolume(_ volume: Double) {
        sounds.volume = volume
    }

    deinit {
        sounds.playSound(for: .LidDown)

        DispatchQueue.main.async(execute: { [weak self] in
            guard let self = self else { return }
            self.sounds.unloadSounds()
        })
    }
}