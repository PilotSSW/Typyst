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

    let rows = [
        GridItem(.adaptive(minimum: 80))
    ]

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
                                            This is a huge body of text that will go on and on
                                            and on and on and on and on and on and on and on
                                            and on and ...
                                            """)
        return DocumentView(viewModel: DocumentViewModel(document))
            .preferredColorScheme(.dark)
    }
}
