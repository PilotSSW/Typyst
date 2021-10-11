//
//  KeyView.swift
//  Typyst
//
//  Created by Sean Wolford on 7/6/21.
//

import SwiftUI

struct KeyView: View, Loggable {
    @StateObject var viewModel: KeyViewModel

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
        switch(viewModel.selectedTypeWriter) {
            case .Olympia_SM3: OlympiaSM3Key(viewModel: viewModel)
            case .Royal_Model_P: RoyalModelPKey(viewModel: viewModel)
//            case .Smith_Corona_Silent: SmithCoronaSilentKey(viewModel: viewModel)
            default: Button(viewModel.displayText, action: {})
                        .buttonStyle(BorderlessButtonStyle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .border(Color.black, width: 0.5)
        }
    }
}