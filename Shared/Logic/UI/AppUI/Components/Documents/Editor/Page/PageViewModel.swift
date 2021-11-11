//
//  DocumentPageViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 9/17/21.
//

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKIt)
import UIKit
#endif
import Combine
import Foundation

class PageViewModel: ObservableObject, Identifiable, Loggable {
    internal let id = UUID()
    private var store = Set<AnyCancellable>()
    
    var layout: TextLayout
    
    // View properties
    @Published var pageSize: CGSize = CGSize(width: 850, height: 1100)
    @Published var margins: CGSize = CGSize(width: 40, height: 20)
    
    var usableTextArea: CGSize {
        pageLayoutViewModel.frameSize
//        CGSize(width: pageSize.width - (2 * margins.width),
//               height: pageSize.height - (2 * margins.height))
    }
    
    let pageLayoutViewModel: PageLayoutViewModel
    
    init(pageIndex: Int, withTextLayout layout: TextLayout, withTitle title: String = "") {
        self.layout = layout
        self.pageLayoutViewModel = PageLayoutViewModel(withTextLayout: layout, pageIndex: pageIndex, withTitle: title)
        
        logEvent(.trace, "Page view model created: \(id)")
    }
    
    deinit {
        logEvent(.trace, "Page view model deallocated: \(id)")
    }
}



extension PageViewModel: Equatable {
    static func == (lhs: PageViewModel, rhs: PageViewModel) -> Bool {
        lhs.id != rhs.id
    }
}

extension PageViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
