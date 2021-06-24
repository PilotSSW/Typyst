////
//// Created by Sean Wolford on 2/15/21.
//// Copyright (c) 2021 wickedPropeller. All rights reserved.
////
//
//import AppKit
//import Foundation
//
//class MenuItemsAppSettings {
//
//    var items: [NSMenuItem] {[
//        sectionHeader,
////        showMainWindow,
//        modalNotifications,
//        reportErrors,
//        NSMenuItem.separator()
//    ]}
//
//    lazy var sectionHeader: NSMenuItem = {
//        let section = NSMenuItem(title: "App Settings", action: nil, keyEquivalent: "")
//        section.isEnabled = false
//        section.tag = 2
//        return section
//    }()
//
//    lazy var modalNotifications: NSMenuItem = {
//        let menuItemMN = NSMenuItem(title: "Show modal notifications", action: #selector(AppMenu.setShowModalNotifications(_:)), keyEquivalent: "3")
//        menuItemMN.state = AppDependencyContainer.get().appSettings.showModalNotifications ? .on : .off
//        AppDependencyContainer.get().appSettings.$showModalNotifications
//            .sink { menuItemMN.state = $0 ? .on : .off }
//            .store(in: &AppCore.instance.subscriptions)
//        return menuItemMN
//    }()
//
//    lazy var reportErrors: NSMenuItem = {
//        let menuItemFirebase = NSMenuItem(title: "Share errors and crashes with developer", action: #selector(AppMenu.setLogErrorsAndCrashes(_:)), keyEquivalent: "0")
//        menuItemFirebase.state = AppDependencyContainer.get().appSettings.logUsageAnalytics ? .on : .off
//        AppDependencyContainer.get().appSettings.$logErrorsAndCrashes
//            .sink { menuItemFirebase.state = $0 ? .on : .off }
//            .store(in: &AppCore.instance.subscriptions)
//        return menuItemFirebase
//    }()
//
////    lazy var showMainWindow: NSMenuItem = {
////        let menuItemMainWindow = NSMenuItem(title: "Show main window", action: #selector(AppMenu.showMainWindow(_:)), keyEquivalent: "1")
////        menuItemMainWindow.state = AppDependencyContainer.get().appSettings.showMainWindow ? .on : .off
////        AppDependencyContainer.get().appSettings.$showMainWindow
////            .sink { menuItemMainWindow.state = $0 ? .on : .off }
////            .store(in: &AppCore.instance.subscriptions)
////        return menuItemMainWindow
////    }()
//}
//
//// App Settings Menu Items
//extension AppMenu {
//    @objc func setLogErrorsAndCrashes(_ sender: Any?) {
//        let enabled = !AppDependencyContainer.get().appSettings.logErrorsAndCrashes
//        (sender as? NSMenuItem)?.state = enabled ? .on : .off
//        AppDependencyContainer.get().appSettings.logErrorsAndCrashes = enabled
//    }
//
//    @objc func setShowModalNotifications(_ sender: Any?) {
//        let enabled = !AppDependencyContainer.get().appSettings.showModalNotifications
//        (sender as? NSMenuItem)?.state = enabled ? .on : .off
//        AppDependencyContainer.get().appSettings.showModalNotifications = enabled
//    }
//
////    @objc func showMainWindow(_ sender: Any?) {
////        AppDependencyContainer.get().appSettings.showMainWindow = !AppDependencyContainer.get().appSettings.showMainWindow
////        (sender as? NSMenuItem)?.state = AppDependencyContainer.get().appSettings.showMainWindow ? .on : .off
////
////        if AppDependencyContainer.get().appSettings.showMainWindow {
////            AppCore.instance.ui.appWindow?.showWindow()
////        }
////        else {
////            AppCore.instance.ui.appWindow?.closeWindow()
////        }
////    }
//}
