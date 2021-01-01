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

    @ObservedObject
    var viewModel: TypystAppViewModel_macOS = TypystAppViewModelFactory.getViewModel()
    #elseif os(iOS)

    @ObservedObject
    var viewModel: TypystAppViewModel_iOS = TypystAppViewModelFactory.getViewModel()
    #endif

    var body: some Scene {
        #if os(macOS)
        WindowGroup {
            ZStack {
                VisualEffectBlur(material: .underWindowBackground,
                                 blendingMode: .behindWindow,
                                 state: .active)

                if viewModel.shouldRenderMainView {
                    AppWindowView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                        .environmentObject(viewModel.rootDependencyContainer)
                        .environmentObject(viewModel.appDependencyContainer)
                        .environmentObject(viewModel.appDependencyContainer.alertsService)
                }
            }
            .background(WindowAccessor(window: $window))
            .frame(minWidth: 312, idealWidth: 320, maxWidth: 500,
                   minHeight: 300, idealHeight: 1880, maxHeight: 3840)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .windowToolbarStyle(UnifiedCompactWindowToolbarStyle())
        .onChange(of: scenePhase, perform: { phase in
            viewModel.handleScenePhaseChange(phase)
        })

//        .commands {
//            ReplacementMenuCommands()
//            MainMenuCommands()
//        }
        WindowGroup {
            ZStack {
                VisualEffectBlur(material: .underWindowBackground,
                                 blendingMode: .behindWindow,
                                 state: .active)


            }
            .background(WindowAccessor(window: $window))
            .frame(minWidth: 312, idealWidth: 320, maxWidth: 500,
                   minHeight: 300, idealHeight: 1880, maxHeight: 3840)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .windowToolbarStyle(UnifiedCompactWindowToolbarStyle())
        #elseif os(iOS)
        WindowGroup {
            AppWindowView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(viewModel.rootDependencyContainer)
                .environmentObject(viewModel.appDependencyContainer)
                .environmentObject(viewModel.appDependencyContainer.alertsService)        }
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
