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
    @Published var xOffset: CGFloat = 0.0
    @Published var yOffset: CGFloat = 0.0
    
    let pageLayoutViewModel: PageLayoutViewModel
    
    init(pageIndex: Int, withTextLayout layout: TextLayout, withTitle title: String = "") {
        self.layout = layout
        self.pageLayoutViewModel = PageLayoutViewModel(withTextLayout: layout, pageIndex: pageIndex, withTitle: title)
        
        registerObservers()
        logEvent(.trace, "Page view model created: \(id)")
    }
    
    deinit {
        logEvent(.trace, "Page view model deallocated: \(id)")
    }
}

/// MARK: Private functions
extension PageViewModel {
    private func registerObservers() {
        (layout as? MultiPageTextLayout)?.$currentCursorPosition
            .sink { [weak self] newCursorPosition in
                guard let self = self else { return }
                
                if let cursorFrame = newCursorPosition {
                    let offsets = self.calculatePageOffsets(cursorFrame: cursorFrame,
                                                            textViewFrame: CGRect(origin: .zero, size: self.pageSize))
                    
                    self.xOffset = offsets.xOffset
                    self.yOffset = offsets.yOffset
                }
                else {
                    self.xOffset = (self.pageSize.width / 2)
                    self.yOffset = self.pageSize.height
                }
            }
            .store(in: &store)
    }
    
    private func calculatePageOffsets(cursorFrame: CGRect, textViewFrame: CGRect) -> (xOffset: CGFloat, yOffset: CGFloat) {
        let startingXoffset = textViewFrame.width / 2
        let endingXOffset = startingXoffset - cursorFrame.origin.x
        
        let startingYoffset = textViewFrame.width
        let endingYOffset = startingYoffset - cursorFrame.origin.y
        
        return (endingXOffset, endingYOffset)
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
