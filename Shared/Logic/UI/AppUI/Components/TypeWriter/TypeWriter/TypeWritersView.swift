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
            if viewModel.showPaper, let documentViewModel = viewModel.currentDocumentViewModel {
                
                DocumentView(viewModel: documentViewModel)
                    .padding(4)
                    .frame(maxWidth: 800, alignment: .bottom)
                    .animation(.interactiveSpring()
                               .speed(0.75)
                               .delay(0.03))

            }
            
            if viewModel.showKeyboard {
                KeyboardContainerView(viewModel: viewModel.keyboardContainerViewModel)
                    .frame(minWidth: viewModel.keyboardMinWidth,
                           maxWidth: viewModel.keyboardMaxWidth,
                           minHeight: viewModel.keyboardMinHeight,
                           maxHeight: viewModel.keyboardMaxHeight,
                           alignment: .bottom)
                    .shadow(color: AppColor.objectShadowDark.opacity(0.5), radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: -2)
                    .animation(.interactiveSpring()
                                .speed(0.75)
                                .delay(0.03))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
}

struct TypeWritersView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = TypeWriterViewModel()
        vm.showPaper = true
        return TypeWritersView(viewModel: vm)
            .previewLayout(.fixed(width: 800, height: 800))
    }
}
