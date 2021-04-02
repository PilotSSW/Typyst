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
    }

    func setCurrentTypeWriter(model: TypeWriterModel.ModelType) {
        AppSettings.shared.selectedTypewriter = model.rawValue
        unloadTypewriter()
        loadedTypewriter = TypeWriter(model: model, errorHandler: { (soundErrors) in
            App.instance.ui.alerts.errors.couldntFindSoundsAlert(sounds: soundErrors.map({ $0.localizedDescription }))
        }) { loadedSounds in
            App.instance.ui.alerts.userInfo.typeWriterSoundsLoadedAlert(
                loadedSounds.soundSets.keys
                    .map({ $0.rawValue })
                    .sorted(by: <))
        }
    }

    func loadTypeWriter() {
        if let modelString = AppSettings.shared.selectedTypewriter,
           let model = TypeWriterModel.ModelType.init(rawValue: modelString) {
            setCurrentTypeWriter(model: model)
            return
        }

        setCurrentTypeWriter(model: TypeWriter.defaultTypeWriter)
    }

    func unloadTypewriter() {
        loadedTypewriter = nil
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
