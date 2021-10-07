//
//  MacOSService.swift
//  Typyst
//
//  Created by Sean Wolford on 9/8/21.
//

import AppKit
import Combine
import Foundation

class MacOSService {
    private static let keyboardServiceTag = "macOSKeyboardService"
    private(set) var alertsService: AlertsService
    private(set) var keyboardService: KeyboardService
    private(set) var settingsService: SettingsService
    private(set) var macOSKeyListener: MacOSKeyListener

    init(alertsService: AlertsService = AppDependencyContainer.get().alertsService,
         keyboardService: KeyboardService = RootDependencyContainer.get().keyboardService,
         settingsService: SettingsService = RootDependencyContainer.get().settingsService,
         subscriptions: inout Set<AnyCancellable>) {
        self.alertsService = alertsService
        self.settingsService = settingsService
        self.keyboardService = keyboardService
        self.macOSKeyListener = MacOSKeyListener()

        let _ = macOSKeyListener.registerKeyPressCallback(withTag: MacOSService.keyboardServiceTag,
                                                          completion: { [weak self] keyEvent in
                                                              guard let self = self else { return }
                                                              self.keyboardService.handleEvent(keyEvent)
                                                          })

        registerServiceListeners(subscriptions: &subscriptions)
    }

    private func registerServiceListeners(subscriptions: inout Set<AnyCancellable>) {
        settingsService.$allowExternalMacOSKeypresses
            .sink { [weak self] allowKeypresses in
                guard let self = self else { return }
                self.setKeypressListenerEnvironment(allowKeypresses)
            }
            .store(in: &subscriptions)
    }

    private func setKeypressListenerEnvironment(_ allowKeypresses: Bool) {
        if !allowKeypresses {
            macOSKeyListener.setKeyListenerEnvironment(.local)
        }
        else {
            if (!OSHelper.isAccessibilityAdded()) {
                OSHelper.askUserToAllowSystemAccessibility(alertsService: alertsService) { [weak self] _ in
                    guard let self = self else { return }
                    self.macOSKeyListener.setKeyListenerEnvironment(.all)
                    self.showWindow(.main)
                }
                showWindow(.accessoryVideo)
            }
            else {
                macOSKeyListener.setKeyListenerEnvironment(.all)
            }
        }
    }
}

/// MARK: Window management functions
extension MacOSService {
    enum WindowName: String {
        case main = "typyst://main"
        case accessoryVideo = "typyst://video"
    }
    private func showWindow(_ window: WindowName = .main) {
        if let url = URL(string: window.rawValue) {
            NSWorkspace.shared.open(url)
        }
    }
}

