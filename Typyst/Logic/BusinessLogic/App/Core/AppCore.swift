//
// Created by Sean Wolford on 2/15/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import Foundation

class AppCore {
    private(set) var loadedTypewriter: TypeWriter?

    init() {

    }

    deinit {
        unloadTypewriter()
    }

    func setup() {
        loadTypeWriter()
    }

    func setCurrentTypeWriter(model: TypeWriter.Model) {
        AppSettings.selectedTypewriter = model.rawValue
        unloadTypewriter()
        loadedTypewriter = TypeWriter(model: model, errorHandler: { (soundErrors) in
            App.instance.ui.alerts.errors.couldntFindSoundsAlert(sounds: soundErrors.map({ $0.localizedDescription }))
        })
    }

    func loadTypeWriter() {
        if let modelString = AppSettings.selectedTypewriter,
           let model = TypeWriter.Model.init(rawValue: modelString) {
            setCurrentTypeWriter(model: model)
            return
        }

        setCurrentTypeWriter(model: TypeWriter.defaultTypeWriter)
    }

    func unloadTypewriter() {
        loadedTypewriter = nil
    }

    func setVolumeTo(_ volume: Double) {
        AppSettings.volumeSetting = volume
        loadedTypewriter?.sounds.volume = volume
    }
}
