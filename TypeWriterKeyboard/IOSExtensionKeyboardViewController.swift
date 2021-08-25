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

final class IOSExtensionKeyboardViewController: UIInputViewController, Loggable {
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
    private var keyboardContainerViewController: UIHostingController<KeyboardContainerView>? = nil
    private var keyboardContainerViewModel: KeyboardContainerViewModel? = nil
    private var keyboardContainerView: KeyboardContainerView? = nil

    /// MARK: Outlets
    @IBOutlet var nextKeyboardButton: UIButton?
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        #if DEBUG
        dependencyContainer.rootDependencyContainer.appDebugSettings.debugGlobal = true
        dependencyContainer.rootDependencyContainer.appSettings.logErrorsAndCrashes = true
        dependencyContainer.rootDependencyContainer.appSettings.volumeSetting = 100
        #else
        dependencyContainer.rootDependencyContainer.appDebugSettings.debugGlobal = false
        #endif
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            guard let self = self else { return }
            self.hookupKeyboard()
        })

        NSSetUncaughtExceptionHandler { (exception) in
            SwiftyBeaverLogger.logFatalCrash(exception)
        }
    }

    override func viewWillLayoutSubviews() {
        if let nextKeyboardButton = nextKeyboardButton { nextKeyboardButton.isHidden = !needsInputModeSwitchKey }
        super.viewWillLayoutSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadKeyboard()
    }

    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboard()
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        logEvent(.warning, "Did receive memory warning", context: [self])
    }

    deinit {
        keyboardContainerViewModel = nil
        keyboardService.removeListenerCallback(withTag: IOSExtensionKeyboardViewController.keyboardServiceTag)
    }
}

// MARK: Keyboard text functions
extension IOSExtensionKeyboardViewController {
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

// MARK: Business logic setup
extension IOSExtensionKeyboardViewController {
    private func hookupKeyboard() {
        // Perform custom UI setup here
        setupView()

        typeWriterService.$loadedTypewriter
            .sink { [weak self] model in
                if let self = self {
                    self.reloadKeyboard()
                }
            }
            .store(in: &subscriptions)

        keyboardService.registerKeyPressCallback(withTag: IOSExtensionKeyboardViewController.keyboardServiceTag) { [weak self, weak keyboardContainerViewModel] keyEvent in
            guard let self = self,
                  let keyboardContainerViewModel = keyboardContainerViewModel
            else { return }

            let model = keyboardContainerViewModel.keyboardModel
            let mode = model.mode
            let lettersMode = model.lettersMode
            
            if (keyEvent.key == .nextKeyboardGlobe) {
                self.nextKeyboardButton?.sendActions(for: .touchUpInside)
            }
            else {
                self.textDocumentProxyService.handleKeyPress(keyEvent,
                                                             keyboardMode: mode,
                                                             lettersMode: lettersMode,
                                                             textDocumentProxy: self.textDocumentProxy)
            }
        }

        logEvent(.info, "Keyboard extension view loaded", context: [GBDeviceInfo.deviceInfo()])
    }
}

// MARK: UI setup
extension IOSExtensionKeyboardViewController {
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
            nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        }
    }

    private func addKeyboard() {
        if keyboardContainerViewModel == nil {
            keyboardContainerViewModel = KeyboardContainerViewModel(
                typeWriterService: typeWriterService,
                keyboardRequiresNextKeyboardButton: needsInputModeSwitchKey,
                keyboardModelActionsDelegate: self
            )
        }

        if let keyboardContainerViewModel = keyboardContainerViewModel {
            let containerView = KeyboardContainerView(viewModel: keyboardContainerViewModel)
            keyboardContainerView = containerView

            if let keyboardView = keyboardContainerView {
                keyboardContainerViewController = UIHostingController(rootView: keyboardView)
                keyboardContainerViewController?.view.backgroundColor = .clear
                if let keyboardViewController = keyboardContainerViewController {
                    addAndContainChildVC(keyboardViewController)
                    keyboardViewController.view.translatesAutoresizingMaskIntoConstraints = false
                    keyboardViewController.view.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
                    keyboardViewController.view.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
                    keyboardViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
                    keyboardViewController.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
                }
            }
        }
    }

    private func removeKeyboard() {
        keyboardContainerView = nil
        keyboardContainerViewController?.view.subviews.forEach({ $0.removeFromSuperview() })
        keyboardContainerViewController?.children.forEach({ $0.removeFromParent() })
        keyboardContainerViewController?.removeFromParent()
        keyboardContainerViewController = nil
    }

    private func reloadKeyboard() {
        logEvent(.debug, "Reloading keyboard")
        removeKeyboard()
        addKeyboard()
    }
}

// MARK: Add support for listening to view model for key-presses
extension IOSExtensionKeyboardViewController: KeyboardModelActionsDelegate {
    func keyWasPressed(_ event: KeyEvent) {
        keyboardService.handleEvent(event)
    }
}

// MARK: Keyboard handling
extension IOSExtensionKeyboardViewController {
    override func pressesBegan(_ presses: Set<UIPress>,
                               with event: UIPressesEvent?) {
        super.pressesBegan(presses, with: event)
        //keyboardExtensionService.handleUIPressesEvent(event, .touchBegan, keyboardService: keyboardService)
    }

    override func pressesEnded(_ presses: Set<UIPress>,
                               with event: UIPressesEvent?) {
        super.pressesEnded(presses, with: event)
        //keyboardExtensionService.handleUIPressesEvent(event, .touchEnded, keyboardService: keyboardService)
    }

    override func pressesCancelled(_ presses: Set<UIPress>,
                                   with event: UIPressesEvent?) {
        super.pressesCancelled(presses, with: event)
        //keyboardExtensionService.handleUIPressesEvent(event, .touchCancelled, keyboardService: keyboardService)
    }
}
