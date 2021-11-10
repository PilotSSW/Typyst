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
    
    var layout: TextLayout
    var textView: NSTextView?
    
    // View model properties
    let pageIndex: Int
    @Published var title: String = ""
    
    init(withTextLayout layout: TextLayout, pageIndex: Int, withTitle title: String = "") {
        self.layout = layout
        self.pageIndex = pageIndex
        self.title = title
        
        logEvent(.trace, "PageLayout view model created: \(id)")
    }
    
    func createTextView(withSize size: CGSize) -> NSTextView {
        if let textView = textView { return textView }
        
        let textView = layout.createAndAddNewTextView(withFrame: CGRect(origin: .zero, size: size))
        self.textView = textView
        
        return textView
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
