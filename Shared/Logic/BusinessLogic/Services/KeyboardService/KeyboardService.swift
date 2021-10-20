//
// Created by Sean Wolford on 4/18/21.
//

import Foundation
import KeyLogic

final class KeyboardService: Loggable {
    private var settingsService: SettingsService
    private var appDebugSettings: AppDebugSettings

    private var handlers = [String: ((KeyEvent) -> Void)]()

    init(settingsService: SettingsService,
         appDebugSettings: AppDebugSettings) {
        self.settingsService = settingsService
        self.appDebugSettings = appDebugSettings
    }

    deinit {
        handlers.removeAll()
    }

    internal func registerKeyPressCallback(withTag tag: String,
                                           shouldOverwriteExistingTag: Bool = false,
                                           completion: @escaping (KeyEvent) -> Void)  {
        if handlers[tag] != nil && !shouldOverwriteExistingTag { return }
        handlers[tag] = completion
    }

    internal func removeListenerCallback(withTag tag: String) {
        handlers.removeValue(forKey: tag)
    }

    internal func handleEvent(_ event: KeyEvent, _ completion: ((KeyEvent) -> Void)? = nil) {
        let isKeyboardExtension = OSHelper.runtimeEnvironment == .keyboardExtension
        let queue = isKeyboardExtension
            ? DispatchQueue.main
            : DispatchQueue.global(qos: .userInteractive)
        
        queue.async(execute: { [weak self] in
            guard let self = self else { return }

            // Handle debug
            #if DEBUG
            if self.appDebugSettings.debugGlobal && self.appDebugSettings.debugKeypresses {
                // Never ever log this in production
                self.logEvent(.debug, "Event: \(event)")
            }
            #endif

            if event.timeSinceEvent <= 0.75 {
                self.handlers.values.forEach({ $0(event) })
                completion?(event)
            }
        })
    }
}
