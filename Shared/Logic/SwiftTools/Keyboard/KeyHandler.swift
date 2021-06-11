//
// Created by Sean Wolford on 4/18/21.
//

import Foundation

final class KeyHandler: Loggable {
    private var handlers = [String: ((KeyEvent) -> Void)]()

    init() {

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
        DispatchQueue.global(qos: .userInteractive).async(execute: { [weak self] in
            guard let self = self else { return }

            // Handle debug
            let debugSettings = appDependencyContainer.appDebugSettings
            if debugSettings.debugGlobal && debugSettings.debugKeypresses {
                // Never ever log this in production
                self.logEvent(.info, "Event: \(event)")
            }

            if event.timeSinceEvent <= 0.75 {
                self.handlers.values.forEach({ $0(event) })
                completion?(event)
            }
        })
    }
}
