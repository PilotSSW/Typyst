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
import SwiftySound

class Typewriter {

    var model: TypewriterModel?
    var keyUpSounds: [Sound] = []
    var keyDownSounds: [Sound] = []

    init(model: TypewriterModel) {
        self.model = model
        loadSounds()
        createKeyEventListeners()
    }
    
    func loadSounds() {
        // Load KeyUp sounds
        let keyUpDir = "Soundsets/\(model?.rawValue ?? "")/KeyUp"
        Bundle.main.urls(forResourcesWithExtension: ".aif", subdirectory: keyUpDir)?.forEach({
            if let keySound = Sound(url: $0.absoluteURL) {
                keySound.prepare()
                keyUpSounds.append(keySound)
            }
        })
        
        // Load KeyDown sounds
        let keyDownDir = "Soundsets/\(model?.rawValue ?? "")/KeyDown"
        Bundle.main.urls(forResourcesWithExtension: ".aif", subdirectory: keyDownDir)?.forEach({
            if let keySound = Sound(url: $0.absoluteURL) {
                keySound.prepare()
                keyDownSounds.append(keySound)
            }
        })
    }
    
    func createKeyEventListeners() {
        let keyUpListener = NSEvent.addLocalMonitorForEvents(matching: .keyUp) { (aEvent) -> NSEvent in
            self.playKeyUpSound()
            print("KEY-UP!!!")
            return aEvent
        }

        let keyDownListener = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { (aEvent) -> NSEvent in
            self.playKeyDownSound()
            print("KEY-DOWN!!!")
            return aEvent
        }
        
//        let trackPadListener = NSEvent.addLocalMonitorForEvents(matching: .any, handler: { (aEvent) -> NSEvent in
//            self.playKeyDownSound()
//            print("ANY")
//            return aEvent
//        })
    }
    
    func playKeyUpSound() {
        self.keyUpSounds.randomElement()?.play()
    }
    
    func playKeyDownSound() {
        self.keyDownSounds.randomElement()?.play()
    }
}
