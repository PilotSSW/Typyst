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
        logEvent(.trace, "Creating a text layout")
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
        textContainer.widthTracksTextView = true
        textContainer.heightTracksTextView = true
        
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
            logEvent(.info, "TextContainer not found in layout manager", context: [textContainer, layoutManager])
            return false
        }
    }
    
    /// MARK: TextView Functions
    public func createAndAddNewTextView(withFrame frame: NSRect = NSRect(origin: .zero, size: NSSize(width: 300, height: 300))) -> NSTextView {
        let textContainer = createAndAddNewTextContainer(withSize: frame.size)
        let textView = NSTextView(frame: frame, textContainer: textContainer)
        textView.textColor = NSColor(cgColor: AppColor.textBody.cgColor ?? .black)
        
        textView.delegate = self
        textView.font = defaultFont
        
        textViews.append(textView)
        
        logEvent(.trace, "Created new text view with frame: \(frame)", context: [textContainer, textView])
        
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
    
    private var defaultContainerSize: NSSize { NSSize(width: 712, height: 996) }
    
    deinit {
        logEvent(.info, "Deallocating MultiPageTextLayout")
    }
}

extension MultiPageTextLayout: NSTextStorageDelegate {
    
}

extension MultiPageTextLayout: NSLayoutManagerDelegate {
    func layoutManagerDidInvalidateLayout(_ sender: NSLayoutManager) {
        logEvent(.info, "LayouManager did invalidate")
    }
    
    func layoutManager(_ layoutManager: NSLayoutManager,
                       didCompleteLayoutFor textContainer: NSTextContainer?,
                       atEnd layoutFinishedFlag: Bool) {
        logEvent(.info, "LayoutManager finished laying out container: atEnd?: \(layoutFinishedFlag)")
        
        if layoutFinishedFlag { return }
        
        var size: NSSize
        if let textContainer = textContainer {
            size = textContainer.size
        }
        else {
            size = defaultContainerSize
        }
        
        let _ = createAndAddNewTextContainer(withSize: size)
    }
}

extension MultiPageTextLayout: NSTextViewDelegate {
    func textDidBeginEditing(_ notification: Notification) {
        //onEditingChanged()
        logEvent(.info, "did begin editting")
    }
    
    func textDidChange(_ notification: Notification) {
        logEvent(.info, "text did change")
        if let textView = notification.object as? NSTextView {
            if let cursorFrame = textView.getCursorPositionInFrame() {
                currentCursorPosition = cursorFrame
            }
        }
    }
    
    func textDidEndEditing(_ notification: Notification) {
        logEvent(.info, "text did end editting")
        //onCommit()
    }
}
