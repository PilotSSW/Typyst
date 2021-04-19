//
//  TypystApp.swift
//  Shared
//
//  Created by Sean Wolford on 4/11/21.
//

import SwiftUI

@main
struct TypystApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        #if os(macOS)
        WindowGroup {
            ContentView()
                .visualEffect(material: .contentBackground)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .windowToolbarStyle(UnifiedCompactWindowToolbarStyle())
        #endif

        #if os(iOS)
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        #endif
    }
}
