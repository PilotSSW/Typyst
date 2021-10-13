//
//  DocumentsListAddRow.swift
//  Typyst
//
//  Created by Sean Wolford on 8/29/21.
//

import SwiftUI

struct DocumentsListAddRow: View {
    var documentsService: DocumentsService = AppDependencyContainer.get().documentsService

    var body: some View {
        DocumentsListButton(onSelect: { let _ = documentsService.createNewDocument(withName: "A New Story") },
                           onReturn: { let _ = documentsService.setCurrentDocument(nil) }) {
            HStack() {
                Text("New Document")
                    .asStyledText(with: .largeTitle)
                
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(AppColor.buttonPrimary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding(12)
        }
    }
}

struct DocumentListAddRow_Previews: PreviewProvider {
    static var previews: some View {
        DocumentsListAddRow()
    }
}
