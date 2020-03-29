//
// Created by Sean Wolford on 2019-01-16.
// Copyright (c) 2019 wickedPropeller. All rights reserved.
//

import AppKit
import Foundation
import FirebaseCore
import FirebaseCoreDiagnostics
import FirebaseCrashlytics
import FirebaseInstallations

class App {
    static let instance: App = App()
    private(set) var ui = AppUI()
    private(set) var persistence = AppPersistence()

    var showModals: Bool = true
    private(set) var loadedTypewriter: Typewriter?

    private init() {
        
    }

    deinit {
        persistence.saveAction(self)
        unloadTypewriter()
    }

    func setup() {
        #if DEBUG
        AppDebugSettings.debugGlobal = true
        #endif

        loadTypeWriter()
        ui.setupApplicationUI()
        if !AppDelegate.isAccessibilityAdded() {
            ui.keyCaptureUnavailableAlert(){ [weak self] modalResponse in
                guard let self = self else { return }
                NSWorkspace.shared.open(URL(fileURLWithPath: "/System/Library/PreferencePanes/Security.prefPane"))
                self.ui.addToTrustedAppsAlert(userAddedToAccessibilityCompletion: { [weak self] (modalBody) in
                    // Check that the app has permission to listen for key events
                    let timer = RepeatingTimer(timeInterval: 0.5)
                    timer.eventHandler = { [weak self, weak timer] in
                        if AppDelegate.isAccessibilityAdded() {
                            NSApplication.shared.stopModal()
                            timer?.suspend()
                            self?.ui.typystAddedToAccessibility()
                        }
                    }
                    timer.resume()
                })
            }
        }
    }

    @objc func quit(_ sender: Any?) {
        NSApplication.shared.terminate(sender)
    }

    func unloadTypewriter() {
        loadedTypewriter = nil
    }

    func setCurrentTypeWriter(model: Typewriter.Model) {
        AppSettings.selectedTypewriter = model.rawValue
        unloadTypewriter()
        loadedTypewriter = Typewriter(model: model, errorHandler: { [weak self] (soundErrors) in
            guard let strongSelf = self else { return }
            strongSelf.ui.couldntFindSoundsAlert(sounds: soundErrors.map({ $0.localizedDescription }))
        })
    }

    func loadTypeWriter() {
        if let modelString = AppSettings.selectedTypewriter,
            let model = Typewriter.Model.init(rawValue: modelString) {
                setCurrentTypeWriter(model: model)
                return
        }

        setCurrentTypeWriter(model: Typewriter.defaultTypeWriter)
    }
    
    func setVolumeTo(_ volume: Double) {
        Sounds.instance.volume = volume
    }
}
