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
                ForEach(pages) { pageViewModel in
                    PageView(viewModel: pageViewModel)
                }
            }
        }
    }
}

struct PagesScrollerView_Previews: PreviewProvider {
    static var previews: some View {
        let pages = PageViewModelFactory.generateRandomPageViewModelsForText()
        return PagesScrollerView(pages: pages)
    }
}
