//
//  DocumentsListWebRow.swift
//  Typyst
//
//  Created by Sean Wolford on 9/11/21.
//

import SwiftUI

struct DocumentsListWebRow: View {
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
        Text("Google Docs")
            .asStyledText()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding(8)
            .simultaneousGesture(TapGesture().onEnded() {
                let _ = documentsService.setWebDocument()
            })
    }
}

struct DocumentsListWebRow_Previews: PreviewProvider {
    static var previews: some View {
        DocumentsListWebRow()
    }
}
