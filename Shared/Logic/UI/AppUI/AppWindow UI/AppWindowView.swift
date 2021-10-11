//
//  AppWindowView.swift
//  Typyst
//
//  Created by Sean Wolford on 9/4/21.
//

import SwiftUI

struct AppWindowView: View {
    @StateObject var viewModel = AppWindowViewModel()

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
                    HStack() {
                        if (viewModel.shouldShowMenu) {
                            InterfaceAndControls()
                                .layoutPriority(1)
                                .transition(.move(edge: .leading))
                                .animation(.interactiveSpring()
                                            .speed(0.5)
                                    .delay(0.03))
                        }
                    
                        if ([.ipadOS, .macOS].contains(OSHelper.runtimeEnvironment) &&
                           viewModel.shouldShowTypeWriterView) {
                            TypeWriterView()
                                .frame(maxWidth: .infinity)
                        }
                    }
                    
                    MenuToggleButton(toggleState: $viewModel.showMenu)
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
