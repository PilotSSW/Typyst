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
        GeometryReader { geometry in
            let _ = viewModel.setViewDimensions(geometry.size)

            HStack(spacing: 0) {
                #if os(iOS)
                if OSHelper.runtimeEnvironment == .iOS {
                    NavigationContainer {
                        InterfaceAndControls()
                    }
                        .layoutPriority(1)
                }
                else {
                    InterfaceAndControls()
                        .layoutPriority(1)
                }
                #elseif os(macOS)
                InterfaceAndControls()
                    .layoutPriority(1)
                #endif

                if (viewModel.shouldShowTypeWriterView) {
                    TypeWriterView()
                        .frame(maxWidth: .infinity)
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
