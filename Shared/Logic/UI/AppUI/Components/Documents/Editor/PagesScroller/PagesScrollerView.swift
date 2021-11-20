//
//  PagesScrollerView.swift
//  Typyst
//
//  Created by Sean Wolford on 11/10/21.
//

import SwiftUI

struct PagesScrollerView: View {
    @ObservedObject
    var viewModel: PagesScrollerViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(
                columns: [
                    GridItem(.adaptive(minimum: 850, maximum: 850), spacing: 16, alignment: .center)
                ], spacing: 16
            ) {
                ForEach(viewModel.pages, id: \.id) { pageViewModel in
                    PageView(viewModel: pageViewModel)
                        .neumorphicShadow(shadowIntensity: .light, radius: 20, x: 0, y: 12)
                        .neumorphicShadow(shadowIntensity: .mediumLight, radius: 3, x: 0, y: 6)
                        .transition(.slide)
                }
            }
            .padding(.leading, 36)
            .padding(.trailing, 36)
            .padding(.top, 75)
            .padding(.bottom, 560)
        }
    }
}

struct PagesScrollerView_Previews: PreviewProvider {
    static var previews: some View {
        let layout = MultiPageTextLayout()
        let pages = PageViewModelFactory.generateRandomPageViewModelsForText(withLayout: layout)
        
        let viewModel = PagesScrollerViewModel()
        viewModel.setPages(pages)
        
        return PagesScrollerView(viewModel: viewModel)
            .frame(width: 1800, height: 5000)
    }
}
