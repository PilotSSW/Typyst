//
//  ConfigurableTextFieldViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 10/21/21.
//

import Foundation

#if os(macOS)
import AppKit

class ConfigurableTextFieldViewModel: NSObject, ObservableObject, Loggable {
    var onEditingChange: (Bool) -> Void = { _ in }
    var onCommit: () -> Void = {}
    
    var introspectTextField: (NSTextField) -> Void = { textField in
        print("Shit")
    }
    
    var introspectTextView: (NSTextView) -> Void = { textField in }

    override init() {
        super.init()
        introspectViews()
    }
    
    private func introspectViews() {
        self.introspectTextField = { [weak self] textField in
            guard let self = self else { return }
            textField.delegate = self
            textField.allowsDefaultTighteningForTruncation = true
            textField.drawsBackground = false
            textField.isAutomaticTextCompletionEnabled = false
            textField.isBezeled = false
            textField.isBordered = false
            self.logEvent(.info, "", context: textField.formatter)
            if let editor = textField.currentEditor() {
                editor.drawsBackground = false
                editor.isHorizontallyResizable = false
                editor.isVerticallyResizable = false
                let cursorPosition = editor.selectedRange.location
                self.logEvent(.error, "Cursor: \(cursorPosition)")
            }
        }
        self.introspectTextView = { [weak self] textField in
            guard let self = self else { return }
            self.logEvent(.error, "Cursor: \(textField.selectedRange().location)")
        }
        logEvent(.info, "Should introspect!!!!")
    }
}

extension ConfigurableTextFieldViewModel: NSTextFieldDelegate {
    func textField(_ textField: NSTextField,
                   textView: NSTextView,
                   candidates: [NSTextCheckingResult],
                   forSelectedRange selectedRange: NSRange) -> [NSTextCheckingResult] {
        print(textField)
        print(textView)
        
        return candidates
    }
    
    func textField(_ textField: NSTextField,
                   textView: NSTextView,
                   candidatesForSelectedRange selectedRange: NSRange) -> [Any]? {
        print(textField)
        print(textView)
        
        return nil
    }
    
    func textField(_ textField: NSTextField,
                   textView: NSTextView,
                   shouldSelectCandidateAt index: Int) -> Bool {
        print(textField)
        print(textView)
        
        return true
    }
}
#endif


#if os(iOS)
import UIKit

class ConfigurableTextFieldViewModel: NSObject, ObservableObject, Loggable {
    var onEditingChange: (Bool) -> Void = { _ in }
    var onCommit: () -> Void = {}
    
    var introspectTextView: (UITextField) -> Void = { textField in }
    
    init() {
        introspectViews()
    }
    
    private func introspectViews() {
        introspectTextView = { [weak self] textField in
            guard let self = self else { return }
            textField.delegate = self
            textField.allowsDefaultTighteningForTruncation = true
            textField.drawsBackground = false
            textField.isAutomaticTextCompletionEnabled = false
            textField.isBezeled = false
            textField.isBordered = false
            self.logEvent(.info, "", context: textField.formatter)
        }
        introspectTextView = { textField in
            
        }
    }
}
#endif
