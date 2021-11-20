//
//  DocumentsListRow.swift
//  Typyst (iOS)
//
//  Created by Sean Wolford on 8/27/21.
//

import Combine
import SwiftUI

struct DocumentsListRow: View {
    @ObservedObject
    var viewModel: DocumentsListRowViewModel

    @State
    var isHovering: Bool = false

    init(document: Document,
         documentsService: DocumentsService = AppDependencyContainer.get().documentsService) {

        self.viewModel = DocumentsListRowViewModel(document: document,
                                                   documentsService: documentsService)
    }
    
    var body: some View {
        DocumentsListButton(
            onSelect: viewModel.onSelect,
            onReturn: viewModel.onDeselect,
            showNeumorphicButton: false,
            isSelected: $viewModel.isSelected
        )
        {
            VStack(alignment: .center, spacing: 9) {
                Text(viewModel.documentName)
                    .asStyledHeader()
                
                HStack() {
                    Text("Last Opened: ")
                        .asStyledText()
                    
                    Text(viewModel.formattedDate)
                        .asStyledText()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding(12)
            .onHover { isHovering in
                withAnimation { self.isHovering = isHovering }
            }
        }
           .listRowBackground(DocumentsListRowBackground(isHovering: $isHovering,
                                                         isSelected: $viewModel.isSelected))
    }
}

struct DocumentsListRow_Previews: PreviewProvider {
    static var previews: some View {
        DocumentsListRow(document: Document(documentName: "My First Document"))
            .previewLayout(.sizeThatFits)
    }
}
