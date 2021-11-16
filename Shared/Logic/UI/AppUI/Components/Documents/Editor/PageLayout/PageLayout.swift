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
        VStack(alignment: .leading, spacing: 4) {
            if !viewModel.title.isEmpty {
                TextField("Give your new document a great title!", text: $viewModel.title)
                    .asStyledHeader(with: .largeTitle, textSize: .veryLarge)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.plain)
                    .disabled(viewModel.isEditable)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 4)
                    .layoutPriority(1)
            }
            
            GeometryReader { reader in
                let textView = viewModel.createTextView(withSize: reader.size)
                TextEditorView(withTextView: textView)
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity)
            }
        }
        
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
        let viewModel = PageLayoutViewModel(withTextLayout: layout, pageIndex: 0, withTitle: "A Whole New Document!")
        return PageLayout(viewModel: viewModel)
    }
}
