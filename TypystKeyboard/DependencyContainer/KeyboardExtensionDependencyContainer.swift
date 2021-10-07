//
//  KeyboardExtensionDependencyContainer.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 6/27/21.
//

import Foundation

final class KeyboardExtensionDependencyContainer {
    fileprivate static var keyboardExtensionDependencyContainer = KeyboardExtensionDependencyContainer(withRootDependencyContainer: RootDependencyContainer.get())

    private(set) var rootDependencyContainer: RootDependencyContainer
    private(set) var textDocumentProxyService: TextDocumentProxyService
    private(set) var uiKitKeyboardService: IOSUIKitKeyboardService

    private init(withRootDependencyContainer rootContainer: RootDependencyContainer) {
        rootDependencyContainer = rootContainer

        textDocumentProxyService = TextDocumentProxyService()
        uiKitKeyboardService = IOSUIKitKeyboardService(withKeyboardService: rootContainer.keyboardService)
    }

    static func get() -> KeyboardExtensionDependencyContainer {
        if (keyboardExtensionDependencyContainer == nil) {
            Logging.logFatalCrash()
        }

        return keyboardExtensionDependencyContainer
    }
}
