//
// Created by Sean Wolford on 2/6/20.
// Copyright (c) 2020 wickedPropeller. All rights reserved.
//

import Foundation
import SwiftySound

class Sounds {
    private var soundSets = [Sounds.AvailableSoundSets: [Sound]]() 
    var volume: Double {
        get {
            let sounds = soundSets.values.flatMap({ $0 })
            let averageVolume = sounds.map({ Double($0.volume) }).reduce(0.0, +) / Double(sounds.count)
            return averageVolume
        }
        set(newValue) {
            soundSets.forEach({
                $0.value.forEach({
                    $0.volume = Float(newValue)
                })
            })
        }
    }

    init() {

    }

    private func getSoundSet(location: String, errorHandler: (([SoundError]) -> Void)?) -> [Sound] {
        var sounds = [Sound]()
        var soundsNotFound = [SoundError]()

        Bundle.main.urls(forResourcesWithExtension: nil, subdirectory: location)?.forEach({
            if let keySound = Sound(url: $0) {
                keySound.prepare()
                sounds.append(keySound)
            }
            else {
                soundsNotFound.append(SoundError(path: $0.relativePath, kind: .soundNotFound))
            }
        })

        if soundsNotFound.count > 0 {
            errorHandler?(soundsNotFound)
        }
        return sounds
    }

    func loadSounds(for model: Typewriter.Model, completion: (() -> ())?, errorHandler: (([SoundError]) -> ())?) {
        // Load KeyUp sounds
        Sounds.AvailableSoundSets.allCases.forEach({
            let key = $0
            let result = getSoundSet(location: "Soundsets/\(model.rawValue)/\(key)", errorHandler: errorHandler)
            soundSets[key] = result
        })
        completion?()
    }

    func unloadSounds() {
        soundSets.removeAll()
    }

    func playSound(for soundSet: Sounds.AvailableSoundSets, completion: (() -> ())? = nil) {
        if let sounds = soundSets[soundSet] {
            if let sound: Sound = sounds.randomElement() {
                sound.play(completion: { event in
                    completion?()
                })
            }
        }
    }

    func playSound(from sets: [Sounds.AvailableSoundSets], completion: (() -> ())? = nil) {
        let sounds:[Sound] = sets.compactMap({ soundSets[$0] }).flatMap({ $0 })
        if let sound: Sound = sounds.randomElement() {
            sound.play(completion: { event in
                completion?()
            })
        }
    }

    enum AvailableSoundSets: String, CaseIterable {
        case BackspaceUp = "BackspaceUp"
        case BackspaceDown = "BackspaceDown"
        case Bell = "Bell"
        case DoubleLineReturn = "DoubleLineReturn"
        case KeyUp = "KeyUp"
        case KeyDown = "KeyDown"
        case Letters = "Letters"
        case LidDown = "LidDown"
        case LidUp = "LidUp"
        case MarginRelease = "MarginRelease"
        case Numbers = "Numbers"
        case PaperFeed = "PaperFeed"
        case PaperLoad = "PaperLoad"
        case PaperRelease = "PaperRelease"
        case PaperReturn = "PaperReturn"
        case RibbonSelector = "RibbonSelector"
        case ShiftUp = "ShiftUp"
        case ShiftDown = "ShiftDown"
        case ShiftLock = "ShiftLock"
        case ShiftRelease = "ShiftRelease"
        case SingleLineReturn = "SingleLineReturn"
        case SpaceDown = "SpaceDown"
        case SpaceUp = "SpaceUp"
        case Symbols = "Symbols"
        case TabDown = "TabDown"
        case TabUp = "TabUp"
        case TripleLineReturn = "TripleLineReturn"
    }
}
