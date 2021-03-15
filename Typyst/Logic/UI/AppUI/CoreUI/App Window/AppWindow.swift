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
            contentRect: NSRect(x: 0, y: 0, width: 0, height: 0),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered,
            defer: false)
//        let mainContentView = NSView(frame: NSRect(origin: .zero,
//                                               size: CGSize(width: 400,
//                                                            height: 400)))
//        mainContentView.widthAnchor.constraint(equalToConstant: 500).isActive = true
//        mainContentView.heightAnchor.constraint(equalToConstant: 500).isActive = true
//        mainWindow.contentView = mainContentView

        // Setup blur background
//        let visualEffect = NSVisualEffectView()
//        visualEffect.blendingMode = .behindWindow
//        visualEffect.state = .active
//        visualEffect.material = .underWindowBackground
////        mainWindow.contentView?.addSubview(visualEffect)
//        mainWindow.contentView = visualEffect

        mainWindow.titlebarAppearsTransparent = true
        mainWindow.styleMask.insert(.fullSizeContentView)

        // Create the SwiftUI view and set the context as the value for the managedObjectContext environment keyPath.
        // Add `@Environment(\.managedObjectContext)` in the views that will need the context.
        let contentView = MainView()
            .environment(\.managedObjectContext,
                         App.instance.persistence.persistentContainer.viewContext)
        let mainView = NSHostingView(rootView: contentView)
        mainWindow.contentView = mainView
//        mainWindow.contentView?.addSubview(mainView)
//        mainContentView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
//        mainContentView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
//        mainContentView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
//        mainContentView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true

        // Set properties
        //mainWindow.center()
        mainWindow.isMovableByWindowBackground = true
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
