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
        //    var onEditingChanged       : [() -> Void] = []
        //    var onCommit               : [() -> Void] = []
        //    var onTextChange           : [(String) -> Void] = []
    
    private var defaultContainerSize: NSSize { NSSize(width: 712, height: 996) }
    
    deinit {
        logEvent(.debug, "Deallocating MultiPageTextLayout")
    }
}

/// MARK: Storage delegate functions
extension MultiPageTextLayout: NSTextStorageDelegate {
    
}

/// MARK: Layout manager delegate functions
extension MultiPageTextLayout: NSLayoutManagerDelegate {
    func layoutManagerDidInvalidateLayout(_ sender: NSLayoutManager) {
        logEvent(.debug, "LayouManager did invalidate")
    }
    
    func layoutManager(_ layoutManager: NSLayoutManager,
                       didCompleteLayoutFor textContainer: NSTextContainer?,
                       atEnd layoutFinishedFlag: Bool) {
        let atTextBodyEnd = textContainer == nil
        let shouldAddNewTextContainerAndTextView = layoutFinishedFlag && atTextBodyEnd
        
        if shouldAddNewTextContainerAndTextView {
            multicastDelegate.invokeDelegates { $0.requestToAddNextTextContainerAndView() }
        }
        
        logEvent(.debug, "LayoutManager finished laying out container: Request to add new text container and view: \(shouldAddNewTextContainerAndTextView)")
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
    }
    
    func textDidEndEditing(_ notification: Notification) {
        logEvent(.debug, "text did end editting")
            //onCommit()
    }
}

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
        var currentPoint: CGPoint? = nil

        if let cursorFrame = textView.getCursorPositionInFrame() {
            let cursorX = cursorFrame.origin.x
            let cursorY = cursorFrame.origin.y
            let cursorHeight = cursorFrame.height
            
            currentPoint = CGPoint(x: cursorX, y: cursorY + cursorHeight)
        }
        
        var shouldUpdate = true
        if let currentPoint = currentPoint, cursorPositionInCurrentTextView?.equalTo(currentPoint) ?? false {
            shouldUpdate = false
        }
        
        if shouldUpdate {
            multicastDelegate.invokeDelegates{ $0.cursorPositionUpdated(currentPoint) }
            multicastDelegate.invokeDelegates{ $0.cursorPositionUpdated(currentPoint, in: textView) }

            logEvent(.trace, "Cursor position updated: \(String(describing: cursorPositionInCurrentTextView))")
        }
    }
}

public protocol MultiPageTextLayoutDelegate: AnyObject {
    func cursorPositionUpdated(_ point: CGPoint?)
    func cursorPositionUpdated(_ point: CGPoint?, in textView: NSTextView)
    func requestToAddNextTextContainerAndView()
}

extension MultiPageTextLayoutDelegate {
    func cursorPositionUpdated(_ point: CGPoint?) { }
    func cursorPositionUpdated(_ point: CGPoint?, in textView: NSTextView) { }
    func requestToAddNextTextContainerAndView() { }
}
