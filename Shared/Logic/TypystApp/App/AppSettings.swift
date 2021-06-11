//
// Created by Sean Wolford on 2/15/20.
// Copyright (c) 2020 wickedPropeller. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

@dynamicMemberLookup
class AppSettings: ObservableObject {
    enum Keys {
        static let bell = "bell"
        static let lidOpenClose = "lidOpenClose"
        static let logToFirebase = "logToFirebase"
        static let logUsageAnalytics = "logUsageAnalytics"
        static let mainVolumeValue = "mainVolumeValue"
        static let paperFeed = "paperFeedEnabled"
        static let paperReturn = "paperReturnEnabled"
        static let runAsMenubarApp = "runAsMenuBarApp"
        static let selectedTypewriter = "selectedTypewriter"
        static let showMainWindow = "showMainWindow"
        static let showModalNotifications = "showModalNotifications"
    }

//    fileprivate private(set) var analyticsUsageChanged = [((Bool) -> Void)]()

    subscript(dynamicMember member: String) -> Any? {
        switch member {
            case Keys.bell: return bell
        case Keys.logToFirebase: return logErrorsAndCrashes
        case Keys.logUsageAnalytics: return logUsageAnalytics
        case Keys.mainVolumeValue: return volumeSetting
        case Keys.paperFeed: return paperFeedEnabled
        case Keys.paperReturn: return paperReturnEnabled
        case Keys.runAsMenubarApp: return runAsMenubarApp
        case Keys.selectedTypewriter: return selectedTypewriter
        case Keys.showMainWindow: return showMainWindow
        case Keys.showModalNotifications: return showModalNotifications
        default:
            return nil
        }
    }

    @Published var bell: Bool = UserDefaults.standard.bool(forKey: Keys.bell) {
        didSet { UserDefaults.standard.set(bell, forKey: Keys.bell) }
    }

    @Published var logErrorsAndCrashes: Bool = UserDefaults.standard.bool(forKey: Keys.lidOpenClose) {
        didSet { UserDefaults.standard.set(logErrorsAndCrashes, forKey: Keys.logToFirebase) }
    }

    @Published var lidOpenClose: Bool = UserDefaults.standard.bool(forKey: Keys.lidOpenClose) {
        didSet { UserDefaults.standard.set(lidOpenClose, forKey: Keys.lidOpenClose) }
    }

    @Published var logUsageAnalytics: Bool = UserDefaults.standard.bool(forKey: Keys.logUsageAnalytics) {
        didSet {
            UserDefaults.standard.set(logUsageAnalytics, forKey: Keys.logUsageAnalytics)
            //analyticsUsageChanged.forEach({ $0(logUsageAnalytics) })
        }
    }

    @Published var paperFeedEnabled: Bool = UserDefaults.standard.bool(forKey: Keys.paperFeed) {
        didSet { UserDefaults.standard.set(paperFeedEnabled, forKey: Keys.paperFeed) }
    }

    @Published var paperReturnEnabled: Bool = UserDefaults.standard.bool(forKey: Keys.paperReturn) {
        didSet { UserDefaults.standard.set(paperReturnEnabled, forKey: Keys.paperReturn) }
    }

    @Published var runAsMenubarApp: Bool = UserDefaults.standard.bool(forKey: Keys.runAsMenubarApp) {
        didSet { UserDefaults.standard.set(runAsMenubarApp, forKey: Keys.runAsMenubarApp) }
    }

    @Published var selectedTypewriter: String? = UserDefaults.standard.string(forKey: Keys.selectedTypewriter) {
        didSet { UserDefaults.standard.set(selectedTypewriter, forKey: Keys.selectedTypewriter) }
    }

    @Published var showMainWindow: Bool = UserDefaults.standard.bool(forKey: Keys.showMainWindow) {
        didSet { UserDefaults.standard.set(showMainWindow, forKey: Keys.showMainWindow) }
    }

    @Published var showModalNotifications: Bool = UserDefaults.standard.bool(forKey: Keys.showModalNotifications) {
        didSet { UserDefaults.standard.set(showModalNotifications, forKey: Keys.showModalNotifications) }
    }

    @Published var volumeSetting: Double = UserDefaults.standard.double(forKey: Keys.mainVolumeValue) {
        didSet { UserDefaults.standard.set(volumeSetting, forKey: Keys.mainVolumeValue) }
    }

//    func onLogUsageAnalyticsChanged(_ event: @escaping ((Bool) -> Void)) {
//        analyticsUsageChanged.append(event)
//    }
//
//    func removeAllOnLogUsageAnalyticsChangedEvents(_ events: [Int]? = nil) {
//        if events != nil {
//            events?.forEach({ _ = analyticsUsageChanged.remove(at: $0) })
//        } else {
//            analyticsUsageChanged.removeAll()
//        }
//    }
}

@dynamicMemberLookup
class AppDebugSettings: ObservableObject {
    enum Keys {
        static let debugGlobal = "debugGlobal"
        static let debugKeypresses = "debugKeypresses"
    }

    @Published var debugGlobal: Bool = UserDefaults.standard.bool(forKey: Keys.debugGlobal) {
        didSet { UserDefaults.standard.set(debugGlobal, forKey: Keys.debugGlobal) }
    }

    @Published var debugKeypresses: Bool = UserDefaults.standard.bool(forKey: Keys.debugKeypresses) {
        didSet { UserDefaults.standard.set(debugKeypresses, forKey: Keys.debugKeypresses) }
    }

    subscript(dynamicMember member: String) -> Any? {
        switch member {
        case Keys.debugGlobal: return debugGlobal
        case Keys.debugKeypresses: return debugKeypresses
        default:
            return nil
        }
    }
}
