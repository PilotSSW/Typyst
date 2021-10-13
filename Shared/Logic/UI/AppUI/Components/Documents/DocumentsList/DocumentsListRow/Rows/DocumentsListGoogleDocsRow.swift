//
//  DocumentsListGoogleDocsRow.swift
//  Typyst
//
//  Created by Sean Wolford on 9/11/21.
//

import SwiftUI

struct DocumentsListGoogleDocsRow: View {
    var documentsService: DocumentsService = AppDependencyContainer.get().documentsService

    var body: some View {
        DocumentsListButton(onSelect: { let _ = documentsService.setWebDocument() },
                           onReturn: { let _ = documentsService.setCurrentDocument(nil) }) {
            HStack() {
                Text("Google Docs")
                    .asStyledText(with: .largeTitle)
                
                Image("Icons/googleDocsIcon")
                    .resizable()
                    .frame(width: 16, height: 16)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding(12)
        }
    }
}

struct DocumentsListGoogleDocsRow_Previews: PreviewProvider {
    static var previews: some View {
        DocumentsListGoogleDocsRow()
    }
}
