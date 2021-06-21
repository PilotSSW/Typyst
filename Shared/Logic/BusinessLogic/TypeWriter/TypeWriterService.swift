//
// Created by Sean Wolford on 2/15/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

class TypeWriterService: Alertable, Loggable, ObservableObject {
    private var appSettings: AppSettings
    private var keyboardService: KeyboardService
    private var subscriptionStore: Set<AnyCancellable>

    @Published private(set) var loadedTypewriter: TypeWriter?

    init(withKeyboardService keyboardService: KeyboardService = appDependencyContainer.keyboardService,
         appSettings: AppSettings = appDependencyContainer.appSettings,
         subscriptionStore: Set<AnyCancellable>) {
        self.subscriptionStore = subscriptionStore
        self.appSettings = appSettings
        self.keyboardService = keyboardService

        loadTypeWriter()
        //logEvent(.trace, "TypeWriterHandler setup")
    }

    deinit {
        unloadTypewriter()
    }

    func setCurrentTypeWriter(modelType: TypeWriterModel.ModelType) {
        appSettings.selectedTypewriter = modelType.rawValue

        let loadCB = { [weak self] in
            guard let self = self else { return }

            self.loadedTypewriter = TypeWriter(
                modelType: modelType,
                appSettings: self.appSettings,
                subscriptionStore: &self.subscriptionStore,
                keyboardService: self.keyboardService,
                errorHandler: { [weak self] (soundErrors) in
                    guard let self = self else { return }
                    let sounds = soundErrors.map({ $0.localizedDescription })
                    self.showAlert(ErrorAlerts.soundsFailedToLoad(sounds))
                },
                completion: { [weak self] loadedSounds in
                    guard let self = self else { return }
                    let soundSets = loadedSounds.soundSets.keys.map({ $0.rawValue }).sorted(by: <)
                    self.showAlert(UserInfoAlerts.soundsLoaded(soundSets))
                })
        }

        loadedTypewriter == nil
            ? loadCB()
            : unloadTypewriter(loadCB)
    }

    func loadTypeWriter(forceWhenAlreadyLoaded: Bool = false) {
        if loadedTypewriter != nil && !forceWhenAlreadyLoaded { return }

        if let modelString = appSettings.selectedTypewriter,
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
        appSettings.volumeSetting = volume
        loadedTypewriter?.setVolume(volume)
    }
}
