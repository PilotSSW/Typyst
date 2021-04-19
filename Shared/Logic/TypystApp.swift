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
    #endif

    init() {
        #if os(macOS)
            #if DEBUG
            Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/macOSInjection10.bundle")?.load()
            #endif

            UserDefaults.standard.register(defaults: ["NSApplicationCrashOnExceptions": true])
        #endif

        AppCore.instance.setup()
    }

    var body: some Scene {
        #if os(macOS)
        WindowGroup {
            ContentView()
                .visualEffect(material: .contentBackground)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .windowToolbarStyle(UnifiedCompactWindowToolbarStyle())
        .onChange(of: scenePhase, perform: { phase in
            if phase == .active { }
            else if phase == .inactive { }
            else if phase == .background {
                AppCore.instance.typeWriterHandler.unloadTypewriter()
            }
        })
        #endif

        #if os(iOS)
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        #endif
    }
}
