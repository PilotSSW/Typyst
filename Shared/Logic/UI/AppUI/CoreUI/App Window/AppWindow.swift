//
// Created by Sean Wolford on 3/3/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import AppKit
import Combine
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
                         AppCore.instance.persistence.persistentContainer.viewContext)
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

        NotificationCenter.default.publisher(for: NSWindow.willCloseNotification)
            .sink { [weak self] (notification) in
                guard let self = self else { return }
                if let window = notification.object as? NSWindow, window == self.mainWindow {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
                        guard let self = self else { return }
                        AppSettings.shared.showMainWindow = self.mainWindow.isVisible
                    })
                }
            }
            .store(in: &AppCore.instance.subscriptions)
    }

    func showWindow() {
        controller.showWindow(nil)
        AppCore.instance.ui.appMenu?.appMenuItems.showMainWindow.state = .on
    }

    func closeWindow() {
        controller.close()
        AppCore.instance.ui.appMenu?.appMenuItems.showMainWindow.state = .off
    }
}
