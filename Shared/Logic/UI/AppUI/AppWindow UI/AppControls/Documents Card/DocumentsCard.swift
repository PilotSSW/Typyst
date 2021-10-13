//
//  DocumentsCard.swift
//  Typyst
//
//  Created by Sean Wolford on 8/27/21.
//

import SwiftUI

struct DocumentsCard: View {
    private var onTitleClick: (() -> Void)? = nil
    @Binding private var documentsListViewModel: DocumentsListViewModel

    init(documentsListViewModel: Binding<DocumentsListViewModel> = .constant(DocumentsListViewModel()),
         onTitleClick: (() -> Void)? = nil) {
        self.onTitleClick = onTitleClick
        self._documentsListViewModel = documentsListViewModel
    }

    var body: some View {
        Card(title: "Documents",
             cardContentStyle: .roundedCornerChild,
             onTitleClick: onTitleClick) {
            DocumentsList(viewModel: documentsListViewModel)
                .padding(6)
        }
    }
}

struct DocumentsCard_Previews: PreviewProvider {
    static var previews: some View {
        DocumentsCard()
            .frame(width: 375)
    }
}
