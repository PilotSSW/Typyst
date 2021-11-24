//
// Created by Sean Wolford on 2/15/20.
// Copyright (c) 2020 wickedPropeller. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

final class UserDefaultsAppSettings: ObservableObject {
    enum Keys {
        static let allowExternalMacOSKeypresses = "allowExternalMacOSKeypresses"
        static let bell = "bell"
        static let firstLoad = "firstLoad"
        static let lidOpenClose = "lidOpenClose"
        static let logErrorsAndCrashes = "logErrorsAndCrashes"
        static let logUsageAnalytics = "logUsageAnalytics"
        static let mainVolumeValue = "mainVolumeValue"
        static let paperFeed = "paperFeedEnabled"
        static let paperReturn = "paperReturnEnabled"
        static let runAsMenubarApp = "runAsMenuBarApp"
        static let selectedTypewriter = "selectedTypewriter"
        static let showMainWindow = "showMainWindow"
        static let showModalNotifications = "showModalNotifications"
        static let showTypeWriterView = "showTypeWriterView"
    }

    init() {
        if firstLoad {

        }
        else if OSHelper.runtimeEnvironment == .iOS {
            showTypeWriterView = false
        }
    }

    @Published var allowExternalMacOSKeypresses: Bool = UserDefaults.standard.bool(forKey: Keys.allowExternalMacOSKeypresses) {
        didSet { UserDefaults.standard.set(allowExternalMacOSKeypresses, forKey: Keys.allowExternalMacOSKeypresses) }
    }

    @Published var bell: Bool = UserDefaults.standard.bool(forKey: Keys.bell) {
        didSet { UserDefaults.standard.set(bell, forKey: Keys.bell) }
    }

    @Published var firstLoad: Bool = UserDefaults.standard.bool(forKey: Keys.firstLoad) {
        didSet { UserDefaults.standard.setValue(firstLoad, forKey: Keys.firstLoad) }
    }

    @Published var logErrorsAndCrashes: Bool = UserDefaults.standard.bool(forKey: Keys.logErrorsAndCrashes) {
        didSet { UserDefaults.standard.set(logErrorsAndCrashes, forKey: Keys.logErrorsAndCrashes) }
    }

    @Published var lidOpenClose: Bool = UserDefaults.standard.bool(forKey: Keys.lidOpenClose) {
        didSet { UserDefaults.standard.set(lidOpenClose, forKey: Keys.lidOpenClose) }
    }

    @Published var logUsageAnalytics: Bool = UserDefaults.standard.bool(forKey: Keys.logUsageAnalytics) {
        didSet { UserDefaults.standard.set(logUsageAnalytics, forKey: Keys.logUsageAnalytics) }
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

    @Published var showTypeWriterView: Bool = UserDefaults.standard.bool(forKey: Keys.showTypeWriterView) {
        didSet { UserDefaults.standard.set(showTypeWriterView, forKey: Keys.showTypeWriterView) }
    }

    @Published var volumeSetting: Double = UserDefaults.standard.double(forKey: Keys.mainVolumeValue) {
        didSet { UserDefaults.standard.set(volumeSetting, forKey: Keys.mainVolumeValue) }
    }
}

final class AppDebugSettings: ObservableObject {
    enum Keys {
        static let debugGlobal = "debugGlobal"
        static let debugKeypresses = "debugKeypresses"
    }
    
    init() {
        #if DEBUG
        debugGlobal = true
        #else
        debugGlobal = false
        debugKeypresses = false
        #endif
    }

    @Published var debugGlobal: Bool = UserDefaults.standard.bool(forKey: Keys.debugGlobal) {
        didSet { UserDefaults.standard.set(debugGlobal, forKey: Keys.debugGlobal) }
    }

    @Published var debugKeypresses: Bool = UserDefaults.standard.bool(forKey: Keys.debugKeypresses) {
        didSet { UserDefaults.standard.set(debugKeypresses, forKey: Keys.debugKeypresses) }
    }
}
