//
// Created by Sean Wolford on 2019-01-16.
// Copyright (c) 2019 wickedPropeller. All rights reserved.
//

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

        // Ensure key capture events are available or alert user
        let opts = NSDictionary(object: kCFBooleanTrue, forKey: kAXTrustedCheckOptionPrompt.takeUnretainedValue() as NSString) as CFDictionary
        guard AXIsProcessTrustedWithOptions(opts) == true else {
            ui.keyCaptureUnavailableAlert()
            return
        }
    }

    func unloadTypewriter(){
        loadedTypewriter = nil
    }

    func setCurrentTypeWriter(model: Typewriter.Model) {
        UserDefaults.standard.set(model.rawValue, forKey: "selectedTypewriter")
        unloadTypewriter()
        loadedTypewriter = Typewriter(model: model)
    }

    func loadTypeWriter() {
        if let modelString = UserDefaults.standard.string (forKey: "selectedTypewriter") {
            if let model = Typewriter.Model.init(rawValue: modelString) {
                setCurrentTypeWriter(model: model)
            }
        } else {
            setCurrentTypeWriter(model: Typewriter.defaultTypeWriter)
        }
    }
    
    func simulatePaperReturn(enabled: Bool) {
        UserDefaults.standard.set(enabled, forKey: "paperReturnEnabled")
    }
    
    func isPaperReturnEnabled() -> Bool {
        UserDefaults.standard.bool(forKey: "paperFeedReturned")
    }

    func simulatePaperFeed(enabled: Bool) {
        UserDefaults.standard.set(enabled, forKey: "paperFeedEnabled")
    }

    func isPaperFeedEnabled() -> Bool {
        UserDefaults.standard.bool(forKey: "paperFeedEnabled")
    }

    func showModalNotifications(enabled: Bool) {
        UserDefaults.standard.set(enabled, forKey: "showModalNotifications")
    }

    func isModalNotificationsEnabled() -> Bool {
        UserDefaults.standard.bool(forKey: "showModalNotifications")
    }
    
    func setVolumeTo(_ volume: Double) {
        Sounds.instance.volume = volume
    }
}
