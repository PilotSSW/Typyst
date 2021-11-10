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
            if viewModel.pageIndex == 0 {
                TextField("Give your new document a great title!", text: $viewModel.title)
                    .asStyledText(with: .largeTitle, textSize: .large)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.plain)
                    .frame(maxWidth: .infinity, maxHeight: 36)
                    .layoutPriority(1)
            }
            
            GeometryReader { reader in
                let textView = viewModel.createTextView(withSize: reader.size)
                TextEditorView(withTextView: textView)
            }
        }
    }
}

struct PageLayout_Previews: PreviewProvider {
    static var previews: some View {
        let layout = MultiPageTextLayout(with: ["Hello there!"])
        let viewModel = PageLayoutViewModel(withTextLayout: layout, pageIndex: 0)
        return PageLayout(viewModel: viewModel)
    }
}
