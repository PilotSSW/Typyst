//
//  TextLayout.swift
//  Typyst
//
//  Created by Sean Wolford on 11/11/21.
//

import Combine
import Foundation

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

protocol TextLayout: NSObject, NSTextStorageDelegate, NSLayoutManagerDelegate, NSTextViewDelegate, Loggable {
    var storage: NSTextStorage {get set}
    var layoutManager: NSLayoutManager {get set}
    var textContainers: [NSTextContainer] {get set}
    var textViews: [NSTextView] {get set}
    
    var cursorPositionInCurrentTextView: CGPoint? {get}
}

extension TextLayout {
    var defaultFont: NSFont {
        NSFont(name: "AmericanTypewriter",
               size: TextSize.large.cgFloatSize)
        ?? .systemFont(ofSize: TextSize.normal.cgFloatSize)
    }
    
    init(with sentences: [String]) {
        self.init()
        initializeStorageWithText(sentences)
        initializeLayoutManagers()
        logEvent(.trace, "Creating a text layout")
        
//        var counter = 0
//        let timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { [weak self] timer in
//            self?.storage.append(NSAttributedString(string: "Hello\n\n\n"))
//            
//            counter += 1
//            if (counter == 100) {
//                timer.invalidate()
//            }
//        })
    }
    
        /// MARK: Storage Functions
    public func initializeStorageWithText(_ sentences: [String]) {
        storage.delegate = self
        
        sentences.forEach({
            let attributedString = NSAttributedString(string: $0)
            storage.append(attributedString)
        })
        
        storage.font = defaultFont
        logEvent(.trace, "Creating a text storage", context: sentences)
    }
    
        ///MARK: LayoutManager Functions
    public func initializeLayoutManagers() {
        layoutManager.delegate = self
        storage.addLayoutManager(layoutManager)
        
        logEvent(.trace, "Created new layout manager", context: [storage, layoutManager])
    }
    
        /// MARK: TextContainer Functions
    public func createAndAddNewTextContainer(withSize size: NSSize = NSSize(width: 300, height: 300)) -> NSTextContainer {
        let textContainer = NSTextContainer(containerSize: size)
        configureTextContainer(textContainer)
        
        textContainers.append(textContainer)
        layoutManager.addTextContainer(textContainer)
        
        logEvent(.trace, "Created new text container with size: \(size)", context: [textContainer, layoutManager])
        
        return textContainer
    }
    
    public func removeTextContainer(_ textContainer: NSTextContainer) -> Bool {
        if let index = layoutManager.textContainers.firstIndex(of: textContainer) {
            layoutManager.removeTextContainer(at: index)
            textContainers.remove(at: index)
            
            logEvent(.trace, "TextContainer removed from layout", context: [textContainer])
            
            return true
        }
        else {
            logEvent(.warning, "TextContainer not found in layout manager", context: [textContainer, layoutManager])
            return false
        }
    }
    
        /// MARK: TextView Functions
    public func createAndAddNewTextView(withFrame frame: NSRect = NSRect(origin: .zero, size: NSSize(width: 300, height: 300)),
                                        andTextContainer existingTextContainer: NSTextContainer? = nil
    ) -> NSTextView {
        let textContainer: NSTextContainer = existingTextContainer ?? createAndAddNewTextContainer(withSize: frame.size)
        let textView = NSTextView(frame: frame, textContainer: textContainer)
        configureTextView(textView)
        
        textViews.append(textView)
        
        logEvent(.trace, "Created new text view with frame: \(frame)", context: [textContainer, textView])
        
        return textView
    }
    
    public func removeTextView(_ textView: NSTextView, removeContainer: Bool = false) -> Bool {
        if let index = textViews.firstIndex(of: textView) {
            textViews.remove(at: index)
            
            if removeContainer, let container = textView.textContainer {
                return removeTextContainer(container)
            }
            else {
                return true
            }
        }
        else {
            logEvent(.warning, "TextViews not removed", context: [textView, layoutManager])
            return false
        }
    }
}


/// MARK: Text configuration functions
extension TextLayout {
    private func configureTextContainer(_ textContainer: NSTextContainer) {
        textContainer.widthTracksTextView = true
        textContainer.heightTracksTextView = true
        
        textContainer.lineBreakMode = .byCharWrapping
    }
    
    private func configureTextView(_ textView: NSTextView) {
        textView.delegate = self
        textView.font = defaultFont
        
        textView.isRulerVisible = false
        textView.drawsBackground = true
        textView.backgroundColor = NSColor(displayP3Red: 0.5, green: 0.5, blue: 0.5, alpha: 0.25)
        textView.textColor = NSColor(cgColor: AppColor.textBody.cgColor ?? .black)
        
        textView.autoresizingMask = [.height, .width]
        textView.isVerticallyResizable = false
        textView.isHorizontallyResizable = false
        
        textView.isEditable = true
        textView.isSelectable = true
        textView.isHidden = false
        textView.isFieldEditor = false
        textView.isRichText = false
    }
}
