//
//  KeyboardExtensionDependencyContainer.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 6/27/21.
//

import Foundation

class KeyboardExtensionDependencyContainer {
    fileprivate static var keyboardExtensionDependencyContainer = KeyboardExtensionDependencyContainer(withRootDependencyContainer: RootDependencyContainer.get())

    private(set) var rootDependencyContainer: RootDependencyContainer
    private(set) var textDocumentProxyService: TextDocumentProxyService

    private init(withRootDependencyContainer rootContainer: RootDependencyContainer) {
        rootDependencyContainer = rootContainer

        textDocumentProxyService = TextDocumentProxyService()
    }

    static func get() -> KeyboardExtensionDependencyContainer { keyboardExtensionDependencyContainer }
}
