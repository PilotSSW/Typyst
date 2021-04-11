//
//  AppUI.swift
//  Typyst
//
//  Created by Sean Wolford on 2/1/20.
//  Copyright © 2020 wickedPropeller. All rights reserved.
//

import AppKit
import Cocoa
import Foundation

class AppUI {
    var alerts = Alerts()
    var appMenu: AppMenu?
    var appWindow: AppWindow?

    init() {

    }

    func setup() {
        setupDockIcon()
        setupMenu()
        setupMainWindow()
    }

    private func setupDockIcon() {
        AppDelegate.runAsMenubarApp(AppSettings.shared.runAsMenubarApp)
        AppSettings.shared.$runAsMenubarApp
            .sink { AppDelegate.runAsMenubarApp(!$0) }
            .store(in: &App.instance.subscriptions)

        App.instance.logging.log(.trace, "Dock Icon setup")
    }

    private func setupMenu() {
        appMenu = AppMenu()
        appMenu?.constructMenu()
        appMenu?.attachToOSMenuBar()

        App.instance.logging.log(.trace, "Menu setup")
    }

    private func setupMainWindow() {
        appWindow = AppWindow()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            if AppSettings.shared.showMainWindow {
                App.instance.ui.appWindow?.showWindow()
            }
            App.instance.logging.log(.trace, "Main window setup")
        })
    }
}
