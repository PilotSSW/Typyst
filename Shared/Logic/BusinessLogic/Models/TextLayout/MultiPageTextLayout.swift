//
//  MultiPageTextLayout.swift
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

class MultiPageTextLayout: NSObject, TextLayout, ObservableObject, Loggable {
    var storage: NSTextStorage = NSTextStorage()
    var layoutManager: NSLayoutManager = NSLayoutManager()
    var textContainers: [NSTextContainer] = []
    var textViews: [NSTextView] = []
    
    public let multicastDelegate = MulticastDelegate<MultiPageTextLayoutDelegate>()
    
    @Published var cursorPositionInCurrentTextView: CGPoint? = nil
    
    private var defaultContainerSize: NSSize {
        NSSize(width: CGFloat.greatestFiniteMagnitude,
               height: CGFloat.greatestFiniteMagnitude)
    }
    
    convenience init(
        with sentences: [String],
        shouldAutoAddFirstTextContainer: Bool = true,
        delegate: MultiPageTextLayoutDelegate? = nil
    ) {
        self.init()
        
        if let delegate = delegate {
            addDelegate(delegate)
        }
        
        initializeStorageWithText(sentences)
        initializeLayoutManagers()
        logEvent(.trace, "Creating a MultiPageText layout")
        
        if shouldAutoAddFirstTextContainer {
            let _ = createAndAddNewTextContainer()
        }
    }
    
    deinit {
        logEvent(.debug, "Deallocating MultiPageTextLayout")
    }
    
    func getCursorPositionInTextView(_ textView: NSTextView) -> CGPoint? {
        var currentPoint: CGPoint? = nil
        
        if let cursorFrame = textView.getCursorPositionInFrame() {
            let cursorX = cursorFrame.origin.x
            let cursorY = cursorFrame.origin.y
            let cursorHeight = cursorFrame.height
            
            currentPoint = CGPoint(x: cursorX, y: cursorY + cursorHeight)
        }
        
        return currentPoint
    }
}

///
///
/// MARK: Delegate functions for NSTextEngine
///
///

/// MARK: Storage delegate functions
extension MultiPageTextLayout: NSTextStorageDelegate {
    
}

/// MARK: Layout manager delegate functions
extension MultiPageTextLayout: NSLayoutManagerDelegate {
    func layoutManagerDidInvalidateLayout(_ sender: NSLayoutManager) {
        logEvent(.debug, "LayoutManager did invalidate")
    }
    
    func layoutManager(_ layoutManager: NSLayoutManager,
                       didCompleteLayoutFor textContainer: NSTextContainer?,
                       atEnd layoutFinishedFlag: Bool) {
        let atTextBodyEnd = textContainer == nil
        let shouldAddNewTextContainer = layoutFinishedFlag && atTextBodyEnd
        
        if shouldAddNewTextContainer {
//            var size: CGSize = defaultContainerSize
//            if let last = textViews.last,
//               let container = last.textContainer {
//                size = container.size
//            }

            let container = createAndAddNewTextContainer()
            multicastDelegate.invokeDelegates { $0.newTextContainerAddedToLayout(container) }
        }
        
        logEvent(.debug, "LayoutManager finished laying out container: Request to add new text container and view: \(shouldAddNewTextContainer)")
    }
}

/// MARK: TextView delegate functions
extension MultiPageTextLayout: NSTextViewDelegate {
    func textDidBeginEditing(_ notification: Notification) {
            //onEditingChanged()
        logEvent(.debug, "did begin editting")
    }
    
    func textDidChange(_ notification: Notification) {
        logEvent(.debug, "text did change")
        if let textView = notification.object as? NSTextView {
            cursorPositionUpdated(inTextView: textView)
        }
        multicastDelegate.invokeDelegates { $0.textWasUpdated("") }
    }
    
    func textDidEndEditing(_ notification: Notification) {
        logEvent(.debug, "text did end editting")
            //onCommit()
        multicastDelegate.invokeDelegates { $0.textWasUpdated("") }
    }
}


///
///
/// MARK: Delegate functions for subscribers of MultiTextPageLayout
///
///

/// MARK: Public multicastDelegate functions
extension MultiPageTextLayout {
    func addDelegate(_ delegate: MultiPageTextLayoutDelegate) {
        multicastDelegate.addDelegate(delegate)
    }
    
    func removeDelegate(_ delegate: MultiPageTextLayoutDelegate) {
        multicastDelegate.removeDelegate(delegate)
    }
}


/// MARK: Private function
extension MultiPageTextLayout {
    private func cursorPositionUpdated(inTextView textView: NSTextView) {
        let cursorPosition = getCursorPositionInTextView(textView)
        
        var shouldUpdate = true
        if let currentPoint = cursorPosition, cursorPositionInCurrentTextView?.equalTo(currentPoint) ?? false {
            shouldUpdate = false
        }
        else {
            cursorPositionInCurrentTextView = cursorPosition
        }
        
        if shouldUpdate {
            multicastDelegate.invokeDelegates{ $0.cursorPositionUpdated(cursorPosition) }
            multicastDelegate.invokeDelegates{ $0.cursorPositionUpdated(cursorPosition, in: textView) }

            logEvent(.trace, "Cursor position updated: \(String(describing: cursorPositionInCurrentTextView))")
        }
    }
}

public protocol MultiPageTextLayoutDelegate: AnyObject {
    func cursorPositionUpdated(_ point: CGPoint?)
    func cursorPositionUpdated(_ point: CGPoint?, in textView: NSTextView)
    func newTextContainerAddedToLayout(_ textContainer: NSTextContainer)
    func textWasUpdated(_ text: String)
}

extension MultiPageTextLayoutDelegate {
    func cursorPositionUpdated(_ point: CGPoint?) { }
    func cursorPositionUpdated(_ point: CGPoint?, in textView: NSTextView) { }
    func newTextContainerAddedToLayout(_ textContainer: NSTextContainer) { }
    func textWasUpdated(_ text: String) { }
}
