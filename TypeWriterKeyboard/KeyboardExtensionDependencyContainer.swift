//
//  KeyboardExtensionDependencyContainer.swift
//  TypeWriterKeyboard
//
//  Created by Sean Wolford on 6/27/21.
//

import Foundation

class KeyboardExtensionDependencyContainer {
    fileprivate static var keyboardExtensionDependencyContainer = KeyboardExtensionDependencyContainer(withRootDependencyContainer: RootDependencyContainer.get())

    private(set) var rootDependencyContainer: RootDependencyContainer
    private(set) var keyboardExtensionService: KeyboardExtensionService

    private init(withRootDependencyContainer rootContainer: RootDependencyContainer) {
        rootDependencyContainer = rootContainer

        keyboardExtensionService = KeyboardExtensionService()
    }

    static func get() -> KeyboardExtensionDependencyContainer { keyboardExtensionDependencyContainer }
}
