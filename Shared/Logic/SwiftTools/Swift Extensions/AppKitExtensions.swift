//
//  AppKitExtensions.swift
//  Typyst
//
//  Created by Sean Wolford on 10/13/21.
//

import Foundation
import AppKit

extension NSTableView {
    open override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        
        backgroundColor = NSColor.clear
        if let scrollView = enclosingScrollView {
            scrollView.drawsBackground = false
        }
        tableColumns.forEach({
            $0.headerCell.drawsBackground = false
            $0.headerCell.backgroundColor = NSColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.33)
            $0.headerCell.backgroundStyle = .emphasized
        })
        self.style = .fullWidth
//        self.intercellSpacing = NSSize(width: -2, height: 8)
    }
}

extension NSTextView {
    public func getCursorPositionInFrame() -> CGRect? {
        if let textContainer = textContainer {
            let cursorLocation = NSRange(location: selectedRange().location, length: 0)
            let coordinates = layoutManager?.boundingRect(forGlyphRange: cursorLocation, in: textContainer)
            return coordinates
        }
        
        return nil
    }
}
