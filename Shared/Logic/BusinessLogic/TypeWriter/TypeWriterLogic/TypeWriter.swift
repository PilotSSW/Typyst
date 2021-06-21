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
    private var appSettings: AppSettings

    static let defaultTypeWriter: TypeWriterModel.ModelType = .Royal_Model_P
    let modelType: TypeWriterModel.ModelType
    var modelFilePath: String { "Soundsets/\(String(describing: modelType))/ "}

    private let sounds: Sounds

    var keyLogic: TypeWriterKeyLogic
    @Published var state: TypeWriterState

    init(modelType: TypeWriterModel.ModelType,
         marginWidth: Int = 80,
         appSettings: AppSettings,
         subscriptionStore: inout Set<AnyCancellable>,
         keyboardService: KeyboardService,
         errorHandler: (([SoundError]) -> ())?,
         completion: ((Sounds) -> Void)?) {
        self.modelType = modelType
        
        self.appSettings = appSettings

        let so = Sounds()
        sounds = so
        sounds.loadSounds(for: modelType, completion: { loadedSounds in
            loadedSounds.volume = appSettings.volumeSetting
            if appSettings.lidOpenClose {
                loadedSounds.playSound(for: .LidUp)
            }
            completion?(loadedSounds)
        }, errorHandler: errorHandler)

        appSettings.$volumeSetting
            .sink { so.volume = $0 }
            .store(in: &subscriptionStore)

        let st = TypeWriterState(marginWidth: marginWidth)
        state = st
        keyLogic = TypeWriterKeyLogic(modelType: modelType,
                                      state: st,
                                      sounds: sounds,
                                      appSettings: appSettings,
                                      keyboardService: keyboardService)
    }

    internal func setVolume(_ volume: Double) {
        sounds.volume = volume
    }

    internal func tearDown(_ completion: (() -> Void)?) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let sounds = self.sounds
            if self.appSettings.lidOpenClose && sounds.hasSoundFromSoundset(.LidDown) {
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
