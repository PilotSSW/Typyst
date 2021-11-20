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
            if (viewModel.visibleComponent != .none) {
                TypeWriterBackground(typeWriterModel: viewModel.currentTypeWriterModel,
                                     cornerRadius: viewModel.cornerRadius)
                
                VStack() {
                    if(viewModel.visibleComponent == .keyboard) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 24)
                                .strokeBorder()
                                .padding(.horizontal, 5)
                                .padding(.top, 23)
                            
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color.black.opacity(0.44))
                                .blendMode(.plusDarker)
                                .padding(.horizontal, 6)
                                .padding(.top, 24)
                            
                            KeyboardView(viewModel: viewModel.keyboardViewModel)
                                .padding(.horizontal, 12)
                        }
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
        }
        .frame(minWidth: 200, idealWidth: 300, maxWidth: .infinity,
               minHeight: 125, idealHeight: 210, maxHeight: OSHelper.runtimeEnvironment == .keyboardExtension
               ? .infinity
               : 300)
    }
}

struct KeyboardContainer_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = KeyboardContainerViewModel()
        let _ = viewModel.showComponent(.keyboard)
        KeyboardContainerView(viewModel: viewModel)
            .previewDevice("iPhone SE (2nd generation)")
    }
}
