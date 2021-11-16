//
//  PageLayoutViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 11/10/21.
//

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKIt)
import UIKit
#endif
import Combine
import Foundation

class PageLayoutViewModel: ObservableObject, Identifiable, Loggable {
    internal let id = UUID()
    
    private(set) var layout: TextLayout
    private(set) weak var textView: NSTextView?
    
    var frameSize: CGSize {
        textView?.frame.size ?? CGSize(width: 0, height: 0)
    }
    
    // View model properties
    let pageIndex: Int
    @Published var title: String = ""
    
    var isEditable: Bool {
        set { textView?.isEditable = newValue }
        get { textView?.isEditable ?? false }
    }
    
    init(withTextLayout layout: TextLayout, pageIndex: Int, withTitle title: String = "") {
        self.layout = layout
        self.pageIndex = pageIndex
        self.title = title
        
        logEvent(.trace, "PageLayout view model created: \(id)")
    }
    
    func createTextView(withSize size: CGSize) -> NSTextView {
        // Case: TextView already created
        if let textView = textView {
            logEvent(.debug, "TextView from stored property in layout")
            return textView
        }
        // Case: Is creating a TextView for a page that already exists but is not displayed
        else if let textContainer = layout.textContainers[safe: pageIndex] {
            let textView = layout.createAndAddNewTextView(withFrame: CGRect(origin: .zero, size: size),
                                                          andTextContainer: textContainer)
            self.textView = textView
            self.textView?.isEditable = false
            
            logEvent(.debug, "TextView assigned to container in pageLayout")
            return textView
        }
        // Case: Is creating a new page
        else {
            let textView = layout.createAndAddNewTextView(withFrame: CGRect(origin: .zero, size: size))
            self.textView = textView
            
            logEvent(.debug, "TextView created in pageLayout")
            return textView
        }
    }
    
    deinit {
        if let textView = textView {
            DispatchQueue.main.async { [weak self] in
                let _ = self?.layout.removeTextView(textView)
            }
        }
        
        logEvent(.trace, "PageLayout view model deallocated: \(id)")
    }
}

extension PageLayoutViewModel: Equatable {
    static func == (lhs: PageLayoutViewModel, rhs: PageLayoutViewModel) -> Bool {
        lhs.id != rhs.id
    }
}

extension PageLayoutViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
