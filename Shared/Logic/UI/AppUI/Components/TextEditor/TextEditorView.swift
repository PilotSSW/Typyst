//
//  TextEditorView.swift
//  Typyst
//
//  Created by Sean Wolford on 9/6/21.
//

import SwiftUI

struct TextEditorView: View, Loggable {
    var isTitle: Bool = false
    @Binding var text: String
    
    @ObservedObject
    var viewModel = TextEditorViewModel()

    var body: some View {
        if OSHelper.runtimeEnvironment == .macOS {
            MacEditorTextView(
                text: $text,
                isEditable: true,
                font: NSFont(name: "AmericanTypewriter", size: 16),
                onCursorPositionChanged: viewModel.onCursorPositionChanged,
                onTextChange: viewModel.onTextChange
            )
                .asStyledText()
                .multilineTextAlignment(.leading)
                .background(Color.clear)
        }
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView(text: .constant("Hello!"))
            .preferredColorScheme(.dark)
    }
}
