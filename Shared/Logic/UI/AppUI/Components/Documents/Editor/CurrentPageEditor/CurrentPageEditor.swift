//
//  CurrentPageEditor.swift
//  Typyst
//
//  Created by Sean Wolford on 11/10/21.
//

import Combine
import SwiftUI

struct CurrentPageEditor: View {
    @ObservedObject
    var viewModel: CurrentPageEditorViewModel
    
    var body: some View {
        GeometryReader { reader in
            if let pageViewModel = viewModel.currentPageViewModel {
                PageView(viewModel: pageViewModel)
                    .position(x: viewModel.xOffset,
                              y: viewModel.yOffset)
                    .transition(.slide)
                    .onAppear {
                        let _ = onReaderUpdate(reader)
                    }
            }
            else {
                EmptyView()
            }
            
            #if DEBUG
            if #available(macOS 12.0, *) {
                let _ = Self._printChanges()
            }
            #endif
        }
    }
    
    private func onReaderUpdate(_ proxy: GeometryProxy) {
        DispatchQueue.main.async {
            viewModel.viewSizeUpdated(proxy.size)
        }
    }
    
}

struct CurrentPageEditor_Previews: PreviewProvider {
    static var previews: some View {
        let layout = MultiPageTextLayout()
        let currentPage = PageViewModel(pageIndex: 0, withTextLayout: layout)
        
        let viewModel = CurrentPageEditorViewModel(layout: layout,
                                                   currentPageViewModel: currentPage)
        return CurrentPageEditor(viewModel: viewModel)
            .frame(width: 1400, height: 1400)
    }
}
