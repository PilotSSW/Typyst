//
//  Typewriter.swift
//  Typist
//
//  Created by Sean Wolford on 1/14/19.
//  Copyright © 2019 wickedPropeller. All rights reserved.
//

import AppKit
import Foundation
import HotKey
import SwiftySound

class Typewriter {

    // Typewriter variables / constants
    var model: TypewriterModel?
    var marginWidth = 80
    
    var numberOfNewLines = 0
    var lineIndex = 0

    // Soundsets
    let keySets        = [
        "BackspaceUp", "BackspaceDown",
        "Bell",
        "DoubleLineReturn",
        "KeyUp", "KeyDown",
        "Letters",
        "LidDown", "LidUp",
        "MarginRelease",
        "Numbers",
        "PaperFeed", "PaperLoad", "PaperRelease", "PaperReturn",
        "RibbonSelector",
        "ShiftUp", "ShiftDown", "ShiftLock", "ShiftRelease",
        "SingleLineReturn",
        "SpaceDown", "SpaceUp",
        "Symbols",
        "TabDown", "TabUp",
        "TripleLineReturn"
    ]
    var soundSets      = [String: [Sound]]()
    var keyListenerSet = [Any?]()
    var shiftIsPressed = false
    var capsOn         = false

    init(model: TypewriterModel, marginWidth: Int = 80) {
        self.model = model
        self.marginWidth = marginWidth
        loadSounds()
        createKeyEventListeners()

        if soundSets["LidUp"]?.count ?? 0 > 0 {
            soundSets["LidUp"]?.randomElement()?.play()
        }
    }

    func getSoundset(location: String) -> [Sound] {
        var sounds = [Sound]()
        var soundsNotFound = [String]()
        Bundle.main.urls(forResourcesWithExtension: "aif", subdirectory: location)?.forEach({
            if let keySound = Sound(url: $0.absoluteURL) {
                keySound.prepare()
                sounds.append(keySound)
            }
            else {
                soundsNotFound.append($0.relativePath)
            }
        })

        if soundsNotFound.count > 0 {
            let alert = NSAlert()
            alert.messageText = "Some sounds were unable to be loaded"
            
            var message = ""
            soundsNotFound.forEach({ message += $0 })
            alert.informativeText = message
            alert.runModal()
        }
        return sounds
    }

    func loadSounds() {
        // Load KeyUp sounds
        let model = self.model?.rawValue ?? ""
        let modelLocation = "Soundsets/\(model)/"

        for keySet in keySets {
            soundSets[keySet] = getSoundset(location: modelLocation + keySet)
        }
        
        if app?.modalNotificationsEnabled() ?? false {
            let alert = NSAlert()
            alert.messageText = "Loaded sounds"
            
            var message = ""
            soundSets.forEach({ message += $0.key + "\n" })
            if let index = message.lastIndex(of: "\n") {
                message.remove(at: index)
            }
            alert.informativeText = message
            alert.runModal()
        }
    }

    func assignKeyPresses(event: NSEvent) {

        // Make sure the event is some kind of key press
        let keyCode = event.keyCode
        let intVal = UInt32(exactly: keyCode) ?? 0
        if let keyPressed = Key(carbonKeyCode: intVal) {
            if lineIndex >= marginWidth {
                lineIndex = 0
                if UserDefaults.standard.bool(forKey: "paperReturnEnabled") {
                    let bell = self.soundSets["Bell"]?.randomElement()
                    bell?.play()
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: UInt64(exactly: bell?.duration ?? 0 + 0.1) ?? 0)) {
                        let lineReturn = ((self.soundSets["SingleLineReturn"] ?? []) +
                            (self.soundSets["DoubleLineReturn"] ?? []) +
                            (self.soundSets["TripleLineReturn"] ?? [])).randomElement()
                        lineReturn?.play()
                    }
                }
            }

            // These should be ordered by likelihood they were the key pressed. The fewer the searches, the faster the
            // sound plays ;)

