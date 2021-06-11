////
////  AppUI.swift
////  Typyst
////
////  Created by Sean Wolford on 2/1/20.
////  Copyright © 2020 wickedPropeller. All rights reserved.
////
//
//import AppKit
//import Cocoa
//import Foundation
//
//class MacOSUI {
//    var appCore: AppCore
//    //var appMenu: AppMenu?
//
//    init(_ appCore: AppCore) {
//        self.appCore = appCore
//
//        if !AppDelegate.isAccessibilityAdded() {
//            SystemFunctions.askUserToAllowSystemAccessibility()
//        }
//    }
//
//    func setup() {
////        setupDockIcon()
//        setupMenu()
//    }
//
//    private func setupDockIcon() {
//        AppDelegate.runAsMenubarApp(appDependencyContainer.appSettings.runAsMenubarApp)
//        appDependencyContainer.appSettings.$runAsMenubarApp
//            .sink { AppDelegate.runAsMenubarApp(!$0) }
//            .store(in: &appCore.subscriptions)
//
//        appCore.logging.log(.trace, "Dock Icon setup")
//    }
//
//    private func setupMenu() {
////        appMenu = AppMenu()
////        appMenu?.constructMenu()
////        appMenu?.attachToOSMenuBar()
//
//        appCore.logging.log(.trace, "Menu setup")
//    }
//
//    @objc func quit(_ sender: Any?) {
//        #if os(macOS)
//        NSApplication.shared.terminate(sender)
//        #endif
//    }
//
//    @objc func emailSupport() {
//        #if os(macOS)
//        let service = NSSharingService(named: NSSharingService.Name.composeEmail)
//        service?.recipients = ["support@typyst.app"]
//        service?.subject = "Oh no! Something in Typyst isn't working correctly"
//        service?.perform(withItems: ["Test Mail body"])
//        NSWorkspace.shared.launchApplication("Mail")
//        #endif
//    }
//}
