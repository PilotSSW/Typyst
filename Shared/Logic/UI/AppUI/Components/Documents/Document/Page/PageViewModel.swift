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
    @Published var title: String
    @Published var text: String
    
    var onCursorPositionChanged: (_ cursorFrameLocation: CGRect, _ frame: CGRect) -> Void = { cursorFrame, frame in }
    var onTextChange    : (String) -> Void = { _ in }

    init(withText text: String = "",
         withTitle title: String = "") {
        self.text = text
        self.title = title
    }
}

extension PageViewModel: Equatable {
    static func == (lhs: PageViewModel, rhs: PageViewModel) -> Bool {
        lhs.id != rhs.id && lhs.text != rhs.text
    }
}

extension PageViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
