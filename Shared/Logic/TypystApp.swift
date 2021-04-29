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
    @State
    private var window: NSWindow?
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
            ZStack {
                VisualEffectBlur(material: .underWindowBackground,
                                 blendingMode: .behindWindow,
                                 state: .active)
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            .background(WindowAccessor(window: $window))
            .frame(minWidth: 312, idealWidth: 320, maxWidth: 450,
                   minHeight: 300, idealHeight: 1880, maxHeight: 3840)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .windowToolbarStyle(UnifiedCompactWindowToolbarStyle())
        .onChange(of: scenePhase, perform: { phase in
            if phase == .active {
                AppCore.instance.typeWriterHandler.loadTypeWriter()
            }
            else if phase == .inactive {

            }
            else if phase == .background {
                AppCore.instance.typeWriterHandler.unloadTypewriter()
            }
        })
        #endif

        #if os(iOS)
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        #endif
    }
}
