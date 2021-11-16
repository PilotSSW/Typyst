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
    
    var textView: NSTextView

    init(withTextView textView: NSTextView) {
        self.textView = textView
        //commonInit()
    }
    
    private func commonInit() {
        // display properties
        
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
        logEvent(.trace, "Textview inserted into SwiftUI view: \(id)", context: textView)
        return textView
    }

    func updateNSView(_ view: NSTextView, context: Context) {
        logEvent(.trace, "Textview updated: \(id)", context: textView)
    }
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
