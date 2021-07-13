//
//  KeyboardRowView.swift
//  Typyst
//
//  Created by Sean Wolford on 7/6/21.
//

import SwiftUI

struct KeyboardRowView: View {
    var viewModel: KeyboardRowViewModel

    var body: some View {
        HStack(alignment: .center, spacing: 0, content: {
            Spacer()
                .frame(minWidth: 1, maxWidth: .infinity)

            ForEach (viewModel.keyViewModels, id: \.displayText.hashValue) { keyViewModel in
                KeyView(viewModel: keyViewModel)
                    .layoutPriority(1)
            }

            Spacer()
                .frame(minWidth: 1, maxWidth: .infinity)
        })
    }
}

struct KeyboardRowView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardRowView(viewModel: KeyboardRowViewModel(
            keyCharacters: [.a, .b, .c, .d, .e, .f, .g, .h, .i])
        )
    }
}
