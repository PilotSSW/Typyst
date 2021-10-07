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

final class TypeWriter: ObservableObject {
    private let settingsService: SettingsService
    private let soundsService: SoundsService

    static let defaultTypeWriter: TypeWriterModel.ModelType = .Royal_Model_P
    let modelType: TypeWriterModel.ModelType
    var modelFilePath: String {"Soundsets/\(String(describing: modelType))/";}

    var keyLogic: TypeWriterKeyLogic
    @Published var state: TypeWriterState

    init(modelType: TypeWriterModel.ModelType,
         marginWidth: Int = 80,
         settingsService: SettingsService,
         keyboardService: KeyboardService,
         errorHandler: (([SoundError]) -> ())?,
         completion: ((SoundsService) -> Void)?) {
        self.modelType = modelType
        self.settingsService = settingsService

        soundsService = SoundsService(settingsService: settingsService)

        let st = TypeWriterState(marginWidth: marginWidth)
        state = st
        keyLogic = TypeWriterKeyLogic(modelType: modelType,
                                      state: st,
                                      settingsService: settingsService,
                                      soundsService: soundsService,
                                      keyboardService: keyboardService)

        setup(errorHandler: errorHandler, completion: completion)
    }

    private func setup(errorHandler: (([SoundError]) -> ())?, completion: ((SoundsService) -> Void)?) {
        soundsService.loadSounds(for: modelType, completion: { [weak self] loadedSounds in
            guard let self = self else { return }
            if self.settingsService.lidOpenClose {
                loadedSounds.playSound(for: .LidUp)
            }
            completion?(loadedSounds)
        }, errorHandler: errorHandler)
    }

    internal func setVolume(_ volume: Double) {
        soundsService.volume = volume
    }

    internal func tearDown(_ completion: (() -> Void)?) {
        #if KEYBOARD_EXTENSION
        let queue = DispatchQueue.main
        #else
        let queue = DispatchQueue.global(qos: .userInteractive)
        #endif
        
        queue.async { [weak self] in
            guard let self = self else { return }
            let sounds = self.soundsService
            if self.settingsService.lidOpenClose && sounds.hasSoundFromSoundset(.LidDown) {
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
