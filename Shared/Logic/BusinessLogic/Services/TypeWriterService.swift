//
// Created by Sean Wolford on 2/15/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

final class TypeWriterService: Loggable, ObservableObject {
    private var settingsService: SettingsService
    private var keyboardService: KeyboardService

    @Published private(set) var loadedTypewriter: TypeWriter?

    init(withKeyboardService keyboardService: KeyboardService = RootDependencyContainer.get().keyboardService,
         settingsService: SettingsService = RootDependencyContainer.get().settingsService,
         logger: Logging) {
        self.settingsService = settingsService
        self.keyboardService = keyboardService

        loadTypeWriter()
        logEvent(.debug, "TypeWriter-Service setup", loggerInstance: logger)
    }

    deinit {
        unloadTypewriter()
    }

    func setCurrentTypeWriter(modelType: TypeWriterModel.ModelType) {
        settingsService.selectedTypewriter = modelType.rawValue

        let loadCB = { [weak self] in
            guard let self = self else { return }

            self.loadedTypewriter = TypeWriter(
                modelType: modelType,
                settingsService: self.settingsService,
                keyboardService: self.keyboardService,
                errorHandler: { [weak self] (soundErrors) in
                    #if !KEYBOARD_EXTENSION
                    guard let self = self else { return }
                    let sounds = soundErrors.map({ $0.localizedDescription })
                    self.showAlert(ErrorAlerts.soundsFailedToLoad(sounds))
                    #endif
                },
                completion: { [weak self] loadedSounds in
                    #if !KEYBOARD_EXTENSION
                    guard let self = self else { return }
                    let soundSets = loadedSounds.soundSets.keys.map({ $0.rawValue }).sorted(by: <)
                    self.showAlert(UserInfoAlerts.soundsLoaded(soundSets))
                    #endif
                })
        }

        loadedTypewriter == nil
            ? loadCB()
            : unloadTypewriter(loadCB)
    }

    func loadTypeWriter(forceWhenAlreadyLoaded: Bool = false) {
        if loadedTypewriter != nil && !forceWhenAlreadyLoaded { return }

        if let modelString = settingsService.selectedTypewriter,
           let modelType = TypeWriterModel.ModelType.init(rawValue: modelString) {
            setCurrentTypeWriter(modelType: modelType)
            return
        }

        setCurrentTypeWriter(modelType: TypeWriter.defaultTypeWriter)
    }

    func unloadTypewriter(_ completion: (() -> Void)? = nil) {
        loadedTypewriter?.tearDown() { [weak self] in
            guard let self = self else { return }
            self.loadedTypewriter = nil
            completion?()
        }
    }

    func setVolumeTo(_ volume: Double) {
        settingsService.volumeSetting = volume
        loadedTypewriter?.setVolume(volume)
    }
}

#if !KEYBOARD_EXTENSION
extension TypeWriterService: Alertable {}
#endif
