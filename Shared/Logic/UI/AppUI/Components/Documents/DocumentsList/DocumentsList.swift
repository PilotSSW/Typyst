//
//  DocumentsList.swift
//  Typyst
//
//  Created by Sean Wolford on 8/27/21.
//

import SwiftUI

struct DocumentsList: View {
    @StateObject var viewModel = DocumentsListViewModel()

    var body: some View {
        List() {
            Section(header: Text("Elsewhere").asStyledText()) {
                DocumentsListWebRow()
            }
//            .removingScrollViewBackground()

            Section(header: Text("Typyst Journal").asStyledText()) {
                DocumentsListAddRow()

//                LazyVStack() {
                    ForEach(viewModel.documents, id: \.id) { document in
                        #if os(macOS)
                        DocumentsListRow(document: document)
                            .onDeleteCommand(perform: {
                                viewModel.deleteDocument(document)
                            })
                        #else
                        DocumentsListRow(document: document)
                        #endif
                    }
//                }
            }
//            .removingScrollViewBackground()
        }
        .listStyle(InsetListStyle())
    }
}

struct DocumentsList_Previews: PreviewProvider {
    static var previews: some View {
        DocumentsList()
            .previewLayout(.sizeThatFits)
    }
}
