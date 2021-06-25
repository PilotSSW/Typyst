//
//  TypystAppViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 6/1/21.
//

import Foundation
import GBDeviceInfo
import SwiftUI

class TypystAppViewModel: Loggable, ObservableObject {
    let appDependencyContainer = AppDependencyContainer.get()

    init() {
        #if os(macOS)
            #if DEBUG
            Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/macOSInjection10.bundle")?.load()
            #endif

            UserDefaults.standard.register(defaults: ["NSApplicationCrashOnExceptions": true])

        OSHelper.askUserToAllowSystemAccessibility()
        #endif

        logEvent(.info, "App running", context: [
            GBDeviceInfo.deviceInfo() ?? "Device Info Unavailable",
            GBDeviceInfo().isIAPAvailable,
            GBDeviceInfo().isMacAppStoreAvailable
        ])
    }

    func handleScenePhaseChange(_ phase: ScenePhase) {
        if phase == .active {
            //AppDependencyContainer.get().typeWriterHandler.loadTypeWriter()
        }
        else if phase == .inactive {
            //AppDependencyContainer.get().typeWriterHandler.unloadTypewriter()
        }
        else if phase == .background {
            //AppDependencyContainer.get().typeWriterHandler.unloadTypewriter()
        }
    }
}
