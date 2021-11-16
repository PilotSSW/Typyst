//
//  PagesScrollerView.swift
//  Typyst
//
//  Created by Sean Wolford on 11/10/21.
//

import SwiftUI

struct PagesScrollerView: View {
    var pages: [PageViewModel]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack() {
                ForEach(pages, id: \.id) { pageViewModel in
                    PageView(viewModel: pageViewModel)
                        .frame(width: pageViewModel.pageSize.width,
                               height: pageViewModel.pageSize.height)
                }
            }
            
            Spacer(minLength: 300)
        }
    }
}

struct PagesScrollerView_Previews: PreviewProvider {
    static var previews: some View {
        let layout = MultiPageTextLayout()
        let pages = PageViewModelFactory.generateRandomPageViewModelsForText(withLayout: layout)
        return PagesScrollerView(pages: pages)
            .frame(height: 5000)
    }
}
