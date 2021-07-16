//
//  KeyboardViewController.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 4/14/21.
//

import GBDeviceInfo
import SwiftUI
import UIKit

class KeyboardViewController: UIInputViewController, Loggable {
    private static var keyboardServiceTag: String = "keyboardExtension"

    /// MARK: Variables
    private var dependencyContainer = RootDependencyContainer.get()
    private var keyboardService: KeyboardService {
        dependencyContainer.keyboardService
    }
    //private var keyboardExtensionService: KeyboardExtensionService!
    private var keyboardViewController: UIHostingController<KeyboardView>? = nil
    private var keyboardViewModel: KeyboardViewModel = KeyboardViewModelFactory.createKeyboardViewModel()

    /// MARK: Outlets
    @IBOutlet var nextKeyboardButton: UIButton?
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
        setupView()

        keyboardViewModel.delegate = self

        keyboardService.registerKeyPressCallback(withTag: KeyboardViewController.keyboardServiceTag) { [weak self] keyEvent in
            guard let self = self else { return }
            self.handleKeyboardServiceInput(keyEvent)
        }

        logEvent(.info, "Keyboard extension view loaded", context: [GBDeviceInfo.deviceInfo()])
    }

    override func viewWillLayoutSubviews() {
        if let nextKeyboardButton = nextKeyboardButton { nextKeyboardButton.isHidden = !needsInputModeSwitchKey }
        super.viewWillLayoutSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboard()
    }

    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboard()
        super.viewWillDisappear(animated)
    }

    deinit {
        keyboardService.removeListenerCallback(withTag: KeyboardViewController.keyboardServiceTag)
    }
}

// MARK: Keyboard text functions
extension KeyboardViewController {
    private func handleKeyboardServiceInput(_ keyEvent: KeyEvent) {
        let key = keyEvent.key
        if [.capsLock, .shift, .rightShift].contains(key) {
            return
        } else if [.delete].contains(key) {
            textDocumentProxy.deleteBackward()
        } else if [.keypadEnter, .return].contains(key) {
            textDocumentProxy.insertText("\n")
        } else if keyboardViewModel.state == .letters {
            let isUppercased = keyEvent.modifiers.contains(.shift) || keyEvent.modifiers.contains(.capsLock)
            let text = isUppercased
                ? key.stringValue.uppercased()
                : key.stringValue.lowercased()
            textDocumentProxy.insertText(text)
        }
    }

    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.

        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        nextKeyboardButton?.setTitleColor(textColor, for: [])
    }
}

// MARK: UI setup
extension KeyboardViewController {
    private func setupView() {
        view.subviews.forEach({ view in
            view.removeFromSuperview()
        })

        view.backgroundColor = .clear

        if (needsInputModeSwitchKey) { addNextKeyboardButton() }
    }

    private func addNextKeyboardButton() {
        nextKeyboardButton = UIButton(type: .system)
        if let nextKeyboardButton = nextKeyboardButton {
            nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
            nextKeyboardButton.sizeToFit()
            nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
            nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)

            view.addSubview(nextKeyboardButton)
            nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        }
    }

    private func addKeyboard() {
        let keyboardView = KeyboardView(viewModel: keyboardViewModel)
        keyboardViewController = UIHostingController(rootView: keyboardView)
        if let keyboardViewController = keyboardViewController {
            addAndContainChildVC(keyboardViewController)
            keyboardViewController.view.translatesAutoresizingMaskIntoConstraints = false
            keyboardViewController.view.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
            keyboardViewController.view.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
            keyboardViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
            keyboardViewController.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }

    private func removeKeyboard() {
        keyboardViewController?.removeFromParent()
        keyboardViewController = nil
    }
}

// MARK: Add support for listening to view model for key-presses
extension KeyboardViewController: KeyboardViewModelActionsDelegate {
    func keyWasPressed(_ event: KeyEvent) {
        keyboardService.handleEvent(event, { [weak self] event in
            guard let self = self else { return }
            self.logEvent(.debug, "KeyboardViewController - keyWasPressedCompletion", context: [event.asAnonymousKeyEvent()])
        })
    }
}

// MARK: Keyboard handling
//extension KeyboardViewController {
//    override func pressesBegan(_ presses: Set<UIPress>,
//                               with event: UIPressesEvent?) {
//        super.pressesBegan(presses, with: event)
//        keyboardExtensionService.handleUIPressesEvent(event, .touchBegan, keyboardService: keyboardService)
//    }
//
//    override func pressesEnded(_ presses: Set<UIPress>,
//                               with event: UIPressesEvent?) {
//        super.pressesEnded(presses, with: event)
//        keyboardExtensionService.handleUIPressesEvent(event, .touchEnded, keyboardService: keyboardService)
//    }
//
//    override func pressesCancelled(_ presses: Set<UIPress>,
//                                   with event: UIPressesEvent?) {
//        super.pressesCancelled(presses, with: event)
//        keyboardExtensionService.handleUIPressesEvent(event, .touchCancelled, keyboardService: keyboardService)
//    }
//}
