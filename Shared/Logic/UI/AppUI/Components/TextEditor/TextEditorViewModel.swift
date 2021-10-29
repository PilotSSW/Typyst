//
//  TextEditorViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 10/21/21.
//

import Foundation

class TextEditorViewModel: ObservableObject {
    var onCursorPositionChanged: (_ cursorFrameLocation: CGRect,
                                  _ frame: CGRect) -> Void = { cursorFrame, frame in }
    var onTextChange: (String) -> Void = { _ in }
    
    init(onCursorPositionChanged: @escaping (_ cursorFrameLocation: CGRect,
                                             _ frame: CGRect) -> Void = { cursorFrame, frame in },
         onTextChange: @escaping (String) -> Void = { _ in })
    {
        self.onCursorPositionChanged = onCursorPositionChanged
        self.onTextChange = onTextChange
    }
}
