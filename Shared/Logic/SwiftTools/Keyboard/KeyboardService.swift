//
// Created by Sean Wolford on 4/18/21.
//

import Foundation

final class KeyboardService: Loggable {
    private var appSettings: AppSettings
    private var appDebugSettings: AppDebugSettings

    private var handlers = [String: ((KeyEvent) -> Void)]()

    init(appSettings: AppSettings,
         appDebugSettings: AppDebugSettings) {
        self.appSettings = appSettings
        self.appDebugSettings = appDebugSettings
    }

    deinit {
        handlers.removeAll()
    }

    internal func registerKeyPressCallback(withTag tag: String, completion: @escaping (KeyEvent) -> Void)  {
        if handlers[tag] != nil { return }
        handlers[tag] = completion
    }

    internal func removeListenerCallback(withTag tag: String) {
        handlers.removeValue(forKey: tag)
    }

    internal func handleEvent(_ event: KeyEvent, _ completion: ((KeyEvent) -> Void)? = nil) {
        #if KEYBOARD_EXTENSION
        let queue = DispatchQueue.main
        #else
        let queue = DispatchQueue.global(qos: .userInteractive)
        #endif
        
        queue.async(execute: { [weak self] in
            guard let self = self else { return }

            // Handle debug
            if self.appDebugSettings.debugGlobal && self.appDebugSettings.debugKeypresses {
                // Never ever log this in production
                self.logEvent(.debug, "Event: \(event)")
            }

            if event.timeSinceEvent <= 0.75 {
                self.handlers.values.forEach({ $0(event) })
                completion?(event)
            }
        })
    }
}
