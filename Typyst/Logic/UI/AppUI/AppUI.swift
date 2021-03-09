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
        setupMenu()
        setupMainWindow()
    }

    private func setupMenu() {
        appMenu = AppMenu()
        appMenu?.constructMenu()
        appMenu?.attachToOSMenuBar()
    }

    private func setupMainWindow() {
        appWindow = AppWindow()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            if AppSettings.shared.showMainWindow {
                App.instance.ui.appWindow?.showWindow()
            }
        })
    }
}
