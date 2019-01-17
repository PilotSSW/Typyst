//
// Created by Sean Wolford on 2019-01-16.
// Copyright (c) 2019 wickedPropeller. All rights reserved.
//

import Foundation

class App {
    var loadedTypewriter: Typewriter?

    init() {
        loadTypeWriter()
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
        }
    }

    func simulatePaperFeed(enabled: Bool) {
        UserDefaults.standard.set(enabled, forKey: "paperFeedEnabled")
    }

    func paperFeedEnabled() -> Bool {
        return UserDefaults.standard.bool(forKey: "paperFeedEnabled") ?? false
    }
}