//
//  TypeWriterView.swift
//  Typyst
//
//  Created by Sean Wolford on 9/4/21.
//

import SwiftUI

struct TypeWriterView: View {
    @StateObject
    var settings: SettingsService = RootDependencyContainer.get().settingsService

    @StateObject
    var viewModel = TypeWriterViewModel()

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if viewModel.shouldShowWebView {
                BrowserView()
                    .layoutPriority(2)
            }
            else {
                if let documentViewModel = viewModel.currentDocumentViewModel {
                    ZStack() {
                        StackOfPaper(numberOfSheets: documentViewModel.pageViewModels.count - 1)
                            .frame(maxWidth: .infinity)

                        DocumentView(viewModel: documentViewModel)
                            .frame(maxWidth: .infinity)
                    }
                    .layoutPriority(2)
                }
            }

            if settings.showTypeWriterView {
                Spacer(minLength: 0)
                    .layoutPriority(1)

                KeyboardContainerView(viewModel: viewModel.keyboardContainerViewModel)
                    .frame(minWidth: viewModel.keyboardMinWidth,
                           maxWidth: viewModel.keyboardMaxWidth,
                           minHeight: viewModel.keyboardMinHeight,
                           maxHeight: viewModel.keyboardMaxHeight,
                           alignment: .center)
                    .shadow(color: AppColor.objectShadowDark.opacity(0.5), radius: 3.5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: -2)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct TypeWriterView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TypeWriterViewModel()
        viewModel.currentDocument = Document(documentName: "Hello World!")
        return TypeWriterView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}
