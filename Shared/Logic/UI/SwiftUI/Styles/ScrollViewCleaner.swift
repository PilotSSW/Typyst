//
//  ScrollViewCleaner.swift
//  Typyst
//
//  Created by Sean Wolford on 9/30/21.
//

import Foundation
import SwiftUI

struct ScrollViewCleaner: NSViewRepresentable {

    func makeNSView(context: NSViewRepresentableContext<ScrollViewCleaner>) -> NSView {
        let nsView = NSView()
        DispatchQueue.main.async { // on next event nsView will be in view hierarchy
            if let scrollView = nsView.enclosingScrollView {
                scrollView.drawsBackground = false
            }
        }
        return nsView
    }

    func updateNSView(_ nsView: NSView, context: NSViewRepresentableContext<ScrollViewCleaner>) {}
}
