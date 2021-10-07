//
// Created by Sean Wolford on 2/6/20.
// Copyright (c) 2020 wickedPropeller. All rights reserved.
//

import Combine
import Foundation
import SwiftySound

final class SoundsService: Loggable {
    private var subscriptionStore = Set<AnyCancellable>()
    private var settingsService: SettingsService

    private(set) var soundSets = [SoundsService.AvailableSoundSets: [Sound]]()
    var volume: Double {
        get {
            let sounds = soundSets.values.flatMap({ $0 })
            let averageVolume = sounds.map({ Double($0.volume) }).reduce(0.0, +) / Double(sounds.count)
            return averageVolume
        }
        set(newValue) {
            var multiplier = 1.0
            #if KEYBOARD_EXTENSION
            multiplier = 0.4
            #endif
            soundSets.forEach({
                $0.value.forEach({
                    $0.volume = Float(newValue * multiplier)
                })
            })
        }
    }

    init(settingsService: SettingsService = RootDependencyContainer.get().settingsService) {
        self.settingsService = settingsService
        commonInit()
    }

    internal init(withSoundSets soundSets: [SoundsService.AvailableSoundSets : [Sound]] = [SoundsService.AvailableSoundSets: [Sound]](),
                  settingsService: SettingsService = RootDependencyContainer.get().settingsService) {
        self.soundSets = soundSets
        self.settingsService = settingsService
        commonInit()
    }

    private func commonInit() {
        Sound.playersPerSound = 1

        settingsService.$volumeSetting
            .sink { [weak self] in
                guard let self = self else { return }
                self.volume = $0
            }
            .store(in: &subscriptionStore)
    }

    deinit {
        unloadSounds()
    }

    private func getSoundSet(location: String) -> ([Sound], [SoundError]) {
        var sounds = [Sound]()
        var soundsNotFound = [SoundError]()

        Bundle.main.urls(forResourcesWithExtension: nil, subdirectory: location)?.forEach({
            if let keySound = Sound(url: $0) {
                keySound.prepare()
                sounds.append(keySound)
            }
            else {
                let error = SoundError(path: $0.relativePath, kind: .soundNotFound)
                logEvent(.error, error: error)
                soundsNotFound.append(error)
            }
        })

        return (sounds, soundsNotFound)
    }

    func loadSounds(for model: TypeWriterModel.ModelType, completion: ((SoundsService) -> ())?, errorHandler: (([SoundError]) -> ())?) {
        var soundErrors = [SoundError]()
        
        #if KEYBOARD_EXTENSION
        let queue = DispatchQueue.main
        let after: DispatchTime = .now() + 0.25
        #else
        let queue = DispatchQueue.global(qos: .userInitiated)
        let after: DispatchTime = .now()
        #endif

        // Load KeyUp sounds
        queue.asyncAfter(deadline: after, execute: { [weak self] in
            guard let self = self else { return }
            SoundsService.AvailableSoundSets.allCases.forEach({
                let key = $0
                let result = self.getSoundSet(location: "Soundsets/\(model.rawValue)/\(key)")
                self.soundSets[key] = result.0
                soundErrors.append(contentsOf: result.1)
            })

            if soundErrors.count > 0 {
                DispatchQueue.main.async(execute: {
                    errorHandler?(soundErrors)
                })
            }

            self.volume = self.settingsService.volumeSetting

            DispatchQueue.main.async(execute: { [weak self] in
                guard let self = self else { return }
                completion?(self)
            })
        })
    }

    func unloadSounds() {
        soundSets.removeAll()
    }

    func playSound(for soundSet: SoundsService.AvailableSoundSets, completion: (() -> ())? = nil) {
        #if KEYBOARD_EXTENSION
        let queue = DispatchQueue.main
        #else
        let queue = DispatchQueue.global(qos: .userInteractive)
        #endif
        
        queue.async(execute: { [weak self] in
            guard let self = self else { return }
            if let sounds = self.soundSets[soundSet],
               let sound: Sound = sounds.randomElement() {
                sound.play(completion: { event in
                    DispatchQueue.main.async(execute: {
                        completion?()
                    })
                })
            }
        })
    }

    func playSound(fromOneOfAny sets: [SoundsService.AvailableSoundSets], completion: (() -> ())? = nil) {
        #if KEYBOARD_EXTENSION
        let queue = DispatchQueue.main
        #else
        let queue = DispatchQueue.global(qos: .userInteractive)
        #endif
        
        queue.async(execute: { [weak self] in
            guard let self = self else { return }
            let sounds:[Sound] = sets.compactMap({ self.soundSets[$0] }).flatMap({ $0 })
            if let sound: Sound = sounds.randomElement() {
                sound.play(completion: { event in
                    DispatchQueue.main.async(execute: {
                        completion?()
                    })
                })
            }
        })
    }

    func hasSoundFromSoundset(_ soundSet: AvailableSoundSets) -> Bool {
        let sounds = soundSets[soundSet]
        return sounds != nil && sounds?.count ?? 0 > 0
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

    enum extendedSoundSets: String, CaseIterable {
        case aUp = "aUp"
        case aDown = "aDown"
    }
}
