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
            LazyVGrid(
                columns: [
                    GridItem(.adaptive(minimum: 850, maximum: 850), spacing: 16, alignment: .center)
                ], spacing: 16
            ) {
                ForEach(pages, id: \.id) { pageViewModel in
                    PageView(viewModel: pageViewModel)
                        .frame(width: pageViewModel.pageSize.width,
                               height: pageViewModel.pageSize.height)
                        .neumorphicShadow(shadowIntensity: .mediumLight, radius: 20, x: 0, y: 12)
                        .neumorphicShadow(shadowIntensity: .medium, radius: 3, x: 0, y: 6)
                        .transition(.slide)
                }
            }
            .padding(.leading, 36)
            .padding(.trailing, 12)
            .padding(.top, 60)
            .padding(.bottom, 450)
        }
    }
}

struct PagesScrollerView_Previews: PreviewProvider {
    static var previews: some View {
        let layout = MultiPageTextLayout()
        let pages = PageViewModelFactory.generateRandomPageViewModelsForText(withLayout: layout)
        return PagesScrollerView(pages: pages)
            .frame(width: 1800, height: 5000)
    }
}
