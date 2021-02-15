//
// Created by Sean Wolford on 2/15/20.
// Copyright (c) 2020 wickedPropeller. All rights reserved.
//

import Foundation

class AppSettings {
    public static let shared = AppSettings()
    private var analyticsUsageChanged = [((Bool) -> Void)]()

    private init() {

    }

    static var logErrorsAndCrashes: Bool {
        get {
            UserDefaults.standard.bool(forKey: "logToFirebase")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "logToFirebase")
        }
    }

    static var logUsageAnalytics: Bool {
        get {
            UserDefaults.standard.bool(forKey: "logUsageAnalytics")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "logUsageAnalytics")
            shared.analyticsUsageChanged.forEach({ $0(newValue) })
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
            UserDefaults.standard.bool(forKey: "paperReturnEnabled")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "paperReturnEnabled")
        }
    }

    static var selectedTypewriter: String? {
        get {
            UserDefaults.standard.string(forKey: "selectedTypewriter")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "selectedTypewriter")
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

    static var simulatePaperFeed: Bool {
        get {
            UserDefaults.standard.bool(forKey: "paperFeedEnabled")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "paperFeedEnabled")
        }
    }

    static var volumeSetting: Double {
        get {
            UserDefaults.standard.double(forKey: "mainVolumeValue")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "mainVolumeValue")
        }
    }

    func onLogUsageAnalyticsChanged(_ event: @escaping ((Bool) -> Void)) {
        analyticsUsageChanged.append(event)
    }

    func removeAllOnLogUsageAnalyticsChangedEvents(_ events: [Int]? = nil) {
        if events != nil {
            events?.forEach({ _ = analyticsUsageChanged.remove(at: $0) })
        } else {
            analyticsUsageChanged.removeAll()
        }
    }
}

class AppDebugSettings {
    static var debugGlobal: Bool {
        get {
            UserDefaults.standard.bool(forKey: "debugGlobal")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "debugGlobal")
        }
    }

    static var debugKeypresses: Bool {
        get {
            debugGlobal && UserDefaults.standard.bool(forKey: "debugKeypresses")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "debugKeypresses")
        }
    }
}