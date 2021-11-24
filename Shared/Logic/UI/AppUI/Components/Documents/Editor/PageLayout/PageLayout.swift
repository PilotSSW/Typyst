//
//  PageLayout.swift
//  Typyst
//
//  Created by Sean Wolford on 11/10/21.
//

import Combine
import SwiftUI

struct PageLayout: View {
    @ObservedObject
    var viewModel: PageLayoutViewModel
    
    var body: some View {
        #if DEBUG
        if #available(macOS 12.0, *) {
            let _ = Self._printChanges()
        }
        #endif
        
        VStack(alignment: .leading, spacing: 4) {
            if viewModel.pageIndex == 0 {
                TextField("Give your new document a great title!", text: $viewModel.title)
                    .asStyledHeader(with: .largeTitle, textSize: .veryLarge)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.plain)
                    .disabled(!viewModel.isEditorPage)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 4)
                    .layoutPriority(1)
            }
                
            TextEditorView(withTextView: textViewBinding)
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity)
        }
        .onAppear() { viewModel.onAppear() }
        .onDisappear() { viewModel.onDisappear() }
    }
    
    var textViewBinding: Binding<NSTextView> {
        Binding(
            get: { viewModel.textView ?? viewModel.setTextView() },
            set: { textView in }
        )
    }
}

struct PageLayout_Previews: PreviewProvider {
    static var previews: some View {
        let layout = MultiPageTextLayout(with: ["Hello there!"])
        let viewModel = PageLayoutViewModel(withTextLayout: layout, pageIndex: 0, withDocument: Document(documentName: "A brand new story"))
        return PageLayout(viewModel: viewModel)
    }
}
