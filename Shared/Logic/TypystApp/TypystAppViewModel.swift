//
//  TypystAppViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 6/1/21.
//

import Foundation
import SwiftUI

class TypystAppViewModel: ObservableObject {
    init() {
        #if os(macOS)
            #if DEBUG
            Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/macOSInjection10.bundle")?.load()
            #endif

            UserDefaults.standard.register(defaults: ["NSApplicationCrashOnExceptions": true])
        #endif
    }

    func handleScenePhaseChange(_ phase: ScenePhase) {
        if phase == .active {
            //appDependencyContainer.typeWriterHandler.loadTypeWriter()
        }
        else if phase == .inactive {
            //appDependencyContainer.typeWriterHandler.unloadTypewriter()
        }
        else if phase == .background {
            //appDependencyContainer.typeWriterHandler.unloadTypewriter()
        }
    }
}
