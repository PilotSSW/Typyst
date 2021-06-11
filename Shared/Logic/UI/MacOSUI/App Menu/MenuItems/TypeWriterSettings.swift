////
////  TypeWriterSettings.swift
////  Typyst
////
////  Created by Sean Wolford on 2/15/21.
////  Copyright © 2021 wickedPropeller. All rights reserved.
////
//
//import AppKit
//import Foundation
//
//class MenuItemsTypeWriterSettings {
//
//    var items: [NSMenuItem] {[
//        sectionHeader,
//        paperReturn,
//        paperFeed,
//        NSMenuItem.separator()
//    ]}
//
//    lazy var sectionHeader: NSMenuItem = {
//        let section = NSMenuItem(title: "Typewriter settings", action: nil, keyEquivalent: "")
//        section.isEnabled = false
//        section.tag = 2
//        return section
//    }()
//
//    lazy var paperReturn: NSMenuItem = {
//        let menuItemPR = NSMenuItem(title: "Simulate paper return / new line every 80 characters", action: nil, keyEquivalent: "1")
//        menuItemPR.state = appDependencyContainer.appSettings.paperReturnEnabled ? .on : .off
//        menuItemPR.action = #selector(AppMenu.setPaperReturnEnabled(_:))
//        appDependencyContainer.appSettings.$paperReturnEnabled
//            .sink { menuItemPR.state = $0 ? .on : .off }
//            .store(in: &AppCore.instance.subscriptions)
//        return menuItemPR
//    }()
//
//    lazy var paperFeed: NSMenuItem = {
//        let menuItemPF = NSMenuItem(title: "Simulate paper feed every 25 newlines", action: #selector(AppMenu.setPaperFeedEnabled(_:)), keyEquivalent: "2")
//        menuItemPF.state = appDependencyContainer.appSettings.paperFeedEnabled ? .on : .off
//        appDependencyContainer.appSettings.$paperFeedEnabled
//            .sink { menuItemPF.state = $0 ? .on : .off }
//            .store(in: &AppCore.instance.subscriptions)
//        return menuItemPF
//    }()
//}
//
//// TypeWriter Settings Menu Items
//extension AppMenu {
//    @objc func setPaperFeedEnabled(_ sender: Any?) {
//        let enabled = !appDependencyContainer.appSettings.paperFeedEnabled
//        (sender as? NSMenuItem)?.state = enabled ? .on : .off
//        appDependencyContainer.appSettings.paperFeedEnabled = enabled
//    }
//
//    @objc func setPaperReturnEnabled(_ sender: Any?) {
//        let enabled = !appDependencyContainer.appSettings.paperReturnEnabled
//        (sender as? NSMenuItem)?.state = enabled ? .on : .off
//        appDependencyContainer.appSettings.paperReturnEnabled = enabled
//    }
//}
