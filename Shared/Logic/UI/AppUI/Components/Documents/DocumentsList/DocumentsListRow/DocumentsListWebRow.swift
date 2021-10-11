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
                .buttonStyle(NeumorphicButtonStyle(backgroundColor: .white))
                .simultaneousGesture(TapGesture().onEnded() {
                    let _ = documentsService.setWebDocument()
                })
        }
        else {
            Button(action: {
                let _ = documentsService.setWebDocument()
            }) {
                content
            }
            .buttonStyle(NeumorphicButtonStyle(backgroundColor: .white))
        }
    }

    @ViewBuilder
    private var content: some View {
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

struct DocumentsListWebRow_Previews: PreviewProvider {
    static var previews: some View {
        DocumentsListWebRow()
    }
}
