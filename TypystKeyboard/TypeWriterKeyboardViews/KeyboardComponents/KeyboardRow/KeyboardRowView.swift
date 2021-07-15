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
//        HStack(alignment: .center, spacing: 0, content: {
//            Spacer()
//                .frame(minWidth: 1, maxWidth: .infinity)

            HStack(alignment: .center, spacing: 0) {
                ForEach (viewModel.keyViewModels, id: \.self) { keyViewModelGroup in
                    Spacer()
                        .frame(maxWidth: .infinity)
                        .layoutPriority(1)

                    ForEach(keyViewModelGroup, id: \.displayText) { keyViewModel in
                        KeyView(viewModel: keyViewModel)
                            .layoutPriority(2)
                    }
                }

                Spacer()
                    .frame(maxWidth: .infinity)
                    .layoutPriority(1)
            }
//
//            Spacer()
//                .frame(minWidth: 1, maxWidth: .infinity)
//        })
    }
}

struct KeyboardRowView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardRowView(viewModel: KeyboardRowViewModel(
            keyCharacters: [[.a, .b, .c, .d, .e, .f, .g, .h, .i]])
        )
        .previewDevice("iPad Pro (9.7-inch)")
    }
}
