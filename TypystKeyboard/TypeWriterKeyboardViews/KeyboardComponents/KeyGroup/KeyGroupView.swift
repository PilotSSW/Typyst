//
//  KeyGroupView.swift
//  Typyst
//
//  Created by Sean Wolford on 7/15/21.
//

import SwiftUI

struct KeyGroupView: View {
    var viewModel: KeyGroupViewModel

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(viewModel.keyViewModels, id: \.id) { keyViewModel in
                KeyView(viewModel: keyViewModel)
            }
        }
    }
}

struct KeyGroupView_Previews: PreviewProvider {
    static var previews: some View {
        let keyChars: KeyGroupCharacterSet = [.z, .x, .c, .v, .b, .n, .m]
        let viewModel = KeyGroupViewModelFactory.createGroupViewModel(keyCharacters: keyChars)
        return KeyGroupView(viewModel: viewModel)
    }
}
