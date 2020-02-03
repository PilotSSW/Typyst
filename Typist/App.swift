//
// Created by Sean Wolford on 2019-01-16.
// Copyright (c) 2019 wickedPropeller. All rights reserved.
//

import Foundation

class App {
    static let instance: App = App()
    var ui = AppUI()
    var persistence = AppPersistence()

    var showModals: Bool = true
    private var loadedTypewriter: Typewriter?

    private init() {
        
    }

    deinit {
        loadedTypewriter?.prepareToRemove()
        loadedTypewriter = nil
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

    func currentTypeWriter(model: TypewriterModel) {
        UserDefaults.standard.set(model.rawValue, forKey: "selectedTypewriter")
        loadedTypewriter?.prepareToRemove()
        loadedTypewriter = nil
        loadedTypewriter = Typewriter(model: model)
        loadedTypewriter?.volume = UserDefaults.standard.double(forKey: "lastSetVolume")
    }

    func loadTypeWriter() {
        if let model = UserDefaults.standard.string (forKey: "selectedTypewriter") {

            loadedTypewriter?.prepareToRemove()
            loadedTypewriter = nil
            if model == TypewriterModel.Royal_Model_P.rawValue {
                loadedTypewriter = Typewriter(model: TypewriterModel.Royal_Model_P)
            }
            else if model == TypewriterModel.Smith_Corona_Silent.rawValue {
                loadedTypewriter = Typewriter(model: TypewriterModel.Smith_Corona_Silent)
            }
            else if model == TypewriterModel.Olympia_SM3.rawValue {
                loadedTypewriter = Typewriter(model: TypewriterModel.Olympia_SM3)
            }
        } else {
            loadedTypewriter = Typewriter(model: TypewriterModel.Royal_Model_P)
        }
    }
    
    func simulatePaperReturn(enabled: Bool) {
        UserDefaults.standard.set(enabled, forKey: "paperReturnEnabled")
    }
    
    func paperReturnEnabled() -> Bool {
        UserDefaults.standard.bool(forKey: "paperFeedReturned")
    }

    func simulatePaperFeed(enabled: Bool) {
        UserDefaults.standard.set(enabled, forKey: "paperFeedEnabled")
    }

    func paperFeedEnabled() -> Bool {
        UserDefaults.standard.bool(forKey: "paperFeedEnabled")
    }

    func showModalNotifications(enabled: Bool) {
        UserDefaults.standard.set(enabled, forKey: "showModalNotifications")
    }

    func modalNotificationsEnabled() -> Bool {
        UserDefaults.standard.bool(forKey: "showModalNotifications")
    }
    
    func setVolumeTo(_ volume: Double) {
        loadedTypewriter?.volume = volume
    }
}
