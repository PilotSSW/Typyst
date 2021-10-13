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
            GeometryReader { geometry in
                let _ = viewModel.setViewDimensions(geometry.size)

                ZStack(alignment: .bottomLeading) {
                    ZStack(alignment: .leading) {
                        if (viewModel.shouldShowTypeWriterView) {
                            TypeWriterView()
                                .frame(maxWidth: .infinity)
                        }
                        
                        if (viewModel.shouldShowMenu) {
                            InterfaceAndControls(viewModel: interfaceAndControlsViewModel)
                                .layoutPriority(1)
                                .transition(.move(edge: .leading))
                        }
                    }
                    
                    if (viewModel.shouldShowTypeWriterView) {
                        MenuToggleButton(toggleState: $viewModel.showMenu)
                    }
                }
            }
        }
    }
}

struct AppWindowView_Previews: PreviewProvider {
    static var previews: some View {
        AppWindowView()
            .previewLayout(.sizeThatFits)
    }
}
