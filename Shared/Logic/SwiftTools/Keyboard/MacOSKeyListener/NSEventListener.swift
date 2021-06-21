//
//  NSEventListener.swift
//  Typyst (macOS)
//
//  Created by Sean Wolford on 6/13/21.
//

import AppKit
import Foundation

/// Mark: Interface with NSEvent listeners
class NSEventListener: Loggable {
    private var nsEventListeners: [String: Any?] = [:]

    internal static let eventTypes: [NSEvent.EventTypeMask] = [.keyUp, .keyDown, .flagsChanged]
    internal static let modifiers: [NSEvent.ModifierFlags] = [.capsLock, .command, .control, .function, .help, .numericPad, .option, .shift]

    // Listen for key presses in Typyst
    func listenForLocalKeyPresses(
            callerDescription: String = "",
            eventTypes: [NSEvent.EventTypeMask] = NSEventListener.eventTypes,
            modifiers: [NSEvent.ModifierFlags] = NSEventListener.modifiers,
            onKeyPress: @escaping (NSEvent) -> Void,
            completion: (([String]) -> Void)? = nil
    ) {
        // NSEvent listeners need to be added from main thread or they freeze the SwiftUI heirarchy
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            var keyBag = [String]()
            for eventType in eventTypes {
                let listener = NSEvent.addLocalMonitorForEvents(matching: eventType) { event -> NSEvent in
                    onKeyPress(event)
                    return event
                }
                let listenerKey = self.generateEventListenerHash(eventType: eventType, description: callerDescription)
                keyBag.append(listenerKey)
                self.nsEventListeners[listenerKey] = listener
                self.logEvent(.debug, "NSEvent listener registered for local key presses of type: \(eventType)")
            }

            completion?(keyBag)
        }
    }

    // Listen for key presses in other apps
    func listenForGlobalKeyPresses(
            callerDescription: String = "",
            eventTypes: [NSEvent.EventTypeMask] = NSEventListener.eventTypes,
            modifiers: [NSEvent.ModifierFlags] = NSEventListener.modifiers,
            onKeyPress: @escaping (NSEvent) -> Void,
            completion: (([String]) -> Void)? = nil
    ) {
        // NSEvent listeners need to be added from main thread or they freeze the SwiftUI heirarchy
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            var keyBag = [String]()
            for eventType in NSEventListener.eventTypes {
                let listener = NSEvent.addGlobalMonitorForEvents(matching: eventType) { event in
                    onKeyPress(event)
                }
                let listenerKey = self.generateEventListenerHash(eventType: eventType, description: callerDescription)
                keyBag.append(listenerKey)
                self.nsEventListeners[listenerKey] = listener
                self.logEvent(.debug,
                    """
                    Register listener with key: \(listenerKey)
                    NSEvent listener registered for global key presses of type: \(eventType)
                    """)
            }

            completion?(keyBag)
        }
    }

    func listenForAllKeyPresses(
            callerDescription: String = "",
            eventTypes: [NSEvent.EventTypeMask] = NSEventListener.eventTypes,
            modifiers: [NSEvent.ModifierFlags] = NSEventListener.modifiers,
            onKeyPress: @escaping (NSEvent) -> Void,
            completion: (([String]) -> Void)? = nil
    ) {
        var keyBag = [String]()
        var functionsReturned = 0

        let funcCompletion: (([String]) -> Void)? = { receiptKeys in
            keyBag.append(contentsOf: receiptKeys)
            functionsReturned += 1

            if (functionsReturned > 1) {
                completion?(keyBag)
                return
            }
        }

        listenForLocalKeyPresses(
                callerDescription: callerDescription,
                eventTypes: eventTypes,
                modifiers: modifiers,
                onKeyPress: onKeyPress,
                completion: funcCompletion)

        listenForGlobalKeyPresses(
                callerDescription: callerDescription,
                eventTypes: eventTypes,
                modifiers: modifiers,
                onKeyPress: onKeyPress,
                completion: funcCompletion)
    }

    func removeKeyListeners(receiptKeys: [String] = []) {
        if receiptKeys.count == 0 {
           nsEventListeners.keys.forEach ({ removeKeyListener(receiptKey: $0) })
        }
        else {
            receiptKeys.forEach({ removeKeyListener(receiptKey: $0) })
        }
    }

    func removeKeyListener(receiptKey: String) {
        if let listener = nsEventListeners[receiptKey] as? Any {
            NSEvent.removeMonitor(listener)
        }
    }
}

extension NSEventListener {
    private func generateEventListenerHash(
            eventType: NSEvent.EventTypeMask,
            description: String = "",
            hash: UUID = UUID()) -> String {
        let descString = description.count > 0 ? "-\(description)" : ""
        return "nsEvent-\(eventType)\(descString)-\(hash)"
    }
}
