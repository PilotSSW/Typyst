//
//  DocumentsCard.swift
//  Typyst
//
//  Created by Sean Wolford on 8/27/21.
//

import SwiftUI

struct DocumentsCard: View {
    @Binding var isFullHeight: Bool
    var onTitleClick: (() -> Void)? = nil

    init(onTitleClick: (() -> Void)? = nil,
         isFullHeight: Binding<Bool> = .constant(false)) {
        self.onTitleClick = onTitleClick
        self._isFullHeight = isFullHeight
    }

    var body: some View {
        Card(title: "Documents",
             cardContentStyle: .roundedCornerChild,
             onTitleClick: onTitleClick) {
            DocumentsList()
                .frame(minHeight: 340,
                       maxHeight: isFullHeight ? .infinity : 400)
        }
    }
}

struct DocumentsCard_Previews: PreviewProvider {
    static var previews: some View {
        DocumentsCard(isFullHeight: .constant(true))
            .frame(width: 375, height: 400)
    }
}
