//
// Created by Sean Wolford on 3/3/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import AppKit
import Foundation
import SwiftUI

class AppWindow {
    var mainWindow: NSWindow
    var controller: NSWindowController

    init() {
        // Create the window and set the content view.
        mainWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 300, height: 640),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered,
            defer: false)
        mainWindow.setContentSize(NSSize(width: 300, height: 640))
        //mainWindow.center()

        // Create the SwiftUI view and set the context as the value for the managedObjectContext environment keyPath.
        // Add `@Environment(\.managedObjectContext)` in the views that will need the context.
        let contentView = MainView()
            .environment(\.managedObjectContext,
                         App.instance.persistence.persistentContainer.viewContext)
//        let mainView = NSHostingView(rootView: contentView)
//        mainWindow.contentView = mainView
        mainWindow.contentViewController = NSHostingController(rootView: contentView)

        // Set properties
        mainWindow.titlebarAppearsTransparent = true
        mainWindow.isMovableByWindowBackground = false
        mainWindow.setFrameAutosaveName("Main Window")

        // Setup translucency
        mainWindow.isOpaque = false
        mainWindow.backgroundColor = NSColor.clear.shadow(withLevel: 0.25)

        // Fire it up!
        mainWindow.makeKeyAndOrderFront(nil)
        controller = NSWindowController(window: mainWindow)
    }

    func showWindow() {
        controller.showWindow(nil)
    }

    func closeWindow() {
        controller.close()
    }
}
