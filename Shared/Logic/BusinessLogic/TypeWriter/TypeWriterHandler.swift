//
// Created by Sean Wolford on 2/15/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

class TypeWriterHandler: Alertable, Loggable, ObservableObject {
    private var keyHandler: KeyHandler? = nil
    @Published private(set) var loadedTypewriter: TypeWriter? {
        didSet { fireAllActionsOnTypeWriterChange(loadedTypewriter) }
    }
    private var onTypewriterDidChange: [((TypeWriter?) -> Void)?] = []

    deinit {
        unloadTypewriter()
    }

    func setup(withKeyHandler kHandler: KeyHandler? = appDependencyContainer.keyHandler) {
        if let kHandler = kHandler { setKeyHandler(kHandler) }
        loadTypeWriter()
        logEvent(.trace, "TypeWriterHandler setup")
    }

    func setCurrentTypeWriter(modelType: TypeWriterModel.ModelType) {
        appDependencyContainer.appSettings.selectedTypewriter = modelType.rawValue

        let loadCB = { [weak self] in
            guard let self = self,
                  let keyHandler = self.keyHandler
            else { return }

            self.loadedTypewriter = TypeWriter(modelType: modelType, keyHandler: keyHandler,
                errorHandler: { [weak self] (soundErrors) in
                    guard let self = self else { return }
                    let sounds = soundErrors.map({ $0.localizedDescription })
                    self.showAlert(ErrorAlerts.soundsFailedToLoad(sounds))
            }) { [weak self] loadedSounds in
                guard let self = self else { return }
                let soundSets = loadedSounds.soundSets.keys.map({ $0.rawValue }).sorted(by: <)
                self.showAlert(UserInfoAlerts.soundsLoaded(soundSets))
            }
        }

        loadedTypewriter == nil
            ? loadCB()
            : unloadTypewriter(loadCB)
    }

    func loadTypeWriter(forceWhenAlreadyLoaded: Bool = false) {
        if loadedTypewriter != nil && !forceWhenAlreadyLoaded { return }

        if let modelString = appDependencyContainer.appSettings.selectedTypewriter,
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
        appDependencyContainer.appSettings.volumeSetting = volume
        loadedTypewriter?.setVolume(volume)
    }
}

extension TypeWriterHandler {
    public func registerActionOnTypeWriterChange(_ completion: ((TypeWriter?) -> Void)?) {
        onTypewriterDidChange.append(completion)
    }

    public func unregisterAllActionsOnTypeWriterChange(_ completion: ((TypeWriter?) -> Void)?) {
        onTypewriterDidChange.removeAll()
    }

    public func fireAllActionsOnTypeWriterChange(_ newTypeWriter: TypeWriter?) {
        onTypewriterDidChange.forEach({ registeredAction in
            registeredAction?(newTypeWriter)
        })
    }
}

extension TypeWriterHandler {
    public func setKeyHandler(_ keyHandler: KeyHandler) {
        self.keyHandler = keyHandler
    }

    public func removeKeyHandler() {
        keyHandler = nil
    }
}
