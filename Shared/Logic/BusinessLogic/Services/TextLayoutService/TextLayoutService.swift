//
// Created by Sean Wolford on 11/2/21.
//

import Foundation

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

class TextLayoutService {
//    func documentToArrayOfNSTextView(_ document: Document,
//                                     textStorageDelegate: NSTextStorageDelegate) -> [NSTextView] {
//        let storage = documentToNSTextStorage(document, delegate: delegate)
//    }
    
//    func documentToNSTextStorage(_ document: Document, delegate: NSTextStorageDelegate) -> NSTextStorage {
//        let storage = NSTextStorage()
//        let sentences = document.textBody
//                .split(separator: ". ")
//                .map({ NSAttributedString($0) })

//    }

    func createMultiPageLayoutForDocument(_ document: Document,
                                          storageDelegate: NSTextStorageDelegate? = nil,
                                          layoutManagerDelegate: NSLayoutManagerDelegate? = nil) -> MultiPageTextLayout {
        var layout = MultiPageTextLayout()
        
        let sentences = document.textBody.components(separatedBy: ".?")
        layout.setup(sentences, storageDelegate: storageDelegate, layoutManagerDelegate: layoutManagerDelegate)

        return layout
    }
}

protocol TextLayout {
    var storage: NSTextStorage {get set}
    var layoutManager: NSLayoutManager {get set}
    var textContainers: [NSTextContainer] {get set}
    var textViews: [NSTextView] {get set}
}

struct MultiPageTextLayout: TextLayout {
    var storage: NSTextStorage = NSTextStorage()
    var layoutManager: NSLayoutManager = NSLayoutManager()
    var textContainers: [NSTextContainer] = []
    var textViews: [NSTextView] = []

    public mutating func setup(_ sentences: [String],
                      storageDelegate: NSTextStorageDelegate? = nil,
                      layoutManagerDelegate: NSLayoutManagerDelegate? = nil) {
        initializeStorageWithText(sentences, delegate: storageDelegate)
        initializeLayoutManagers(delegate: layoutManagerDelegate)
    }

    public mutating func createAndAddNewTextContainer() -> NSTextContainer {
        let textContainer = NSTextContainer()
        textContainers.append(textContainer)
        return textContainer
    }

    /// Private functions
    private mutating func initializeStorageWithText(_ sentences: [String], delegate: NSTextStorageDelegate? = nil) {
        if let delegate = delegate { storage.delegate = delegate }

        sentences.forEach({
            let attributedString = NSAttributedString(string: $0)
            storage.append(attributedString)
        })
    }

    private mutating func initializeLayoutManagers(delegate: NSLayoutManagerDelegate? = nil) {
        if let delegate = delegate { layoutManager.delegate = delegate }
        storage.addLayoutManager(layoutManager)
    }
}
