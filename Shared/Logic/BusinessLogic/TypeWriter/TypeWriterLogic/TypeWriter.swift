//
//  Typewriter.swift
//  Typyst
//
//  Created by Sean Wolford on 1/14/19.
//  Copyright © 2019 wickedPropeller. All rights reserved.
//

import Combine
import Foundation
import SwiftUI
import SwiftySound

class TypeWriter: ObservableObject {
    static let defaultTypeWriter: TypeWriterModel.ModelType = .Royal_Model_P
    let modelType: TypeWriterModel.ModelType
    var modelFilePath: String { "Soundsets/\(String(describing: modelType))/ "}

    private let sounds: Sounds

    var keyLogic: TypeWriterKeyLogic
    @Published var state: TypeWriterState

    init(modelType: TypeWriterModel.ModelType,
         marginWidth: Int = 80,
         keyHandler: KeyHandler,
         errorHandler: (([SoundError]) -> ())?,
         completion: ((Sounds) -> Void)?) {
        self.modelType = modelType

        let so = Sounds()
        sounds = so
        sounds.loadSounds(for: modelType, completion: { loadedSounds in
            loadedSounds.volume = appDependencyContainer.appSettings.volumeSetting
            if appDependencyContainer.appSettings.lidOpenClose {
                loadedSounds.playSound(for: .LidUp)
            }
            completion?(loadedSounds)
        }, errorHandler: errorHandler)

        appDependencyContainer.appSettings.$volumeSetting
            .sink { so.volume = $0 }
            .store(in: &appDependencyContainer.subscriptions)

        let st = TypeWriterState(marginWidth: marginWidth)
        state = st
        keyLogic = TypeWriterKeyLogic(modelType: modelType, state: st, sounds: sounds, keyHandler: keyHandler)
    }

    internal func setVolume(_ volume: Double) {
        sounds.volume = volume
    }

    internal func tearDown(_ completion: (() -> Void)?) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let sounds = self.sounds
            if appDependencyContainer.appSettings.lidOpenClose && sounds.hasSoundFromSoundset(.LidDown) {
                sounds.playSound(for: .LidDown) {
                    sounds.unloadSounds()
                    if let completion = completion { DispatchQueue.main.async(execute: completion) }
                }
            }
            else {
                sounds.unloadSounds()
                if let completion = completion { DispatchQueue.main.async(execute: completion) }
            }
        }
    }
}
