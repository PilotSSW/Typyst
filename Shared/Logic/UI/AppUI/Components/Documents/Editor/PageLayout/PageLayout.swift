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
        VStack(alignment: .leading, spacing: 12) {
            Text("Page \(viewModel.pageIndex)")
                .asStyledHeader()
            
            if !viewModel.title.isEmpty {
                TextField("Give your new document a great title!", text: $viewModel.title)
                    .asStyledText(with: .largeTitle, textSize: .large)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.plain)
                    .disabled(viewModel.isEditable)
                    .frame(maxWidth: .infinity, maxHeight: 26)
                    .layoutPriority(1)
            }
            
            GeometryReader { reader in
                let textView = viewModel.createTextView(withSize: reader.size)
                TextEditorView(withTextView: textView)
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity)
            }
        }
        .background(Color.random)
        
        #if DEBUG
        if #available(macOS 12.0, *) {
            let _ = Self._printChanges()
        }
        #endif
    }
}

struct PageLayout_Previews: PreviewProvider {
    static var previews: some View {
        let layout = MultiPageTextLayout(with: ["Hello there!"])
        let viewModel = PageLayoutViewModel(withTextLayout: layout, pageIndex: 0)
        return PageLayout(viewModel: viewModel)
    }
}
