//
//  KeyboardViewController.swift
//  TypeWriterKeyboard
//
//  Created by Sean Wolford on 4/14/21.
//

import GBDeviceInfo
import UIKit

class KeyboardViewController: UIInputViewController {
    /// MARK: Variables
    private var dependencyContainer = KeyboardExtensionDependencyContainer.get()
    private var keyboardService: KeyboardService!
    private var keyboardExtensionService: KeyboardExtensionService!


    /// MARK: Outlets
    @IBOutlet var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        keyboardService = dependencyContainer.rootDependencyContainer.keyboardService
        keyboardExtensionService = dependencyContainer.keyboardExtensionService
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        logEvent(.info, "Keyboard extension view loaded", context: [
            GBDeviceInfo.deviceInfo(),
            GBDeviceInfo().isJailbroken,
        ])
    }
    
    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
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
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
}

// MARK: Keyboard handling
extension KeyboardViewController {
    override func pressesBegan(_ presses: Set<UIPress>,
                               with event: UIPressesEvent?) {
        super.pressesBegan(presses, with: event)
        keyboardExtensionService.handleUIPressesEvent(event, .touchBegan, keyboardService: keyboardService)
    }

    override func pressesEnded(_ presses: Set<UIPress>,
                               with event: UIPressesEvent?) {
        super.pressesEnded(presses, with: event)
        keyboardExtensionService.handleUIPressesEvent(event, .touchEnded, keyboardService: keyboardService)
    }

    override func pressesCancelled(_ presses: Set<UIPress>,
                                   with event: UIPressesEvent?) {
        super.pressesCancelled(presses, with: event)
        keyboardExtensionService.handleUIPressesEvent(event, .touchCancelled, keyboardService: keyboardService)
    }
}

// MARK: Add logging support
extension KeyboardViewController: Loggable {}
