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
    private var nsEventListeners: [Any?] = []

    internal static let eventTypes: [NSEvent.EventTypeMask] = [.keyUp, .keyDown, .flagsChanged]
    internal static let modifiers: [NSEvent.ModifierFlags] = [.capsLock, .command, .control, .function, .help, .numericPad, .option, .shift]

    // Listen for key presses in Typyst
    func listenForLocalKeyPresses(
        eventTypes: [NSEvent.EventTypeMask] = NSEventListener.eventTypes,
        modifiers: [NSEvent.ModifierFlags] = NSEventListener.modifiers,
        completion: @escaping (NSEvent) -> Void
    ) {
        // NSEvent listeners need to be added from main thread or they freeze the SwiftUI heirarchy
        DispatchQueue.main.async { [weak self] in
            for eventType in eventTypes {
                let listener = NSEvent.addLocalMonitorForEvents(matching: eventType) { event -> NSEvent in
                    completion(event)
                    return event
                }
                self?.nsEventListeners.append(listener)
                //logEvent(.debug, "NSEvent listener registered for local key presses of type: \(eventType)")
            }
        }
    }

    // Listen for key presses in other apps
    func listenForGlobalKeyPresses(
        eventTypes: [NSEvent.EventTypeMask] = NSEventListener.eventTypes,
        modifiers: [NSEvent.ModifierFlags] = NSEventListener.modifiers,
        completion: @escaping (NSEvent) -> Void
    ) {
        // NSEvent listeners need to be added from main thread or they freeze the SwiftUI heirarchy
        DispatchQueue.main.async { [weak self] in
            for eventType in NSEventListener.eventTypes {
                let listener = NSEvent.addGlobalMonitorForEvents(matching: eventType) { event in
                    completion(event)
                }
                self?.nsEventListeners.append(listener)
                //logEvent(.debug, "NSEvent listener registered for global key presses of type: \(eventType)")
            }
        }
    }

    func listenForAllKeyPresses(completion: @escaping (NSEvent) -> Void) {
        listenForLocalKeyPresses(completion: completion)
        listenForGlobalKeyPresses(completion: completion)
    }

    func removeKeyListeners() {
        for listener in nsEventListeners {
            if let listener = listener { NSEvent.removeMonitor(listener) }
        }
    }
}
