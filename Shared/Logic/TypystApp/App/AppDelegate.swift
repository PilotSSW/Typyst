//
//  AppDelegate.swift
//  Typyst
//
//  Created by Sean Wolford on 1/14/19.
//  Copyright © 2019 wickedPropeller. All rights reserved.
//

import AppKit
import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    static func isAccessibilityAdded() -> Bool {
        // Ensure key capture events are available or alert user
        let opts = NSDictionary(object: kCFBooleanTrue as Any,
                                forKey: kAXTrustedCheckOptionPrompt.takeUnretainedValue() as NSString) as CFDictionary
        return AXIsProcessTrustedWithOptions(opts)
    }

    static func runAsMenubarApp(_ bool: Bool) {
        //NSApp.setActivationPolicy(bool ? .accessory : .regular)
    }

    static func quitApp() {

    }
}
