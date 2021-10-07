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
        Text("New Document")
            .asStyledText()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding(8)
            .simultaneousGesture(TapGesture().onEnded() {
                let _ = documentsService.createNewDocument(withName: "A New Story")
            })
    }
}

struct DocumentListAddRow_Previews: PreviewProvider {
    static var previews: some View {
        DocumentsListAddRow()
    }
}
