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
    private var store = Set<AnyCancellable>()
    @State private(set) var viewId = UUID()

    @Binding var textView: NSTextView

    init(withTextView textView: Binding<NSTextView> = .constant(NSTextView())) {
        self._textView = textView
        //commonInit()
        
    }
    
    private func commonInit() {
        // display properties
        
    }

    // MARK: - Coordinator
    class Coordinator: NSObject {
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

    func makeNSView(context: Context) -> NSView {
        let containerView = NSView()
        
        logEvent(.trace, "TextEditorView underlying NSView created: \(viewId)", context: textView)

        return containerView
    }

    func updateNSView(_ view: NSView, context: Context) {
        let containerView = view
        
        // Case: TextView is being added for the first time -- or -- has changed to a new textView
        if !containerView.subviews.contains(textView) {
            // 1. Remove old textView
            var childTextViewRemoved = false
            containerView.subviews.forEach({
                childTextViewRemoved = true
                $0.removeFromSuperview()
            })

            // 2. Add new text view
            containerView.addSubview(textView)

            // 3. Add constraints to make textView full size of container view
            textView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                textView.topAnchor.constraint(equalTo: containerView.topAnchor),
                textView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                textView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                textView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
            ])

            let logMsg = "TextEditorView child \(childTextViewRemoved ? "replaced" : "added"): \(viewId)"
            logEvent(.trace, logMsg, context: textView)
        }

        logEvent(.trace, "TextEditorView NSView updated: \(viewId)", context: textView)
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
        
        return TextEditorView(withTextView: .constant(textView))
            .previewLayout(.device)
    }
}
