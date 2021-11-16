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
        SheetOfPaper(verticalPadding: viewModel.margins.height,
                     horizontalPadding: viewModel.margins.width) {
            PageLayout(viewModel: viewModel.pageLayoutViewModel)
        }
        .background(Color.random)
        .frame(maxWidth: viewModel.pageSize.width, maxHeight: viewModel.pageSize.height)
        .neumorphicShadow()
        
        #if DEBUG
        if #available(macOS 12.0, *) {
            let _ = Self._printChanges()
        }
        #endif
    }
}

struct Page_Previews: PreviewProvider {
    static var previews: some View {
        let layout = MultiPageTextLayout(with: ["This is a sentence!\n", "This is another sentence."])
        let viewModel = PageViewModel(pageIndex: 0, withTextLayout: layout)
        
        return PageView(viewModel: viewModel)
    }
}
