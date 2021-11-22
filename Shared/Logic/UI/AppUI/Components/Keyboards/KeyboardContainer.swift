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
                                     cornerRadius: 24)//viewModel.cornerRadius)
                    .neumorphicShadow(shadowIntensity: .mediumLight, radius: 20, x: 0, y: 12)
                    .neumorphicShadow(shadowIntensity: .medium, radius: 3, x: 0, y: 6)
                
                VStack() {
                    if(viewModel.visibleComponent == .keyboard) {
                        KeyboardView(viewModel: viewModel.keyboardViewModel)
                            .padding(.horizontal, 12)
                            .background(
                                ZStack {
                                    RoundedRectangle(cornerRadius: 24)
                                        .strokeBorder()
                                        .foregroundColor(Color.black.opacity(0.6))
                                    
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color.black.opacity(0.44))
                                        .blendMode(.plusDarker)
                                        .padding(1)
                                }
                            )
                    }

                    if(viewModel.visibleComponent == .settings) {
                        SettingsComponent(goBackAction: {
                            viewModel.showComponent(.keyboard)
                        })
                        .animation(.easeInOut)
                        .padding(.vertical, 6)
                    }
                }
                .frame(maxWidth: 800, maxHeight: 310, alignment: .bottom)
            }
        }
        .frame(minWidth: 200, idealWidth: 300, maxWidth: .infinity,
               minHeight: 125, idealHeight: 210, maxHeight: OSHelper.runtimeEnvironment == .keyboardExtension
               ? .infinity
               : 380)
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
