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
    internal let id = UUID()
    
    var textContainer: NSTextContainer
    var textView: NSTextView
    
    init(withTextContainer textContainer: NSTextContainer) {
        self.textView = NSTextView()
        textView.textContainer = textContainer

        self.textContainer = textContainer

        commonInit()
    }

    init(withTextView textView: NSTextView) {
        self.textView = textView
        self.textContainer = textView.textContainer ?? NSTextContainer()

        commonInit()
    }
    
    private func commonInit() {
        // display properties
        textView.isRulerVisible = true
        textView.drawsBackground = false
        textView.textColor = NSColor(cgColor: AppColor.textBody.cgColor ?? .black)
        
        textView.autoresizingMask = [.height, .width]
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = true
        
        textView.isEditable = true
        textView.isSelectable = true
        textView.isHidden = false
        textView.isFieldEditor = false
        textView.isRichText = false
    }

    // MARK: - Coordinator
    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: TextEditorView

        init(_ parent: TextEditorView) {
            self.parent = parent
        }
    }
}

#if canImport(AppKit)
extension TextEditorView: NSViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeNSView(context: Context) -> NSTextView {
        return textView
    }

    func updateNSView(_ view: NSTextView, context: Context) {}
}
#elseif canImport(UIKit)
extension TextEditorView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> NSTextView {
        return textView
    }

    func updateUIView(_ view: NSTextView, context: Context) {}
}
#endif

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        let layout = MultiPageTextLayout(with: ["This is a TextView with some text!!"])
        let textView = layout.createAndAddNewTextView(withFrame: NSRect(origin: .zero, size: NSSize(width: 200, height: 100)))
        
        return TextEditorView(withTextView: textView)
            .previewLayout(.device)
    }
}
