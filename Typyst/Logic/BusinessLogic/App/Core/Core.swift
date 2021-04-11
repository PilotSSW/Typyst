//
// Created by Sean Wolford on 2/15/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

class AppCore: ObservableObject {
    @Published private(set) var loadedTypewriter: TypeWriter? {
        didSet { fireAllActionsOnTypeWriterChange(loadedTypewriter) }
    }
    private var onTypewriterDidChange: [((TypeWriter?) -> Void)?] = []

    init() {

    }

    deinit {
        unloadTypewriter()
    }

    func setup() {
        loadTypeWriter()
        App.instance.logging.log(.debug, "Core setup")
    }

    func setCurrentTypeWriter(modelType: TypeWriterModel.ModelType) {
        AppSettings.shared.selectedTypewriter = modelType.rawValue

        let loadCB = { [weak self] in
            guard let self = self else { return }
            self.loadedTypewriter = TypeWriter(modelType: modelType, errorHandler: { (soundErrors) in
                App.instance.ui.alerts.errors.couldntFindSoundsAlert(sounds: soundErrors.map({ $0.localizedDescription }))
            }) { loadedSounds in
                App.instance.ui.alerts.userInfo.typeWriterSoundsLoadedAlert(
                    loadedSounds.soundSets.keys
                        .map({ $0.rawValue })
                        .sorted(by: <))
            }
        }

        loadedTypewriter == nil
            ? loadCB()
            : unloadTypewriter(loadCB)
    }

    func loadTypeWriter() {
        if let modelString = AppSettings.shared.selectedTypewriter,
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
        AppSettings.shared.volumeSetting = volume
        loadedTypewriter?.setVolume(volume)
    }
}

extension AppCore {
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
