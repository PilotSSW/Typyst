//
// Created by Sean Wolford on 4/18/21.
//

import Foundation

final class KeyHandler {
    internal static let instance = KeyHandler()
    private var handlers = [String: ((KeyEvent) -> Void)]()

    private init() {

    }

    deinit {
        handlers.removeAll()
    }

    internal func registerKeyPressCallback(withTag tag: String, completion: @escaping (KeyEvent) -> Void) -> Bool {
        if handlers[tag] != nil { return false }
        handlers[tag] = completion
        return true
    }

    internal func removeListenerCallback(withTag tag: String) -> Bool {
        handlers.removeValue(forKey: tag) != nil
    }

    internal static func handleEvent(_ event: KeyEvent, _ completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .userInteractive).async(execute: {
            if event.timeSinceEvent <= 0.75 {
                // Handle debug
                let debugSettings = AppDebugSettings.shared
                if debugSettings.debugGlobal && debugSettings.debugKeypresses {
                    // Never ever log this in production
                    NSLog("Key: \(event.key) - \(event.direction)")
                    NSLog("Event: \(event)")
                }

                instance.handlers.values.forEach({
                    $0(event)
                })
                completion?()
            }
        })
    }
}
