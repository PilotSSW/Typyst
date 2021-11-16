//
//  Document.swift
//  Typyst
//
//  Created by Sean Wolford on 9/16/21.
//

import SwiftUI

struct DocumentView: View {
    @ObservedObject
    var viewModel: DocumentViewModel

    var body: some View {
        ZStack() {
            PagesScrollerView(pages: viewModel.nonEditablePageViewModels)
                .edgesIgnoringSafeArea(.all)
            
            if let editorViewModel = viewModel.currentPageEditorViewModel {
                CurrentPageEditor(viewModel: editorViewModel)
                    .padding(.horizontal, 120)
            }
        }
        .frame(alignment: .bottom)
        .onDisappear() { viewModel.onDisappear() }
    }
}

struct Document_Previews: PreviewProvider {
    static var previews: some View {
        let someText =
            """
            This is a sentence!!
            This is another sentence!
            This is a huge fucking paragraph of text that should be split into several sentences for better grammar and punctuation, because runon sentences are hard to read and understand and often lead to points that lack clarity and flow to the readers who really want to enjoy the body of text.
            
            """
        var textBody = ""
        for index in 1...40 {
            textBody += someText
        }
        
        let document = Document(documentName: "This is a new Document!",
                                textBody: textBody)
        return DocumentView(viewModel: DocumentViewModel(document))
            .frame(width: 3500, height: 2000)
    }
}
