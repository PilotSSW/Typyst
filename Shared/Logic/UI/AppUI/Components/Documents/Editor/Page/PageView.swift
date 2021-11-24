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
        #if DEBUG
        if #available(macOS 12.0, *) {
            let _ = Self._printChanges()
        }
        #endif
        
        SheetOfPaper() {
            ZStack {
                VStack {
                    Spacer()
                    
                    Text("Page \(viewModel.pageIndex + 1)")
                        .asStyledText(with: .footnote, textSize: .small)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, max(4, viewModel.margins.bottom / 4))
                }
                
                PageLayout(viewModel: viewModel.pageLayoutViewModel)
                    .padding(.top, viewModel.margins.top)
                    .padding(.bottom, viewModel.margins.bottom)
                    .padding(.horizontal, viewModel.margins.leading + viewModel.margins.trailing)
            }
        }
        .frame(width: viewModel.pageSize.width,
               height: viewModel.pageSize.height,
               alignment: .center)
        .onAppear() { viewModel.onAppear() }
        .onDisappear() { viewModel.onDisappear() }
    }
}

struct Page_Previews: PreviewProvider {
    static var previews: some View {
        let layout = MultiPageTextLayout(with: ["This is a sentence!\n", "This is another sentence."])
        let viewModel = PageViewModel(pageIndex: 0, withTextLayout: layout, withDocument: Document(documentName: "A brand new story"))
        
        return PageView(viewModel: viewModel)
            .padding(12)
    }
}
