//
//  KeyboardViewController.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 4/14/21.
//

import Combine
import GBDeviceInfo
import SwiftUI
import UIKit

class KeyboardViewController: UIInputViewController, Loggable {
    private static var keyboardServiceTag: String = "keyboardExtension"
    private var subscriptions = Set<AnyCancellable>()

    /// MARK: Variables
    private var dependencyContainer = KeyboardExtensionDependencyContainer.get()
    private var keyboardService: KeyboardService {
        dependencyContainer.rootDependencyContainer.keyboardService
    }
    private var textDocumentProxyService: TextDocumentProxyService {
        dependencyContainer.textDocumentProxyService
    }
    private var typeWriterService: TypeWriterService {
        dependencyContainer.rootDependencyContainer.typeWriterService
    }
    private var keyboardViewController: UIHostingController<KeyboardView>? = nil
    private var keyboardViewModel: KeyboardViewModel? = nil

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

        let modelType = typeWriterService.loadedTypewriter?.modelType ?? .Royal_Model_P
        keyboardViewModel = KeyboardViewModelFactory.createKeyboardViewModel(forTypeWriterModel: modelType)
        keyboardViewModel?.delegate = self

        keyboardService.registerKeyPressCallback(withTag: KeyboardViewController.keyboardServiceTag) { [weak self] keyEvent in
            guard let self = self,
                  let keyboardViewModel = self.keyboardViewModel
            else { return }

            self.textDocumentProxyService.handleKeyPress(keyEvent,
                                                         keyboardMode: keyboardViewModel.model.state,
                                                         textDocumentProxy: self.textDocumentProxy)
        }

        typeWriterService.$loadedTypewriter
            .sink { [weak self] model in
                if let self = self,
                   let model = model {
                    self.reloadKeyboard(withModelType: model.modelType)
                }
            }
            .store(in: &subscriptions)

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
        if let keyboardViewModel = keyboardViewModel {
            let keyboardView = KeyboardView(viewModel: keyboardViewModel)
            keyboardViewController = UIHostingController(rootView: keyboardView)
            keyboardViewController?.view.backgroundColor = .clear
            if let keyboardViewController = keyboardViewController {
                addAndContainChildVC(keyboardViewController)
                keyboardViewController.view.translatesAutoresizingMaskIntoConstraints = false
                keyboardViewController.view.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
                keyboardViewController.view.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
                keyboardViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
                keyboardViewController.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            }
        }
    }

    private func removeKeyboard() {
        keyboardViewController?.removeFromParent()
        keyboardViewController = nil
    }

    private func reloadKeyboard(withModelType modelType: TypeWriterModel.ModelType) {
        removeKeyboard()
        keyboardViewModel = KeyboardViewModelFactory.createKeyboardViewModel(forTypeWriterModel: modelType)
        keyboardViewModel?.delegate = self
        addKeyboard()
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
