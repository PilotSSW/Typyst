//
//  PageViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 9/17/21.
//

import Combine
import Foundation
import SwiftUI

class PageViewModel: ObservableObject, Identifiable, Loggable {
    internal let id = UUID()
    private var store = Set<AnyCancellable>()
    
    var layout: TextLayout
    let pageIndex: Int
        
    // View properties
    @Published var pageSize: CGSize = CGSize(width: 850, height: 1100)
    @Published var margins: EdgeInsets = EdgeInsets(top: 30, leading: 15, bottom: 30, trailing: 15)
    
    @Published var pageLayoutViewModel: PageLayoutViewModel
    var usableTextArea: CGSize { pageLayoutViewModel.frameSize }
    
    init(pageIndex: Int, withTextLayout layout: TextLayout, withTitle title: String = "") {
        self.pageIndex = pageIndex
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
