//
//  WebView.swift
//  Typyst
//
//  Created by Sean Wolford on 9/11/21.
//
import Foundation
import SwiftUI
import WebKit

#if canImport(AppKit)
import AppKit
struct WebView: NSViewRepresentable {
    typealias NSViewType = WKWebView

    let webView: WKWebView

    func makeNSView(context: Context) -> WKWebView {
        return webView
    }

    func updateNSView(_ uiView: WKWebView, context: Context) { }
}

#elseif canImport(UIKit)
import UIKit
struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView

    let webView: WKWebView

    func makeUIView(context: Context) -> WKWebView {
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) { }
}
#endif
