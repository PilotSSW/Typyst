//
//  DocumentPageViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 9/17/21.
//

import Combine
import Foundation

class PageViewModel: ObservableObject, Identifiable {
    internal let id = UUID()
    @Published var titleViewModel: TextEditorViewModel? = nil
    @Published var textViewModel: TextEditorViewModel
    
    var onCursorPositionChanged: (_ cursorFrameLocation: CGRect, _ frame: CGRect) -> Void = { cursorFrame, frame in }
    var onTextChange    : (String) -> Void = { _ in }

    init(withText text: String = "",
         withTitle title: String = "",
         onTextChange: @escaping (String) -> Void = { _ in },
         onTitleChange: @escaping (String) -> Void = { _ in },
         onCursorPositionChanged: @escaping (_ cursorFrameLocation: CGRect,
                                             _ frame: CGRect) -> Void = { cursorFrame, frame in }
    ) {
        self.textViewModel = TextEditorViewModel(
            text: text,
            onCursorPositionChanged: onCursorPositionChanged,
            onTextChange: onTextChange)
        
        self.titleViewModel = title.count > 0
            ? TextEditorViewModel(
                text: title,
                onCursorPositionChanged: onCursorPositionChanged,
                onTextChange: onTitleChange)
            : nil
    }
}

extension PageViewModel: Equatable {
    static func == (lhs: PageViewModel, rhs: PageViewModel) -> Bool {
        lhs.id != rhs.id && lhs.textViewModel.id != rhs.textViewModel.id
    }
}

extension PageViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
