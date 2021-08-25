//
//  TypystAppViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 6/1/21.
//

import Foundation
import GBDeviceInfo
import enum SwiftUI.ScenePhase

final class TypystAppViewModelFactory {
    private static var viewModel: TypystAppViewModel? = nil
    static func getViewModel() -> TypystAppViewModel {
        if viewModel == nil { viewModel = TypystAppViewModel() }
        return viewModel!
    }
}

#if os(macOS)
final class TypystAppViewModel: Loggable, ObservableObject {
    var rootDependencyContainer: RootDependencyContainer { RootDependencyContainer.get() }
    var appDependencyContainer: AppDependencyContainer { AppDependencyContainer.get() }

    @Published
    var shouldRenderMainView: Bool = true

    fileprivate init() {
        #if DEBUG
        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/macOSInjection10.bundle")?.load()
        #endif

        UserDefaults.standard.register(defaults: ["NSApplicationCrashOnExceptions": true])

        if (!OSHelper.isAccessibilityAdded()) {
            OSHelper.askUserToAllowSystemAccessibility()
        }

        logEvent(.info, "MacOS App running", context: [
            GBDeviceInfo.deviceInfo() ?? "Device Info Unavailable" as Any,
            GBDeviceInfo().isIAPAvailable,
            GBDeviceInfo().isMacAppStoreAvailable
        ])
    }

    func handleScenePhaseChange(_ phase: SwiftUI.ScenePhase) {
        logEvent(.debug, "App is now in scenePhase \(phase)", context: phase)
        let appIsForeground = phase == .active
        shouldRenderMainView = appIsForeground
    }
}
#elseif os(iOS)
final class TypystAppViewModel: Loggable, ObservableObject {
    var rootDependencyContainer: RootDependencyContainer { RootDependencyContainer.get() }
    var appDependencyContainer: AppDependencyContainer { AppDependencyContainer.get() }

    private var typeWriterService: TypeWriterService {
        appDependencyContainer.rootDependencyContainer.typeWriterService
    }

    @Published
    var shouldRenderMainView: Bool = true

    fileprivate init() {
        logEvent(.info, "iOS /iPadOS App running", context: [
            GBDeviceInfo.deviceInfo()
        ])
    }

    func handleScenePhaseChange(_ phase: SwiftUI.ScenePhase) {
        logEvent(.debug, "App is now in scenePhase \(phase)", context: phase)

        let appIsForeground = phase == .active
        shouldRenderMainView = appIsForeground

        appIsForeground
            ? typeWriterService.loadTypeWriter()
            : typeWriterService.unloadTypewriter()
    }
}
#endif
