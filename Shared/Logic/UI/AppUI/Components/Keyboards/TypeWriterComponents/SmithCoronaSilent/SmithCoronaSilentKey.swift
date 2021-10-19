//
//  OlympiaSM3Key.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 8/18/21.
//

import KeyLogic
import SwiftUI

struct SmithCoronaSilentKey: View {
    var viewModel: KeyViewModel

    var body: some View {
        Text(viewModel.displayText)
    }
}

struct SmithCoronaSilentKey_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = KeyViewModelFactory.createViewModel(keyCharacter: .a)
        viewModel.setSuggestedKeySize(CGSize(width: 35, height: 35))

        return SmithCoronaSilentKey(viewModel: viewModel)
            .frame(width: viewModel.keySize.width,
                   height: viewModel.keySize.height,
                   alignment: .center)
            .padding(18)
            .previewLayout(.sizeThatFits)
    }
}
