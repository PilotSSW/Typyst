//
//  BrowserView.swift
//  Typyst
//
//  Created by Sean Wolford on 9/11/21.
//

import SwiftUI

struct BrowserView: View {
    @StateObject var model = WebViewModel()

    var body: some View {
        WebView(webView: model.webView)
            .onAppear() {
                // Hide Keyboard
                #if canImport(UIKit)
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                #endif
            }
    }
}

struct BrowserView_Previews: PreviewProvider {
    static var previews: some View {
        BrowserView()
    }
}
