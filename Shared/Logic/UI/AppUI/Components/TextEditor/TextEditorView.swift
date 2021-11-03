//
//  TextEditorView.swift
//  Typyst
//
//  Created by Sean Wolford on 9/6/21.
//

import SwiftUI
import TextEdit

struct TextEditorView: View, Loggable {
    var isTitle: Bool = false
//    @Binding var text: String
    
    @State private var font = (NSFont(descriptor: NSFontDescriptor(name: "AmericanTypewriter", size: 14), size: 14) ?? .systemFont(ofSize: 14)) as CTFont
    @State private var carretWidth = 2.0 as CGFloat
    
    @ObservedObject
    var viewModel: TextEditorViewModel

    var body: some View {
        if OSHelper.runtimeEnvironment == .macOS {
            MacEditorTextView(
                text: $viewModel.text,
                isEditable: true,
                font: NSFont(name: "AmericanTypewriter", size: 16),
                onCursorPositionChanged: viewModel.onCursorPositionChanged,
                onTextChange: viewModel.onTextChange
            )
                .asStyledText()
                .multilineTextAlignment(.leading)
                .background(Color.clear)
//        TextEdit(
//            text: $viewModel.text,
//            font: $font,
//            carretWidth: $carretWidth)
//            .border(Color.red, width: 3)

        }
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorView(viewModel: TextEditorViewModel(text: "Hello!"))
            .preferredColorScheme(.dark)
    }
}
