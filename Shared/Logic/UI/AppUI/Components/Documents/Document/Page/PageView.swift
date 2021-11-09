//
//  PageView.swift
//  Typyst
//
//  Created by Sean Wolford on 9/17/21.
//

import SwiftUI

struct PageView: View {
    @ObservedObject
    var viewModel: PageViewModel
    
    var body: some View {
        SheetOfPaper(verticalPadding: viewModel.margins.height, horizontalPadding: viewModel.margins.width) {
            VStack(alignment: .leading) {
                if let pageTitle = viewModel.title {
                    TextField("Give your new document a great title!", text: .constant(pageTitle))
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
        .frame(maxWidth: viewModel.pageSize.width, maxHeight: viewModel.pageSize.height)
        .offset(x: viewModel.xOffset, y: viewModel.yOffset)
    }
}

struct Page_Previews: PreviewProvider {
    static var previews: some View {
        let layout = MultiPageTextLayout(with: ["This is a sentence!\n", "This is another sentence."])
        let viewModel = PageViewModel(withTextLayout: layout, withTitle: "A title")
        
        return PageView(viewModel: viewModel)
    }
}
