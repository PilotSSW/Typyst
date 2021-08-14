//
//  KeyView.swift
//  Typyst
//
//  Created by Sean Wolford on 7/6/21.
//

import SwiftUI

struct KeyView: View, Loggable {
    @StateObject var viewModel: KeyViewModel
    @State var isPressed: Bool = false

    var body: some View {
        //let _ = logEvent(.trace, "rendering key-button: \(viewModel.displayText)")

        getKeyView()
            .scaleEffect(isPressed ? 0.92 : 1.00)
            .offset(x: 0.0, y: isPressed ? 8 : 0)
            .padding(viewModel.innerPadding)
            .frame(width: viewModel.keySize.width,
                   height: viewModel.keySize.height,
                   alignment: .center)
            .edgesIgnoringSafeArea(.all)
            .pressAction(onPress: {
                viewModel.onTap(direction: .keyDown)
                isPressed = true
            }, onRelease: {
                viewModel.onTap(direction: .keyUp)
                isPressed = false
            })

//        .onHover(perform: { isHovering in
//            viewModel.isHovering = isHovering
//        })
    }
}

struct KeyView_Previews: PreviewProvider {
    static var previews: some View {
        KeyView(viewModel: KeyViewModelFactory.createViewModel(keyCharacter: .b))
            .previewLayout(.sizeThatFits)
    }
}

extension KeyView {
    private func getKeyView() -> some View {
        RoyalModelPKey(viewModel: viewModel)
    }
}