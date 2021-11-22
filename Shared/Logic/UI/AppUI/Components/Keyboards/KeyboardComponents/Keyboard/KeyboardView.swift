//
//  Keyboard.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 7/6/21.
//

import SwiftUI

struct KeyboardView: View, Loggable {
    @ObservedObject
    var viewModel: KeyboardViewModel
    
    var body: some View {
        let _ = logEvent(.trace, "rendering keyboard")

        GeometryReader { viewDimensions in
            let _ = viewModel.set(viewDimensions)

            HStack(alignment: .center, spacing: 0) {
                Spacer()
                    .frame(minWidth: viewDimensions.size.width < 250 ? 10.0 : 0.0)
            
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
                
                Spacer()
                    .frame(minWidth: viewDimensions.size.width < 250 ? 10.0 : 0.0)
            }
        }
    }
}

struct Keyboard_Previews: PreviewProvider {
    static var previews: some View {
        let vm = KeyboardViewModelFactory.createKeyboardViewModel(forTypeWriterModel: .Royal_Model_P)
        vm.model.setLettersMode(.capsLocked)
        return KeyboardView(viewModel: vm)
            .previewLayout(.sizeThatFits)
//            .previewLayout(.device)
//            .previewDevice("iPad Pro (9.7-inch)")
    }
}
