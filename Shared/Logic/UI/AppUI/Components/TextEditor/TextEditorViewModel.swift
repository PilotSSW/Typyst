//
//  TextEditorViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 10/21/21.
//

import Combine
import struct CoreGraphics.CGRect
import Foundation


class TextEditorViewModel: ObservableObject, Identifiable {
    internal let id = UUID()
//    private var store = Set<AnyCancellable>()
    
//    private static let keyBServiceTag = "TextEditorKeyboardServiceTag"
//    private var keyboardService: KeyboardService
    
    var onCursorPositionChanged: (_ cursorFrameLocation: CGRect,
                                  _ frame: CGRect) -> Void = { cursorFrame, frame in }
    var onTextChange: (String) -> Void = { _ in }
    @Published var text: String = ""
    
    init(text: String = "",
         onCursorPositionChanged: @escaping (_ cursorFrameLocation: CGRect,
                                             _ frame: CGRect) -> Void = { cursorFrame, frame in },
         onTextChange: @escaping (String) -> Void = { _ in })
//         keyboardService: KeyboardService = RootDependencyContainer.get().keyboardService)
    {
//        self.keyboardService = keyboardService
        self.onCursorPositionChanged = onCursorPositionChanged
        self.onTextChange = onTextChange
//        keyboardService.registerKeyPressCallback(withTag: TextEditorViewModel.keyBServiceT   ag,
//                                                 completion: { [weak self] keyEvent in
//            guard let self = self else { return }
//            self.text += keyEvent.key.description
//        })
//
//        $text.sink(receiveValue: { [weak self] newStringVal in
//            guard let self = self else { return }
//            self.onTextChange(newStringVal)
//        })
//            .store(in: &store)
        
        onCursorPositionChanged(CGRect(x: 0, y: 0, width: 0, height: 0), CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
//    deinit {
//        keyboardService.removeListenerCallback(withTag: TextEditorViewModel.keyBServiceTag)
//    }
}
