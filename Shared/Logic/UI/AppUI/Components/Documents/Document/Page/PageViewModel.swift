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
    
    @Published var titleTextContainer: NSTextContainer?
    @Published var textTextContainer: NSTextContainer
    
    var onCursorPositionChanged: (_ cursorFrameLocation: CGRect, _ frame: CGRect) -> Void = { cursorFrame, frame in }
    var onTextChange: (String) -> Void = { _ in }
    var onTitleChange: (String) -> Void = { _ in }

    init(withTextTextContainer textContainer: NSTextContainer,
         withTitleTextContainer titleTextContainer: NSTextContainer? = nil,
         onTextChange: @escaping (String) -> Void = { _ in },
         onTitleChange: @escaping (String) -> Void = { _ in },
         onCursorPositionChanged: @escaping (_ cursorFrameLocation: CGRect,
                                             _ frame: CGRect) -> Void = { cursorFrame, frame in }
    ) {
        self.textTextContainer = textContainer
        self.onTextChange = onTextChange

        self.titleTextContainer = titleTextContainer
        self.onTitleChange = onTitleChange
        
        self.onCursorPositionChanged = onCursorPositionChanged
    }
}

/// MARK: Private functions
extension PageViewModel {
    private func configureTextContainers() {
        textTextContainer.widthTracksTextView = true
        textTextContainer.heightTracksTextView = true
        titleTextContainer?.widthTracksTextView = true
        titleTextContainer?.heightTracksTextView = true
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
