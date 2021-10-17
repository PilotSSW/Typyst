//
//  DocumentsListRow.swift
//  Typyst (iOS)
//
//  Created by Sean Wolford on 8/27/21.
//

import SwiftUI

struct DocumentsListRow: View {
    private let id = UUID()
    
    private var documentsService: DocumentsService
    private(set) var document: Document
    
    @State
    var isHovering: Bool = false
    
    @State
    var isSelected: Bool = false

    init(document: Document,
         documentsService: DocumentsService = AppDependencyContainer.get().documentsService) {
        self.document = document
        self.documentsService = documentsService
    }
    
    private var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M-dd-yyyy, h:mm:p"
        
        return dateFormatter.string(from: document.dateLastOpened)
    }

    var body: some View {
        DocumentsListButton(
            onSelect: {
                let _ = documentsService.setCurrentDocument(document)
                withAnimation { isSelected = true }
            },
            onReturn: {
                let _ = documentsService.setCurrentDocument(nil)
                withAnimation { isSelected = false }
            },
            showNeumorphicButton: false)
        {
            VStack(alignment: .center, spacing: 9) {
                Text(document.documentName)
                    .asStyledHeader()
                
                HStack() {
                    Text("Last Opened: ")
                        .asStyledText()
                    
                    Text(formattedDate)
                        .asStyledText()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding(12)
            .onHover { isHovering in
                withAnimation { self.isHovering = isHovering }
            }
        }
//            .listRowInsets(.init(top: 5, leading: -20, bottom: 5, trailing: -20))
           .listRowBackground(DocumentsListRowBackground(isHovering: $isHovering, isSelected: $isSelected))
    }
}

struct DocumentsListRow_Previews: PreviewProvider {
    static var previews: some View {
        DocumentsListRow(document: Document(documentName: "My First Document"))
            .previewLayout(.sizeThatFits)
    }
}
