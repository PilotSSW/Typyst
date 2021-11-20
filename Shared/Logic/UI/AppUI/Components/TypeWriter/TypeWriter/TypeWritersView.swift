//
//  TypeWritersView.swift
//  Typyst
//
//  Created by Sean Wolford on 10/19/21.
//

import SwiftUI

struct TypeWritersView: View {
    @StateObject var viewModel: TypeWriterViewModel = TypeWriterViewModel()
    
    var body: some View {
        ZStack() {
            if viewModel.showKeyboard {
                KeyboardContainerView(viewModel: viewModel.keyboardContainerViewModel)
                    .frame(minWidth: viewModel.keyboardMinWidth,
                           maxWidth: viewModel.keyboardMaxWidth,
                           minHeight: viewModel.keyboardMinHeight,
                           maxHeight: viewModel.keyboardMaxHeight,
                           alignment: .bottom)
                    .padding(.horizontal, 18)
                    .padding(.bottom, 4)
                    //.shadow(color: AppColor.objectShadowDark.opacity(0.5), radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: -2)
                    .transition(.move(edge: .bottom))
                    .animation(.interactiveSpring()
                                .speed(0.33)
                                .delay(0.01))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .onAppear() { viewModel.onAppear() }
    }
}

struct TypeWritersView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = TypeWriterViewModel()
        return TypeWritersView(viewModel: vm)
            .previewLayout(.fixed(width: 1800, height: 2400))
    }
}
