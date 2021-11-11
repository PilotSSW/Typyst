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
