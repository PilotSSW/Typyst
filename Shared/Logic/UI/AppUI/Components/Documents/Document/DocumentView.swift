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
        VStack() {
            ForEach(viewModel.pageViewModels) { pageViewModel in
                PageView(viewModel: pageViewModel)
            }
        }
        .onDisappear() { viewModel.onDisappear() }
    }
}

struct Document_Previews: PreviewProvider {
    static var previews: some View {
        let document = Document(documentName: "This is a new Document!",
                                textBody: """
                                          This is a sentence!!
                                          This is another sentence!
                                          This is a huge fucking paragraph of text that should be split into several sentences for better grammar and punctuation, because runon sentences are hard to read and understand and often lead to points that lack clarity and flow to the readers who really want to enjoy the body of text.
                                          """)
        return DocumentView(viewModel: DocumentViewModel(document))
            .frame(width: 850, height: 300)
    }
}
