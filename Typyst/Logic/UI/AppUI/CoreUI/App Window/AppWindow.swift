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
        // Create the SwiftUI view and set the context as the value for the managedObjectContext environment keyPath.
        // Add `@Environment(\.managedObjectContext)` in the views that will need the context.
        let contentView = MainView()
            .environment(\.managedObjectContext,
                         App.instance.persistence.persistentContainer.viewContext)

        // Create the window and set the content view.
        mainWindow = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 0, height: 0),
                styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                backing: .buffered,
                defer: false)
        mainWindow.center()
        mainWindow.setFrameAutosaveName("Main Window")
        mainWindow.contentView = NSHostingView(rootView: contentView)
        mainWindow.isOpaque = false
        mainWindow.backgroundColor = NSColor.clear.shadow(withLevel: 0.25)
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

struct MainView: View {

    @ViewBuilder
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white.opacity(0.33))
                .blendMode(.exclusion)
                .blur(radius: 24, opaque: false)

            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {
                VStack(alignment: .center) {
                    Spacer(minLength: 6)
                    TypeWriterMenu(options: TypeWriterMenuOptions.typeWriters)
                        .shadow(color: AppColor.objectShadow, radius: 3)
                    Spacer(minLength: 24)
                    SettingsMenu()
                        .shadow(color: AppColor.objectShadow, radius: 3)
                    Spacer(minLength: 6)
                }
            })
            .animation(.easeInOut)
        }
        .frame(minWidth: 320, idealWidth: 400, maxWidth: 1920,
               minHeight: 240, idealHeight: 800, maxHeight: 3840,
               alignment: .center)
    }
}
