//
//  WebViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 9/11/21.
//

import Combine
import Foundation
import WebKit

class WebViewModel: ObservableObject {
    private var store = Set<AnyCancellable>()
    let webView: WKWebView

    @Published private(set) var url: URL
    @Published var canGoBack: Bool = false
    @Published var canGoForward: Bool = false

    init(withUrl url: URL? = nil) {
        webView = WKWebView(frame: .zero,
                            configuration: WebViewModel.getConsoleListenerConfiguration())

        if let url = url {
            self.url = url
        }
        else {
            self.url = URL(string: "https://docs.google.com/document/u/0/")!
        }

        $url.sink { [weak self] newUrl in
            self?.loadUrl(newUrl)
        }
        .store(in: &store)
    }

    private func setupBindings() {
        webView.publisher(for: \.canGoBack)
            .assign(to: &$canGoBack)

        webView.publisher(for: \.canGoForward)
            .assign(to: &$canGoForward)
    }

    func loadUrl(_ url: URL) {
        webView.load(URLRequest(url: url))
    }
}

extension WebViewModel {
        //    private func setupConsoleListener() {
        //        let source = "function captureLog(msg) { window.webkit.messageHandlers.logHandler.postMessage(msg); } window.console.log = captureLog;"
        //        let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        //        webView.configuration.userContentController.addUserScript(script)
        //            // register the bridge script that listens for the output
        //        webView.configuration.userContentController.add(self, name: "logHandler")
        //    }

    private static func getConsoleListenerConfiguration() -> WKWebViewConfiguration {
        let loggingMessageHandler = LoggingMessageHandler()

        let userContentController = WKUserContentController()
        userContentController.add(loggingMessageHandler, name: "logging")
        userContentController.addUserScript(WKUserScript(source: loggingMessageHandler.overrideConsole,
                                                         injectionTime: .atDocumentStart,
                                                         forMainFrameOnly: true))

        let webViewConfig = WKWebViewConfiguration()
        webViewConfig.userContentController = userContentController

        return webViewConfig
    }
}

class LoggingMessageHandler: NSObject, WKScriptMessageHandler, Loggable {
    let overrideConsole = """
        function log(emoji, type, args) {
          window.webkit.messageHandlers.logging.postMessage(
            `${emoji} JS ${type}: ${Object.values(args)
              .map(v => typeof(v) === "undefined" ? "undefined" : typeof(v) === "object" ? JSON.stringify(v) : v.toString())
              .map(v => v.substring(0, 3000)) // Limit msg to 3000 chars
              .join(", ")}`
          )
        }

        let originalLog = console.log
        let originalWarn = console.warn
        let originalError = console.error
        let originalDebug = console.debug

        console.log = function() { log("📗", "log", arguments); originalLog.apply(null, arguments) }
        console.warn = function() { log("📙", "warning", arguments); originalWarn.apply(null, arguments) }
        console.error = function() { log("📕", "error", arguments); originalError.apply(null, arguments) }
        console.debug = function() { log("📘", "debug", arguments); originalDebug.apply(null, arguments) }

        window.addEventListener("error", function(e) {
           log("💥", "Uncaught", [`${e.message} at ${e.filename}:${e.lineno}:${e.colno}`])
        })
    """

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        logEvent(.info,
                 """
                 In-app browser console message
                 \(message)
                 """)
    }
}
