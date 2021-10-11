//
//  NavigationContainer.swift
//  Typyst
//
//  Created by Sean Wolford on 9/16/21.
//

import SwiftUI
#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

struct NavigationContainer<Content: View>: View {
    @State private var navBarHidden: Bool = true
    var content: Content

    init(_ content: () -> Content) {
        self.content = content()
    }

    #if os(iOS)
    var body: some View {
        NavigationView() {
            content
        }
            .navigationBarTitle("")
            .navigationBarHidden(navBarHidden)
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                self.navBarHidden = true
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                self.navBarHidden = false
            }
    }
    #elseif os(macOS)
    var body: some View {
        NavigationView() {
            Text("")
            content
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
    #endif
}

struct NavigationContainer_Previews: PreviewProvider {
    static var previews: some View {
        NavigationContainer() { Text("") }
    }
}
