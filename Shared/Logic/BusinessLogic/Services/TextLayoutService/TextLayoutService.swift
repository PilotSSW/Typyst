//
// Created by Sean Wolford on 11/2/21.
//

import Combine
import Foundation

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

class TextLayoutService {
    func createMultiPageLayoutForDocument(_ document: Document) -> MultiPageTextLayout {
        let sentences = [
            "This is a sentence!!",
            "This is another sentence!",
            "This is a huge fucking paragraph of text that should be split into several sentences for better grammar and punctuation, because runon sentences are hard to read and understand and often lead to points that lack clarity and flow to the readers who really want to enjoy the body of text."
        ]//document.textBody.components(separatedBy: ".?")
        return MultiPageTextLayout(with: sentences)
    }
}

protocol TextLayout: NSObject, NSTextStorageDelegate, NSLayoutManagerDelegate, NSTextViewDelegate, Loggable {
    var storage: NSTextStorage {get set}
    var layoutManager: NSLayoutManager {get set}
    var textContainers: [NSTextContainer] {get set}
    var textViews: [NSTextView] {get set}
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
        
    }
    
    /// MARK: Storage Functions
    public func initializeStorageWithText(_ sentences: [String]) {
        storage.delegate = self

        sentences.forEach({
            let attributedString = NSAttributedString(string: $0)
            storage.append(attributedString)
        })
        
        storage.font = defaultFont
    }
    
    ///MARK: LayoutManager Functions
    public func initializeLayoutManagers() {
        layoutManager.delegate = self
        storage.addLayoutManager(layoutManager)
    }
    
    /// MARK: TextContainer Functions
    public func createAndAddNewTextContainer(withSize size: NSSize = NSSize(width: 300, height: 300)) -> NSTextContainer {
        let textContainer = NSTextContainer(containerSize: size)
        textContainer.widthTracksTextView = true
        textContainer.heightTracksTextView = true
        layoutManager.addTextContainer(textContainer)
        textContainers.append(textContainer)
        return textContainer
    }
    
    public func removeTextContainer(_ textContainer: NSTextContainer) -> Bool {
        if let index = layoutManager.textContainers.firstIndex(of: textContainer) {
            layoutManager.removeTextContainer(at: index)
            textContainers.remove(at: index)
            return true
        }
        else {
            logEvent(.info, "TextContainer not found in layout manager")
            return false
        }
    }
    
    /// MARK: TextView Functions
    public func createAndAddNewTextView(withFrame frame: NSRect = NSRect(origin: .zero, size: NSSize(width: 300, height: 300))) -> NSTextView {
        let textContainer = createAndAddNewTextContainer(withSize: frame.size)
        let textView = NSTextView(frame: frame, textContainer: textContainer)
        
        textView.delegate = self
        textView.font = defaultFont
        
        textViews.append(textView)
        
        return textView
    }
    
    public func removeTextView(_ textView: NSTextView) -> Bool {
        if let index = textViews.firstIndex(of: textView) {
            textViews.remove(at: index)
            
            if let container = textView.textContainer {
                return removeTextContainer(container)
            }
            else {
                return true
            }
        }
        else {
            logEvent(.info, "TextViews not removed")
            return false
        }
    }
}

class MultiPageTextLayout: NSObject, TextLayout, Loggable {
    var storage: NSTextStorage = NSTextStorage()
    var layoutManager: NSLayoutManager = NSLayoutManager()
    var textContainers: [NSTextContainer] = []
    var textViews: [NSTextView] = []
        
    @Published var currentCursorPosition: CGRect? = nil
//    var onEditingChanged       : [() -> Void] = []
//    var onCommit               : [() -> Void] = []
//    var onTextChange           : [(String) -> Void] = []
    
    deinit {
        print("Deallocating MultiPageTextLayout")
    }
}

extension MultiPageTextLayout: NSTextStorageDelegate {
    
}

extension MultiPageTextLayout: NSLayoutManagerDelegate {
    
}

extension MultiPageTextLayout: NSTextViewDelegate {
    func textDidBeginEditing(_ notification: Notification) {
        //onEditingChanged()
        print("did begin editting")
    }
    
    func textDidChange(_ notification: Notification) {
        print("text did change")
        if let textView = notification.object as? NSTextView {
            if let cursorFrame = textView.getCursorPositionInFrame() {
                currentCursorPosition = cursorFrame
            }
        }
    }
    
    func textDidEndEditing(_ notification: Notification) {
        print("text did end editting")
        //onCommit()
    }
}
