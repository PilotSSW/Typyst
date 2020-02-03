//
// Created by Sean Wolford on 2019-01-16.
// Copyright (c) 2019 wickedPropeller. All rights reserved.
//

import Foundation

var app: App?

class App {
    var ui = AppUI()
    var persistence = AppPersistence()

    let showModals: Bool = true
    var loadedTypewriter: Typewriter?

    init() {
        loadTypeWriter()
        ui.setupApplicationUI()

        // Ensure key capture events are available or alert user
        let opts = NSDictionary(object: kCFBooleanTrue, forKey: kAXTrustedCheckOptionPrompt.takeUnretainedValue() as NSString) as CFDictionary
        guard AXIsProcessTrustedWithOptions(opts) == true else {
            ui.keyCaptureUnavailableAlert()
            return
        }
    }

    deinit {
        self.loadedTypewriter?.prepareToRemove()
        loadedTypewriter = nil
    }

    func currentTypeWriter(model: TypewriterModel) {
        UserDefaults.standard.set(model.rawValue, forKey: "selectedTypewriter")
        self.loadedTypewriter?.prepareToRemove()
        self.loadedTypewriter = nil
        self.loadedTypewriter = Typewriter(model: model)
        self.loadedTypewriter?.volume = UserDefaults.standard.float(forKey: "lastSetVolume")
    }

    func loadTypeWriter() {
        if let model = UserDefaults.standard.string (forKey: "selectedTypewriter") {

            self.loadedTypewriter?.prepareToRemove()
            self.loadedTypewriter = nil
            if model == TypewriterModel.Royal_Model_P.rawValue {
                self.loadedTypewriter = Typewriter(model: TypewriterModel.Royal_Model_P)
            }
            else if model == TypewriterModel.Smith_Corona_Silent.rawValue {
                self.loadedTypewriter = Typewriter(model: TypewriterModel.Smith_Corona_Silent)
            }
            else if model == TypewriterModel.Olympia_SM3.rawValue {
                self.loadedTypewriter = Typewriter(model: TypewriterModel.Olympia_SM3)
            }
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
}
