//
//  Keyboard.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 7/6/21.
//

import SwiftUI

struct KeyboardView: View, Loggable {
    @StateObject var viewModel: KeyboardViewModel

    var body: some View {
        let _ = logEvent(.trace, "rendering keyboard")

        GeometryReader { viewDimensions in
            let _ = viewModel.set(viewDimensions)

            VStack(alignment: .center,
                   spacing: viewModel.uiProperties.rowSpacing) {
                Spacer()
                    .frame(maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)

                ForEach(viewModel.keyboardRowViewModels, id: \.id) { rowViewModel in
                    KeyboardRowView(viewModel: rowViewModel)
                        .frame(maxWidth: viewDimensions.size.width)
                        .layoutPriority(1)
                }
                Spacer()
                    .frame(maxWidth: .infinity,
                           minHeight: viewModel.uiProperties.bottomSpacing,
                           maxHeight: viewModel.uiProperties.bottomSpacing)
                    .layoutPriority(2)
            }
        }
    }
}

struct Keyboard_Previews: PreviewProvider {
    static var previews: some View {
        let vm = KeyboardViewModelFactory.createKeyboardViewModel(forTypeWriterModel: .Royal_Model_P)
        KeyboardView(viewModel: vm)
            .previewLayout(.sizeThatFits)
//            .previewLayout(.device)
//            .previewDevice("iPad Pro (9.7-inch)")
    }
}
