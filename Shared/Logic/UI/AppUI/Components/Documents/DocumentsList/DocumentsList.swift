//
//  DocumentsList.swift
//  Typyst
//
//  Created by Sean Wolford on 8/27/21.
//

import Introspect
import SwiftUI

struct DocumentsList: View {
    @ObservedObject var viewModel: DocumentsListViewModel = DocumentsListViewModel()

    var body: some View {
        List() {
            Section(header: Text("Elsewhere")
                        .asStyledText()
                        .background(Color.clear)) {
                DocumentsListGoogleDocsRow()
                    .padding(8)
            }
                .background(Color.clear)

            Section(header: Text("Typyst Journal")
                        .asStyledText()
                        .background(Color.clear)) {
                DocumentsListAddRow()
                    .padding(8)
                
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
                .onDelete(perform: delete)
                //.onDelete(perform: viewModel.deleteDocument)
            }
                .background(Color.clear)
        }
        .frame(minHeight: viewModel.minHeight, maxHeight: .infinity)
        .environment(\.defaultMinListRowHeight, viewModel.rowHeight)
        .environment(\.defaultMinListHeaderHeight, viewModel.headerHeight)
    }
    
    func delete(at offsets: IndexSet) {
        viewModel.deleteDocument(at: offsets)
    }
}

struct DocumentsList_Previews: PreviewProvider {
    static var previews: some View {
        DocumentsList()
            .previewLayout(.sizeThatFits)
    }
}
