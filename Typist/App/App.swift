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
import FirebaseInstanceID

class App {
    static let instance: App = App()
    private(set) var ui = AppUI()
    private(set) var persistence = AppPersistence()

    private(set) var debug = false

    var showModals: Bool = true
    private var loadedTypewriter: Typewriter?

    private init() {
        
    }

    deinit {
        persistence.saveAction(self)
        unloadTypewriter()
    }

    func setup() {
        #if DEBUG
        debug = true
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
                    timer.eventHandler = { [weak self, weak modalBody, weak timer] in
                        if AppDelegate.isAccessibilityAdded() {
                            NSApplication.shared.stopModal()
                            timer = nil
                            self?.ui.typistAddedToAccessibility()
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
        loadedTypewriter = Typewriter(model: model)
    }

    func loadTypeWriter() {
        if let modelString = AppSettings.selectedTypewriter,
            let model = Typewriter.Model.init(rawValue: modelString) {
                setCurrentTypeWriter(model: model)
                return
        }

        setCurrentTypeWriter(model: Typewriter.defaultTypeWriter)
    }
    
    func simulatePaperReturn(enabled: Bool) {
        AppSettings.paperReturnEnabled = enabled
    }
    
    func isPaperReturnEnabled() -> Bool {
        AppSettings.paperReturnEnabled
    }

    func simulatePaperFeed(enabled: Bool) {
        AppSettings.simulatePaperFeed = enabled
    }

    func isPaperFeedEnabled() -> Bool {
        AppSettings.simulatePaperFeed
    }

    func showModalNotifications(enabled: Bool) {
        AppSettings.showModalNotifications = enabled
    }

    func isModalNotificationsEnabled() -> Bool {
        AppSettings.showModalNotifications
    }
    
    func setVolumeTo(_ volume: Double) {
        Sounds.instance.volume = volume
    }
}