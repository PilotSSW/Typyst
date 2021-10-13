//
//  TypystApp.swift
//  Shared
//
//  Created by Sean Wolford on 4/11/21.
//

import SwiftUI

@main
struct TypystApp: App {
    @Environment(\.scenePhase) private var scenePhase

    let persistenceController = PersistenceController.shared
    #if os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var window: NSWindow?
    #endif

    @ObservedObject
    var viewModel: TypystAppViewModel = TypystAppViewModelFactory.getViewModel()

    var body: some Scene {
        #if os(macOS)
        WindowGroup {
            ZStack {
                VisualEffectBlur(material: .underWindowBackground,
                                 blendingMode: .behindWindow,
                                 state: .active)

                if viewModel.shouldRenderMainView {
                    AppWindowContainerView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                        .environmentObject(viewModel.appDependencyContainer.rootDependencyContainer.appDebugSettings)
                        .environmentObject(viewModel.appDependencyContainer.rootDependencyContainer.settingsService)
                        .environmentObject(viewModel.appDependencyContainer.alertsService)
                }
            }
            .background(WindowAccessor(window: $window))
            .frame(minWidth: 300, minHeight: 300)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .windowToolbarStyle(UnifiedCompactWindowToolbarStyle())
        .handlesExternalEvents(matching: ["main"])
        .onChange(of: scenePhase, perform: { phase in
            viewModel.handleScenePhaseChange(phase)
        })
        .commands {
            ReplacementMenuCommands()
            MainMenuCommands()
        }

        WindowGroup {
            let viewModel = VideoPlayerViewModel()
            VideoPlayerView(viewModel: viewModel)
        }
        .handlesExternalEvents(matching: ["video"])
        .windowStyle(HiddenTitleBarWindowStyle())
        .windowToolbarStyle(UnifiedCompactWindowToolbarStyle())

        #elseif os(iOS)
        WindowGroup {
            AppWindowContainerView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(viewModel.appDependencyContainer.rootDependencyContainer.appDebugSettings)
                .environmentObject(viewModel.appDependencyContainer.rootDependencyContainer.settingsService)
                .environmentObject(viewModel.appDependencyContainer.alertsService)
        }
        .onChange(of: scenePhase, perform: { phase in
            viewModel.handleScenePhaseChange(phase)
        })
//        .commands {
//            ReplacementMenuCommands()
//            MainMenuCommands()
//        }
        #endif
    }
}
