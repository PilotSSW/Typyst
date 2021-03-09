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
        olympiaSM3,
        royalModelP,
        smithCoronaSilent,
        NSMenuItem.separator()
    ]}

    private lazy var sectionHeader: NSMenuItem = {
        let section = NSMenuItem(title: "Choose a TypeWriter", action: nil, keyEquivalent: "")
        section.isEnabled = false
        section.tag = 2
        return section
    }()

    private lazy var smithCoronaSilent: NSMenuItem = {
        let coronaSilentRow = NSMenuItem(title: "Smith Corona Silent", action: #selector(AppMenu.loadSmithCoronaSilent(_:)), keyEquivalent: "S")
        registerMenuUpdateOnTypeWriterChange(coronaSilentRow, model: .Smith_Corona_Silent)
        coronaSilentRow.state = App.instance.core.loadedTypewriter?.model == .Smith_Corona_Silent ? .on : .off
        return coronaSilentRow
    }()

    private lazy var olympiaSM3: NSMenuItem = {
        let olympiaRow = NSMenuItem(title: "Olympia SM3", action: #selector(AppMenu.loadOlympiaSM3(_:)), keyEquivalent: "O")
        registerMenuUpdateOnTypeWriterChange(olympiaRow, model: .Olympia_SM3)
        olympiaRow.state = App.instance.core.loadedTypewriter?.model == .Olympia_SM3 ? .on : .off
        return olympiaRow
    }()

    private lazy var royalModelP: NSMenuItem = {
        let royalModelPRow = NSMenuItem(title: "Royal Model P", action: #selector(AppMenu.loadRoyalModelP(_:)), keyEquivalent: "P")
        registerMenuUpdateOnTypeWriterChange(royalModelPRow, model: .Royal_Model_P)
        royalModelPRow.state = App.instance.core.loadedTypewriter?.model == .Royal_Model_P ? .on : .off
        return royalModelPRow
    }()

    private func registerMenuUpdateOnTypeWriterChange(_ nsMenuItem: NSMenuItem, model: TypeWriter.Model) {
        App.instance.core.registerActionOnTypeWriterChange({ typeWriter in
            self.updateMenuOption(nsMenuItem, menuModel: model, chosenModel: typeWriter?.model)
        })
    }

    private func updateMenuOption(_ sender: Any?, menuModel: TypeWriter.Model, chosenModel: TypeWriter.Model?) {
        (sender as? NSMenuItem)?.state = menuModel == chosenModel ? .on : .off
    }
}

// TypeWriter Menu Items
extension AppMenu {
    @objc func loadOlympiaSM3(_ sender: Any?) {
        App.instance.core.setCurrentTypeWriter(model: TypeWriter.Model.Olympia_SM3)
    }

    @objc func loadRoyalModelP(_ sender: Any?) {
        App.instance.core.setCurrentTypeWriter(model: TypeWriter.Model.Royal_Model_P)
    }

    @objc func loadSmithCoronaSilent(_ sender: Any?) {
        App.instance.core.setCurrentTypeWriter(model: TypeWriter.Model.Smith_Corona_Silent)
    }
}
