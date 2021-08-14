//
//  KeyboardContainer.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 8/12/21.
//

import SwiftUI

struct KeyboardContainerView: View, Loggable {
    var keyboardViewModel: KeyboardViewModel
    
    var body: some View {
        let _ = logEvent(.trace, "rendering keyboard container")

        ZStack() {
            TypeWriterBackground(typeWriterModel: keyboardViewModel.modelType,
                                 cornerRadius: keyboardViewModel.cornerRadius)
            
            KeyboardView(viewModel: keyboardViewModel)
                .frame(maxWidth: 400, alignment: .bottom)
        }
        .frame(minWidth: 100, idealWidth: 300, maxWidth: .infinity,
               minHeight: 75, idealHeight: 210, maxHeight: .infinity)
        
    }
}

struct KeyboardContainer_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardContainerView(keyboardViewModel: KeyboardViewModelFactory.createKeyboardViewModel(forTypeWriterModel: .Royal_Model_P))
            .previewDevice("iPhone SE (2nd generation)")
    }
}
