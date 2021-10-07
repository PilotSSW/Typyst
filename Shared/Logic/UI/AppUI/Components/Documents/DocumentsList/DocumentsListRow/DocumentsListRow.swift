//
//  DocumentsListRow.swift
//  Typyst (iOS)
//
//  Created by Sean Wolford on 8/27/21.
//

import SwiftUI

struct DocumentsListRow: View {
    private var documentsService: DocumentsService
    private(set) var document: Document

    init(document: Document,
         documentsService: DocumentsService = AppDependencyContainer.get().documentsService) {
        self.document = document
        self.documentsService = documentsService
    }

    var body: some View {
        mechanism
    }

    @ViewBuilder
    private var mechanism: some View {
        if OSHelper.runtimeEnvironment == .iOS {
            NavigationLink(
                destination: TypeWriterView(),
                label: {
                    content
                })
        }
        else {
            content
        }
    }

    @ViewBuilder
    private var content: some View {
        let formattedDate: String = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "M-dd-yyyy, h:mm:p"

            return dateFormatter.string(from: document.dateLastOpened)
        }()

        VStack(alignment: .center, spacing: 9) {
            Text(document.documentName)
                .asStyledHeader()

            HStack() {
                Text("Last Opened: ")
                    .asStyledText()

                Text(formattedDate)
                    .asStyledText()
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(8)
        .simultaneousGesture(TapGesture().onEnded() {
            documentsService.setCurrentDocument(document)
        })
    }
}

struct DocumentsListRow_Previews: PreviewProvider {
    static var previews: some View {
        DocumentsListRow(document: Document(documentName: "My First Document"))
            .previewLayout(.sizeThatFits)
    }
}
