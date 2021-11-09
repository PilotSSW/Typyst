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

class PageViewModel: ObservableObject, Identifiable {
    internal let id = UUID()
    private var store = Set<AnyCancellable>()
    var layout: TextLayout
    var textView: NSTextView?

    // View model properties
    @Published var title: String?
    
    // View properties
    var textViewSize: CGSize { CGSize(width: pageSize.width - margins.width, height: pageSize.height - margins.height) }
    @Published var pageSize: CGSize = CGSize(width: 850, height: 1100)
    @Published var margins: CGSize = CGSize(width: 40, height: 20)
    @Published var xOffset: CGFloat = 0.0
    @Published var yOffset: CGFloat = 0.0
    
    var timer: Timer?

    init(withTextLayout layout: TextLayout,
         withTitle title: String?) {
        self.title = title
        self.layout = layout
        self.textView = layout.createAndAddNewTextView(withFrame: CGRect(origin: .zero, size: textViewSize))
                
        registerObservers()
    }
    
    deinit {
        if let textView = textView {
            let _ = layout.removeTextView(textView)
        }
        print("Page view model deallocated: \(id)")
    }
}

/// MARK: Private functions
extension PageViewModel {
    private func registerObservers() {
        (layout as? MultiPageTextLayout)?.$currentCursorPosition
            .sink { [weak self] newCursorPosition in
                guard let self = self else { return }
                self.xOffset = newCursorPosition?.width ?? 0.0
                self.yOffset = newCursorPosition?.height ?? 0.0
            }
            .store(in: &store)
    }
    
    private func calculatePageOffsets(cursorFrame: CGRect, textViewFrame: CGRect) -> (xOffset: CGFloat, yOffset: CGFloat) {
        let startingXoffset = textViewFrame.width / 2
        let endingXOffset = startingXoffset - cursorFrame.origin.x
        
        let startingYoffset = textViewFrame.width
        let endingYOffset = startingYoffset - cursorFrame.height
        
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
