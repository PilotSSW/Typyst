//
//  Typewriter.swift
//  Typist
//
//  Created by Sean Wolford on 1/14/19.
//  Copyright © 2019 wickedPropeller. All rights reserved.
//

import AppKit
import Foundation
import Files
import HotKey
import SwiftySound

class Typewriter {

    // Typewriter variables / constants
    var model: TypewriterModel?

    // Recognized keypresses
    let letterSet: [Key] =
        [.a, .b, .c, .d, .e, .f, .g, .h, .i, .j, .k, .l, .m, .n, .o, .p, .q, .r, .s, .t, .u, .v, .x, .y, .z]
    let numberSet: [Key] =
        [.zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine,
         .keypad0, .keypad1, .keypad2, .keypad3, .keypad4, .keypad5, .keypad6, .keypad7, .keypad8, .keypad9]
    let letterNumberKeyset: [Key]
    let shiftSet: [Key] = [.shift, .rightShift]

    // Soundsets
    let keySets = [
        "BackspaceUp", "BackspaceDown",
        "Bell",
        "KeyUp", "KeyDown",
        "MarginRelease",
        "Number",
        "ShiftUp", "ShiftDown", "ShiftLock", "ShiftRelease",
        "Symbols"
    ]
    var soundSets = [String: [Sound]]()
    var keyListenerSet = [Any?]()
    var flagDown = true
    var capsOn = false

    init(model: TypewriterModel) {
        self.model = model
        self.letterNumberKeyset = numberSet + letterSet
        loadSounds()
        createKeyEventListeners()
    }

    func getSoundset(location: String) -> [Sound] {
        var sounds = [Sound]()
        Bundle.main.urls(forResourcesWithExtension: ".aif", subdirectory: location)?.forEach({
            if let keySound = Sound(url: $0.absoluteURL) {
                keySound.prepare()
                sounds.append(keySound)
            }
        })
        return sounds
    }
    
    func loadSounds() {
        // Load KeyUp sounds
        let model = self.model?.rawValue ?? ""
        let modelLocation = "Soundsets/\(model)/"

        for keySet in keySets {
            soundSets[keySet] = getSoundset(location: modelLocation + keySet)
        }
    }

    func assignKeyPresses(event: NSEvent) {

        // Make sure the event is some kind of key press
        if let keyPressed = Key(carbonKeyCode: UInt32(event.keyCode)) {

            // Check if the key press was in the up or down direction
            if event.type == NSEvent.EventType.keyUp {
                print("\(keyPressed) Key-Up")
                if letterNumberKeyset.contains (keyPressed) {
                    self.soundSets["KeyUp"]?.randomElement ()?.play ()
                }
                else {
                    self.soundSets["ShiftUp"]?.randomElement ()?.play ()
                }
            }
            else if event.type == NSEvent.EventType.keyDown {
                print("\(keyPressed) Key-Down")
                if letterNumberKeyset.contains (keyPressed) {
                    self.soundSets["KeyDown"]?.randomElement ()?.play ()
                }
                else {
                    self.soundSets["ShiftDown"]?.randomElement ()?.play ()
                }
            }
            else if event.type == NSEvent.EventType.flagsChanged {
                print("\(keyPressed) Flag")
                if keyPressed == Key.capsLock {
                    capsOn ? self.soundSets["ShiftLock"]?.randomElement()?.play() :
                             self.soundSets["ShiftRelease"]?.randomElement()?.play()
                    capsOn = !capsOn
                }
                else if flagDown {
                    self.soundSets["ShiftDown"]?.randomElement ()?.play ()
                }
                else {
                    self.soundSets["ShiftUp"]?.randomElement ()?.play ()
                }

                // Flag key directions aren't tracked - we need to do that.
                flagDown = !flagDown
            }
            else if event.type == NSEvent.EventType.systemDefined {
                print("\(keyPressed) System")
                // Stop any margin sounds that are already playing
                self.soundSets["MarginRelease"]?.forEach({ $0.stop() })
                self.soundSets["MarginRelease"]?.randomElement ()?.play ()
            }
        }
    }
    
    func createKeyEventListeners() {

        let eventTypes: [NSEvent.EventTypeMask] = [.keyUp, .keyDown, .flagsChanged, .systemDefined]

        for eventType in eventTypes {

            // Listen for key presses in Typist
            keyListenerSet.append(
                NSEvent.addLocalMonitorForEvents(matching: eventType) { (aEvent) -> NSEvent in
                    self.assignKeyPresses(event: aEvent)
                    return aEvent
                })

            // Listen for key presses in other apps
            keyListenerSet.append(
                NSEvent.addGlobalMonitorForEvents(matching: eventType) { (aEvent) in
                    self.assignKeyPresses(event: aEvent)
                })
        }
    }
}
