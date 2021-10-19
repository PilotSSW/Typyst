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
        SheetOfPaper() {
            VStack(alignment: .leading) {
                if (viewModel.title.count > 0) {
                    TextView(isTitle: true,
                             text: $viewModel.title)
                }

                TextView(text: $viewModel.text)
                Spacer()
            }
            .frame(maxWidth: 850, maxHeight: 1100)
        }
    }
}

struct Page_Previews: PreviewProvider {
    static var previews: some View {
        let text = """
            Wow! This some crazy ass text!
            """
        let title = """
            This is just a boring title. :(
            """
        let viewModel = PageViewModel(withText: text,
                                      withTitle: title)
        PageView(viewModel: viewModel)
    }
}
