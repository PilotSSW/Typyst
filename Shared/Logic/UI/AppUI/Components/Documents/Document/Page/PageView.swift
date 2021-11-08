//
//  PageView.swift
//  Typyst
//
//  Created by Sean Wolford on 9/17/21.
//

import SwiftUI

struct PageView: View {
    @ObservedObject
    var viewModel: PageViewModel
    
    var body: some View {
        SheetOfPaper() {
            VStack(alignment: .leading) {
                if let titleContainer = viewModel.titleTextContainer {
                    TextEditorView(withTextContainer: titleContainer,
                                   onCursorPositionChanged: viewModel.onCursorPositionChanged,
                                   onTextChange: viewModel.onTitleChange)
                }

                TextEditorView(withTextContainer: viewModel.textTextContainer,
                               onCursorPositionChanged: viewModel.onCursorPositionChanged,
                               onTextChange: viewModel.onTextChange)
                    .layoutPriority(1)
                
                Spacer()
            }
            .frame(maxWidth: 850, maxHeight: 1100)
        }
    }
}

struct Page_Previews: PreviewProvider {
    static var previews: some View {
//        let text = """
//            Wow! This some crazy ass text!
//            """
//        let title = """
//            This is just a boring title. :(
//            """
        let textContainer = NSTextContainer()
        let viewModel = PageViewModel(withTextTextContainer: textContainer)
        PageView(viewModel: viewModel)
    }
}
