//
//  KeyboardRowView.swift
//  Typyst
//
//  Created by Sean Wolford on 7/6/21.
//

import SwiftUI

struct KeyboardRowView: View {
    @StateObject var viewModel: KeyboardRowViewModel

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Spacer()
                .frame(minWidth: 3, maxWidth: .infinity)

            ForEach (viewModel.keyGroupViewModels, id: \.id) { keyGroupViewModel in
                if (keyGroupViewModel.groupPositionInRow == .right) {
                    Spacer()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .layoutPriority(3)
                }

                KeyGroupView(viewModel: keyGroupViewModel)
                    .layoutPriority(keyGroupViewModel.groupPositionInRow == .center ? 2 : 4)

                if (keyGroupViewModel.groupPositionInRow == .left) {
                    Spacer()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .layoutPriority(3)
                }
            }

            Spacer()
                .frame(minWidth: 3, maxWidth: .infinity)
        }
    }
}

struct KeyboardRowView_Previews: PreviewProvider {
    static var previews: some View {
        let keyChars: KeyboardRowCharacterSet = [[.letters, .nextKeyboardGlobe], [.space], [.return]]
        let viewModel = KeyboardRowViewModelFactory.createRowViewModel(keyRowCharacters: keyChars)

        return KeyboardRowView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}