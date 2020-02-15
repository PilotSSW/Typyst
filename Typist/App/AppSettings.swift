//
// Created by Sean Wolford on 2/15/20.
// Copyright (c) 2020 wickedPropeller. All rights reserved.
//

import Foundation

class AppSettings {
    static var selectedTypewriter: String? {
        get {
            UserDefaults.standard.string(forKey: "selectedTypewriter")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "selectedTypewriter")
        }
    }

    static var paperFeedEnabled: Bool {
        get {
            UserDefaults.standard.bool(forKey: "paperFeedEnabled")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "paperFeedEnabled")
        }
    }

    static var paperReturnEnabled: Bool {
        get {
            UserDefaults.standard.bool(forKey: "paperFeedReturned")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "paperReturnEnabled")
        }
    }

    static var simulatePaperFeed: Bool {
        get {
            UserDefaults.standard.bool(forKey: "paperFeedEnabled")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "paperFeedEnabled")
        }
    }

    static var showModalNotifications: Bool {
        get {
            UserDefaults.standard.bool(forKey: "showModalNotifications")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "showModalNotifications")
        }
    }
}