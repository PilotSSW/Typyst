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
        ZStack {
            #if DEBUG
//            if #available(macOS 12.0, *) {
//                let _ = Self._printChanges()
//            }
            #endif
            
            GeometryReader { reader in
                let _ = onReaderUpdate(reader)

                PageView(viewModel: viewModel.currentPageViewModel)
                    .neumorphicShadow(shadowIntensity: .medium, radius: 3, x: 0, y: 6)
                    .position(x: viewModel.xOffset,
                              y: viewModel.yOffset)
                    .transition(.slide)
                    .onAppear() { viewModel.onAppear() }
                    .onDisappear() { viewModel.onDisappear() }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
        let currentPage = PageViewModel(pageIndex: 0, withTextLayout: layout, withDocument: Document(documentName: "A brand new story"))
        
        let viewModel = CurrentPageEditorViewModel(layout: layout,
                                                   currentPageViewModel: currentPage)
        return CurrentPageEditor(viewModel: viewModel)
            .frame(width: 1400, height: 1400)
    }
}
