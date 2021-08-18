//
//  KeyboardContainer.swift
//  TypystKeyboard
//
//  Created by Sean Wolford on 8/12/21.
//

import SwiftUI

struct KeyboardContainerView: View, Loggable {
    @StateObject
    var viewModel: KeyboardContainerViewModel
    
    var body: some View {
        //let _ = logEvent(.trace, "rendering keyboard container", context: [viewModel])

        ZStack() {
            TypeWriterBackground(typeWriterModel: viewModel.currentTypeWriterModel,
                                 cornerRadius: viewModel.cornerRadius)

            VStack() {
                if(viewModel.visibleComponent == .keyboard) {
                    KeyboardView(viewModel: viewModel.keyboardViewModel)
                }


                if(viewModel.visibleComponent == .settings) {
                    SettingsComponent(goBackAction: {
                        viewModel.showComponent(.keyboard)
                    })
                    .animation(.easeInOut)
                    .padding(.vertical, 6)
                }
            }
            .frame(maxWidth: 600, alignment: .bottom)
        }
        .frame(minWidth: 100, idealWidth: 300, maxWidth: .infinity,
               minHeight: 75, idealHeight: 210, maxHeight: .infinity)
        
    }
}

struct KeyboardContainer_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = KeyboardContainerViewModel()
        let _ = viewModel.showComponent(.settings)
        KeyboardContainerView(viewModel: viewModel)
            .previewDevice("iPhone SE (2nd generation)")
    }
}
