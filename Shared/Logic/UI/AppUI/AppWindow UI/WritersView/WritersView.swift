//
//  WritersView.swift
//  Typyst
//
//  Created by Sean Wolford on 9/4/21.
//

import SwiftUI

struct WritersView: View {
    @StateObject
    var viewModel = WritersViewModel()

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if viewModel.shouldShowWebView {
                BrowserView()
                    .layoutPriority(1)
            }
            
            TypeWritersView()
        }
        .frame(maxWidth: .infinity)
    }
}

struct TypeWriterView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = WritersViewModel()
        return WritersView(viewModel: viewModel)
            .previewLayout(.fixed(width: 800, height: 1200))
            
    }
}
