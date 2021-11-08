//
//  TextEditorView.swift
//  Typyst
//
//  Created by Sean Wolford on 9/6/21.
//

import Combine
import SwiftUI

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

struct TextEditorView: Loggable {
    var isEditable: Bool = true
    var font: NSFont?    = .systemFont(ofSize: 14, weight: .regular)

    var onCursorPositionChanged: (_ cursorFrameLocation: CGRect, _ frame: CGRect) -> Void = { cursorFrame, frame in }
    var onEditingChanged: () -> Void       = {}
    var onCommit        : () -> Void       = {}
    var onTextChange    : (String) -> Void = { _ in }

    var textView: NSTextView = NSTextView()

    init(withTextContainer textContainer: NSTextContainer = NSTextContainer(),
         onCursorPositionChanged: @escaping (_ cursorFrameLocation: CGRect, _ frame: CGRect) -> Void = { cursorFrame, frame in },
         onEditingChanged: @escaping () -> Void       = {},
         onCommit        : @escaping () -> Void       = {},
         onTextChange    : @escaping (String) -> Void = { _ in }
    ) {
        self.onCursorPositionChanged = onCursorPositionChanged
        self.onEditingChanged = onEditingChanged
        self.onCommit = onCommit
        self.onTextChange = onTextChange
        
        textView.textContainer = textContainer
    }

    // MARK: - Coordinator
    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: TextEditorView
        var selectedRanges: [NSValue] = []

        init(_ parent: TextEditorView) {
            self.parent = parent
        }

        func textDidBeginEditing(_ notification: Notification) {
            parent.onEditingChanged()
        }

        func textDidChange(_ notification: Notification) {
            if let cursorFrame = parent.textView.getCursorPositionInFrame() {
                parent.onCursorPositionChanged(cursorFrame, parent.textView.frame)
            }
//            TODO: Get the notification object and get text out -- call onTextChange()!
//            notification.object as

            selectedRanges = parent.textView.selectedRanges
        }

        func textDidEndEditing(_ notification: Notification) {
            parent.onCommit()
        }
    }
}

#if canImport(AppKit)
extension TextEditorView: NSViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeNSView(context: Context) -> NSTextView {
        textView.delegate = context.coordinator

        DispatchQueue.main.async {
            if let cursorFrame = textView.getCursorPositionInFrame() {
                onCursorPositionChanged(cursorFrame, textView.frame)
            }
        }

        return textView
    }

    func updateNSView(_ view: NSTextView, context: Context) {
        view.selectedRanges = context.coordinator.selectedRanges
    }
}
#elseif canImport(UIKit)
extension TextEditorView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> NSTextView {
        textView.delegate = context.coordinator

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            let nsTextView = textView.textView
            if let cursorFrame = nsTextView.getCursorPositionInFrame() {
                onCursorPositionChanged(cursorFrame, textView.frame)
            }
        })

        return textView
    }

    func updateUIView(_ view: NSTextView, context: Context) {
        view.text = text
        view.selectedRanges = context.coordinator.selectedRanges
    }
}
#endif

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView()
            .preferredColorScheme(.dark)
    }
}
