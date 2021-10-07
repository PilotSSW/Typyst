//
//  TextView.swift
//  Typyst
//
//  Created by Sean Wolford on 9/6/21.
//

import SwiftUI

struct TextView: View {
    var isTitle: Bool = false
    @Binding var text: String

    var body: some View {
        if isTitle {
            TextField("Title", text: $text,
                      onEditingChanged: { textChanged in

                      },
                      onCommit: {})
                .asStyledHeader()
                .multilineTextAlignment(.center)
        }
        else {
            textBody
        }
    }

    @ViewBuilder
    var textBody: some View {
        TextEditor(text: $text)
            .asStyledText()
            .multilineTextAlignment(.leading)
            .background(Color.clear)
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView(text: .constant("Hello!"))
            .preferredColorScheme(.dark)
    }
}
