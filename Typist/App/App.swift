//
// Created by Sean Wolford on 2019-01-16.
// Copyright (c) 2019 wickedPropeller. All rights reserved.
//

import AppKit
import Foundation

class App {
    static let instance: App = App()
    var ui = AppUI()
    var persistence = AppPersistence()

    var debug = true
    var showModals: Bool = true
    private var loadedTypewriter: Typewriter?

    private init() {
        
    }

    deinit {
        unloadTypewriter()
    }

    func setup() {
        loadTypeWriter()
        ui.setupApplicationUI()
        if !AppDelegate.isAccessibilityAdded() {
            ui.keyCaptureUnavailableAlert(){ [weak self] modalResponse in
                guard let self = self else { return }
                NSWorkspace.shared.open(URL(fileURLWithPath: "/System/Library/PreferencePanes/Security.prefPane"))
                self.ui.addToTrustedAppsAlert(completion: nil)
            }
        }
    }

    func unloadTypewriter(){
        loadedTypewriter = nil
    }

    func setCurrentTypeWriter(model: Typewriter.Model) {
        AppSettings.selectedTypewriter = model.rawValue
        unloadTypewriter()
        loadedTypewriter = Typewriter(model: model)
    }

    func loadTypeWriter() {
        if let modelString = AppSettings.selectedTypewriter {
            if let model = Typewriter.Model.init(rawValue: modelString) {
                setCurrentTypeWriter(model: model)
            }
        } else {
            setCurrentTypeWriter(model: Typewriter.defaultTypeWriter)
        }
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