            if shiftSet.contains(keyPressed) {
                shiftIsPressed == false ?
                    self.soundSets["ShiftDown"]?.randomElement ()?.play () :
                    self.soundSets["ShiftUp"]?.randomElement ()?.play ()

                // Flag key directions aren't tracked - we need to do that.
                shiftIsPressed = !shiftIsPressed
            }
            else if keyPressed == Key.space {
                if event.type == NSEvent.EventType.keyUp {
                    self.soundSets["SpaceUp"]?.randomElement()?.play()
                }
                else {
                    lineIndex += 1
                    self.soundSets["SpaceDown"]?.randomElement()?.play()
                }
            }
            else if keyPressed == Key.return || keyPressed == Key.keypadEnter {
                lineIndex = 0
                ((self.soundSets["SingleLineReturn"] ?? []) +
                (self.soundSets["DoubleLineReturn"] ?? []) +
                (self.soundSets["TripleLineReturn"] ?? [])).randomElement()?.play()

                if numberOfNewLines == 25 {
                    numberOfNewLines = 0
                    if UserDefaults.standard.bool(forKey: "paperFeedEnabled") {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: UInt64(1))) {
                            if let sound = self.soundSets["PaperLoad"]?.randomElement() {
                                sound.play()
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: UInt64(1))) {
                                    self.soundSets["PaperFeed"]?.randomElement()?.play()
                                }
                            }
                        }
                    }
                }

                else {
                    // Only count the key press once - not on both up and down
                    if event.type == NSEvent.EventType.keyDown {
                        numberOfNewLines += 1
                    }
                }
            }
            else if keyPressed == Key.delete || keyPressed == Key.forwardDelete {
                if event.type == NSEvent.EventType.keyUp {
                    self.soundSets["BackspaceUp"]?.randomElement()?.play()
                }
                else {
                    self.soundSets["BackspaceDown"]?.randomElement()?.play()
                    if lineIndex > 0 {
                        lineIndex += -1
                    }
                }
            }
            else if keyPressed == Key.escape && soundSets["PaperRelease"]?.count != 0 && soundSets["PaperReturn"]?.count != 0 {
                event.type == NSEvent.EventType.keyUp ?
                    self.soundSets["PaperRelease"]?.randomElement()?.play() :
                    self.soundSets["PaperReturn"]?.randomElement()?.play()
            }
            else if keyPressed == Key.capsLock {
                capsOn ? self.soundSets["ShiftLock"]?.randomElement()?.play() :
                    self.soundSets["ShiftRelease"]?.randomElement()?.play()
                capsOn = !capsOn
            }
            else if keyPressed == Key.tab && soundSets["TabUp"]?.count != 0 && soundSets["TabDown"]?.count != 0 {
                if event.type == NSEvent.EventType.keyUp {
                    self.soundSets["TabUp"]?.randomElement()?.play()
                }
                else {
                    lineIndex += 5
                    self.soundSets["TabDown"]?.randomElement()?.play()
                }
            }
            else if bellSet.contains(keyPressed) {
                self.soundSets["Bell"]?.randomElement()?.play()
            }
            else if keyPressed == Key.keypadClear {
                self.soundSets["RibbonSelector"]?.randomElement()?.play()
            }
            else if event.type == NSEvent.EventType.systemDefined {
                // Stop any margin sounds that are already playing
                self.soundSets["MarginRelease"]?.forEach({ $0.stop() })
                self.soundSets["MarginRelease"]?.randomElement ()?.play ()
            }
            else {
                if event.type == NSEvent.EventType.keyUp {
                    self.soundSets["KeyUp"]?.randomElement ()?.play ()
                }
                else {
                    lineIndex += 1
                    self.soundSets["KeyDown"]?.randomElement ()?.play ()
                }
            }
        }
    }
    
    func createKeyEventListeners() {

        let eventTypes: [NSEvent.EventTypeMask] = [.keyUp, .keyDown, .flagsChanged]

        for eventType in eventTypes {

            // Listen for key presses in Typist
//            keyListenerSet.append(
//                NSEvent.addLocalMonitorForEvents(matching: eventType) { (aEvent) -> NSEvent in
//                    self.assignKeyPresses(event: aEvent)
//                    return aEvent
//                })

            // Listen for key presses in other apps
            keyListenerSet.append(
                NSEvent.addGlobalMonitorForEvents(matching: eventType) { (event) in
                    self.assignKeyPresses(event: event)
                }
            )
        }
    }

    func prepareToRemove() {
        if soundSets["LidDown"]?.count ?? 0 > 0 {
            soundSets["LidDown"]?.randomElement()?.play()
        }

        keyListenerSet.removeAll()
        for keySet in keySets {
            soundSets[keySet] = nil
        }
        soundSets.removeAll()
    }
}
