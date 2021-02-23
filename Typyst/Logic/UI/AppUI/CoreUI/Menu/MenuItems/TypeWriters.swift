//
// Created by Sean Wolford on 2/15/21.
// Copyright (c) 2021 wickedPropeller. All rights reserved.
//

import AppKit
import Foundation

class MenuItemsTypeWriters {
    /**
     * Typewriter menu options
     */
    var items: [NSMenuItem] {[
        sectionHeader,
        coronaSilent,
        olympiaSM3,
        royalModelP,
        NSMenuItem.separator()
    ]}

    private lazy var sectionHeader: NSMenuItem = {
        let section = NSMenuItem(title: "Choose a TypeWriter", action: nil, keyEquivalent: "")
        section.isEnabled = false
        section.tag = 2
        return section
    }()

    private lazy var coronaSilent: NSMenuItem = {
        let coronaSilentRow = NSMenuItem(title: "Smith Corona Silent", action: #selector(AppMenu.loadSmithCoronaSilent(_:)), keyEquivalent: "S")
        coronaSilentRow.state = App.instance.core.loadedTypewriter?.model == .Smith_Corona_Silent ? .on : .off
        return coronaSilentRow
    }()

    private lazy var olympiaSM3: NSMenuItem = {
        let olympiaRow = NSMenuItem(title: "Olympia SM3", action: #selector(AppMenu.loadOlympiaSM3(_:)), keyEquivalent: "O")
        olympiaRow.state = App.instance.core.loadedTypewriter?.model == .Olympia_SM3 ? .on : .off
        return olympiaRow
    }()

    private lazy var royalModelP: NSMenuItem = {
        let royalModelPRow = NSMenuItem(title: "Royal Model P", action: #selector(AppMenu.loadRoyalModelP(_:)), keyEquivalent: "P")
        royalModelPRow.state = App.instance.core.loadedTypewriter?.model == .Royal_Model_P ? .on : .off
        return royalModelPRow
    }()

    func getItems() {
        var royalItem = royalModelP

        print(royalModelP)
    }
}

// TypeWriter Menu Items
extension AppMenu {
    @objc func loadOlympiaSM3(_ sender: Any?) {
        App.instance.core.setCurrentTypeWriter(model: TypeWriter.Model.Olympia_SM3)
        deselectAllTypewritersInMenu()
        (sender as? NSMenuItem)?.state = .on
    }

    @objc func loadRoyalModelP(_ sender: Any?) {
        App.instance.core.setCurrentTypeWriter(model: TypeWriter.Model.Royal_Model_P)
        deselectAllTypewritersInMenu()
        (sender as? NSMenuItem)?.state = .on
    }

    @objc func loadSmithCoronaSilent(_ sender: Any?) {
        App.instance.core.setCurrentTypeWriter(model: TypeWriter.Model.Smith_Corona_Silent)
        deselectAllTypewritersInMenu()
        (sender as? NSMenuItem)?.state = .on
    }

    private func deselectAllTypewritersInMenu() {
        if let menuItems = App.instance.ui.appMenu?.typeWriterMenuItems.items {
            menuItems.forEach({ $0.state = .off })
        }
    }
}
