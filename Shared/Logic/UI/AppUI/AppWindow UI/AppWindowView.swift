//
//  AppWindowView.swift
//  Typyst
//
//  Created by Sean Wolford on 9/4/21.
//

import SwiftUI

struct AppWindowView: View {
    @StateObject var viewModel = AppWindowViewModel()
    @StateObject var interfaceAndControlsViewModel = InterfaceAndControlsViewModel()

    var body: some View {
        if OSHelper.runtimeEnvironment == .iOS {
            NavigationContainer() {
                InterfaceAndControls()
            }
        }
        else {
            ZStack(alignment: .bottomLeading) {
                GeometryReader { geometry in
                    let _ = viewModel.setViewDimensions(geometry.size)
                    
                    ZStack(alignment: .leading) {
                        HStack(alignment: .bottom, spacing: 0) {
                            if (viewModel.shouldShowMenu && viewModel.interfaceControlPosition == .inline) {
                                Color.clear
                                    .frame(minWidth: viewModel.shouldShowWritersView ? (380 - 36) : 275,
                                           maxWidth: viewModel.shouldShowWritersView ? (380 - 36) : 380)
                            }
                            
                            if (viewModel.shouldShowWritersView) {
                                WritersView()
                            }
                        }
                        
                        if (viewModel.shouldShowMenu) {
                            InterfaceAndControls(viewModel: interfaceAndControlsViewModel)
                                .frame(minWidth: viewModel.shouldShowWritersView ? 380 : 275,
                                       maxWidth: 380)
                                .animation(Animation.interactiveSpring().speed(0.33))
                                .transition(.move(edge: .bottom))
                        }
                    }
                }

                if (viewModel.shouldShowWritersView) {
                    MenuToggleButtons(selectedValue: $viewModel.interfaceControlPosition.animation())
                }
            }
        }
    }
}

struct AppWindowView_Previews: PreviewProvider {
    static var previews: some View {
        let _ = AppDependencyContainer.get().documentsService.setCurrentDocument(Document(documentName: "Hello There!"))
        AppWindowView()
            .frame(width: 1200.0, height: 1200.0)
    }
}
