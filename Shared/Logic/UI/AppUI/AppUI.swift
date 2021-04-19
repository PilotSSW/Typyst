//
//  AppUI.swift
//  Typyst
//
//  Created by Sean Wolford on 2/1/20.
//  Copyright © 2020 wickedPropeller. All rights reserved.
//

#if os(macOS)
import AppKit
import Cocoa
#endif
import Foundation

class AppUI {
    #if os(macOS)
    var alerts = Alerts()
    var appMenu: AppMenu?
    var appWindow: AppWindow?
    #endif

    init() {

    }

    #if os(macOS)
    func setup() {
        setupDockIcon()
        setupMenu()
        setupMainWindow()
    }

    private func setupDockIcon() {
//        AppDelegate.runAsMenubarApp(AppSettings.shared.runAsMenubarApp)
//        AppSettings.shared.$runAsMenubarApp
//            .sink { AppDelegate.runAsMenubarApp(!$0) }
//            .store(in: &AppCore.instance.subscriptions)

        AppCore.instance.logging.log(.trace, "Dock Icon setup")
    }

    private func setupMenu() {
        appMenu = AppMenu()
        appMenu?.constructMenu()
        appMenu?.attachToOSMenuBar()

        AppCore.instance.logging.log(.trace, "Menu setup")
    }

    private func setupMainWindow() {
        appWindow = AppWindow()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            if AppSettings.shared.showMainWindow {
                AppCore.instance.ui.appWindow?.showWindow()
            }
            AppCore.instance.logging.log(.trace, "Main window setup")
        })
    }
    #endif
}
