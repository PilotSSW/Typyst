//
//  Keyboard.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 7/6/21.
//

import SwiftUI

struct Keyboard: View {
    let viewModel = KeyboardViewModel()

    var body: some View {
        GeometryReader { viewDimensions in
            let _ = viewModel.set(viewDimensions)

            VStack(alignment: .center, spacing: 3) {
                Spacer()
                    .frame(maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)

                ForEach(viewModel.keyboardRowViewModels, id: \.keyCharacters.hashValue) { rowViewModel in
                    KeyboardRowView(viewModel: rowViewModel)
                        .frame(maxWidth: viewDimensions.size.width)
                        .layoutPriority(1)
                }
                Spacer()
                    .frame(maxWidth: .infinity, minHeight: 1, maxHeight: 1)
            }
        }
        .background(Color.red)
        .frame(minWidth: 75, idealWidth: 200, maxWidth: .infinity,
               minHeight: 75, idealHeight: 250, maxHeight: 450,
               alignment: .center)
    }
}

struct Keyboard_Previews: PreviewProvider {
    static var previews: some View {
        Keyboard()
            .previewLayout(.device)
            .previewDevice("iPad Pro (9.7-inch)")
    }
}
