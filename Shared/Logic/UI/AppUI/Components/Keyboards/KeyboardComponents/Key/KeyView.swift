//
//  KeyView.swift
//  Typyst
//
//  Created by Sean Wolford on 7/6/21.
//

import KeyLogic
import SwiftUI

struct KeyView: View, Loggable {
    @StateObject var viewModel: KeyViewModel
    
    @ObservedObject
    var typeWriterService: TypeWriterService = RootDependencyContainer.get().typeWriterService

    var body: some View {
        //let _ = logEvent(.trace, "rendering key-button: \(viewModel.displayText)")

        keyView
            .scaleEffect(viewModel.isPressed ? 0.92 : 1.00)
            .offset(x: 0.0, y: viewModel.isPressed ? 8 : 0)
            .padding(viewModel.innerPadding)
            .frame(width: viewModel.keySize.width,
                   height: viewModel.keySize.height,
                   alignment: .center)
            .edgesIgnoringSafeArea(.all)
            .pressAction(onPress: {
                viewModel.onTap(direction: .keyDown)
            }, onRelease: {
                viewModel.onTap(direction: .keyUp)
            })
            .onHover(perform: { isHovering in
                viewModel.isHovering = isHovering
            })
            .transition(.scale(scale: 1.0, anchor: .bottom))
            .animation(viewModel.isPressed
                ? .easeOut(duration: 0.15)
                : .easeIn(duration: 0.15))
    }
}

struct KeyView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = KeyViewModelFactory.createViewModel(keyCharacter: .option)
        KeyView(viewModel: vm)
            .previewLayout(.sizeThatFits)
    }
}

extension KeyView {
    @ViewBuilder
    private var keyView: some View {
        switch(typeWriterService.loadedTypewriter?.modelType) {
            case .Olympia_SM3: OlympiaSM3Key(viewModel: viewModel)
            case .Royal_Model_P: RoyalModelPKey(viewModel: viewModel)
            case .Smith_Corona_Silent: SmithCoronaSilentKey(viewModel: viewModel)
            case .Unknown:
                Button(action: {}, label:  {
                    Text(viewModel.displayText)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                })
                    .buttonStyle(NeumorphicButtonStyle(backgroundColor: .white.opacity(0.66)))
            default:
                EmptyView()
        }
    }
}
