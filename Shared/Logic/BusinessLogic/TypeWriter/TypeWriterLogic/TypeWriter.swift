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

    private let soundsService: SoundsService

    var keyLogic: TypeWriterKeyLogic
    @Published var state: TypeWriterState

    init(modelType: TypeWriterModel.ModelType,
         marginWidth: Int = 80,
         appSettings: AppSettings,
         subscriptionStore: inout Set<AnyCancellable>,
         keyboardService: KeyboardService,
         errorHandler: (([SoundError]) -> ())?,
         completion: ((SoundsService) -> Void)?) {
        self.modelType = modelType
        
        self.appSettings = appSettings

        let so = SoundsService()
        soundsService = so
        soundsService.loadSounds(for: modelType, completion: { loadedSounds in
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
                                      soundsService: soundsService,
                                      appSettings: appSettings,
                                      keyboardService: keyboardService)
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
