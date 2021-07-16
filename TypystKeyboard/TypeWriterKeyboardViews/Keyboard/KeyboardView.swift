//
//  Keyboard.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 7/6/21.
//

import SwiftUI

struct KeyboardView: View {
    let viewModel: KeyboardViewModel

    var body: some View {
         GeometryReader { viewDimensions in
            let _ = viewModel.set(viewDimensions)

            VStack(alignment: .center, spacing: viewModel.rowSpacing) {
                Spacer()
                        .frame(maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)

                ForEach(viewModel.keyboardRowViewModels, id: \.id) { rowViewModel in
                    KeyboardRowView(viewModel: rowViewModel)
                            .frame(maxWidth: viewDimensions.size.width)
                            .layoutPriority(1)
                }
                Spacer()
                        .frame(maxWidth: .infinity,
                               minHeight: viewModel.bottomSpacing,
                               maxHeight: viewModel.bottomSpacing)
            }
        }
            //        .background(Color.red)
            .frame(minWidth: 75, idealWidth: 200, maxWidth: .infinity,
                   minHeight: 75, idealHeight: 250, maxHeight: 450,
                   alignment: .center)
    }
}

struct Keyboard_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView(viewModel: KeyboardViewModelFactory.createKeyboardViewModel())
//            .previewLayout(.device)
            .previewDevice("iPad Pro (9.7-inch)")
    }
}
