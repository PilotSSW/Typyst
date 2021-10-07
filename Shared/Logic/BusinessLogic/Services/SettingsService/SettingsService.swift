//
//  SettingsService.swift
//  Typyst
//
//  Created by Sean Wolford on 9/15/21.
//

import Combine
import Foundation

final class SettingsService: ObservableObject {
    private var store = Set<AnyCancellable>()
    private let userDefaultsSettings = UserDefaultsAppSettings()

    @Published var allowExternalMacOSKeypresses: Bool = false
    @Published var bell: Bool = true
    @Published var lidOpenClose: Bool = true
    @Published var logErrorsAndCrashes: Bool = true
    @Published var logUsageAnalytics: Bool = false
    @Published var paperFeedEnabled: Bool = true
    @Published var paperReturnEnabled: Bool = true
    @Published var runAsMenubarApp: Bool = false
    @Published var selectedTypewriter: String? = ""
    @Published var showMainWindow: Bool = false
    @Published var showModalNotifications: Bool = false
    @Published var showTypeWriterView: Bool = true
    @Published var volumeSetting: Double = 100

    init() {
        attachToUserDefaultsAppSettings()
    }

    private func attachToUserDefaultsAppSettings() {
        allowExternalMacOSKeypresses = userDefaultsSettings.allowExternalMacOSKeypresses
        bell = userDefaultsSettings.bell
        lidOpenClose = userDefaultsSettings.lidOpenClose
        logErrorsAndCrashes = userDefaultsSettings.logErrorsAndCrashes
        logUsageAnalytics = userDefaultsSettings.logUsageAnalytics
        paperFeedEnabled = userDefaultsSettings.paperFeedEnabled
        paperReturnEnabled = userDefaultsSettings.paperReturnEnabled
        runAsMenubarApp = userDefaultsSettings.paperReturnEnabled
        selectedTypewriter = userDefaultsSettings.selectedTypewriter
        showMainWindow = userDefaultsSettings.showMainWindow
        showModalNotifications = userDefaultsSettings.showMainWindow
        showTypeWriterView = userDefaultsSettings.showTypeWriterView
        volumeSetting = userDefaultsSettings.volumeSetting

        $allowExternalMacOSKeypresses.sink(receiveValue: { [weak self] bool in
            self?.userDefaultsSettings.allowExternalMacOSKeypresses = bool
        }).store(in: &store)
        $bell.sink(receiveValue: { [weak self] bool in
            self?.userDefaultsSettings.bell = bool
        }).store(in: &store)
        $lidOpenClose.sink(receiveValue: { [weak self] bool in
            self?.userDefaultsSettings.lidOpenClose = bool
        }).store(in: &store)
        $logErrorsAndCrashes.sink(receiveValue: { [weak self] bool in
            self?.userDefaultsSettings.logErrorsAndCrashes = bool
        }).store(in: &store)
        $logUsageAnalytics.sink(receiveValue: { [weak self] bool in
            self?.userDefaultsSettings.logUsageAnalytics = bool
        }).store(in: &store)
        $paperFeedEnabled.sink(receiveValue: { [weak self] bool in
            self?.userDefaultsSettings.paperFeedEnabled = bool
        }).store(in: &store)
        $paperReturnEnabled.sink(receiveValue: { [weak self] bool in
            self?.userDefaultsSettings.paperReturnEnabled = bool
        }).store(in: &store)
        $runAsMenubarApp.sink(receiveValue: { [weak self] bool in
            self?.userDefaultsSettings.runAsMenubarApp = bool
        }).store(in: &store)
        $selectedTypewriter.sink(receiveValue: { [weak self] typeWriter in
            self?.userDefaultsSettings.selectedTypewriter = typeWriter
        }).store(in: &store)
        $showMainWindow.sink(receiveValue: { [weak self] bool in
            self?.userDefaultsSettings.showMainWindow = bool
        }).store(in: &store)
        $showModalNotifications.sink(receiveValue: { [weak self] bool in
            self?.userDefaultsSettings.showModalNotifications = bool
        }).store(in: &store)
        $showTypeWriterView.sink(receiveValue: { [weak self] bool in
            self?.userDefaultsSettings.showTypeWriterView = bool
        }).store(in: &store)
        $volumeSetting.sink(receiveValue: { [weak self] volume in
            self?.userDefaultsSettings.volumeSetting = volume
        }).store(in: &store)
    }
}
