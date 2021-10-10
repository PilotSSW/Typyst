//
//  TypeWriterInfoModalViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 10/9/21.
//

import AppKit
import Combine
import Foundation

class TypeWriterInfoModalViewModel: ObservableObject, Loggable {
    private var currentViewSize: CGRect = CGRect(origin: .zero, size: CGSize(width: 0, height: 0))
    @Published var minWidth: CGFloat = 100
    @Published var idealWidth: CGFloat = 600
    @Published var maxWidth: CGFloat = 800
    @Published var minHeight: CGFloat = 100
    @Published var idealHeight: CGFloat = 600
    @Published var maxHeight: CGFloat = 800
    
//    init() {
//        super.init()
//        NSApp.mainWindow?.delegate = self
//    }
    
    func windowSizeUpdated(withFrame frame: CGRect) {
        if currentViewSize.height == frame.height && currentViewSize.width == frame.width { return }
        
        let height = frame.height
        let width = frame.width
        if width <= 100 || height <= 100 { return }
        windowSizeUpdated(withSize: CGSize(width: width, height: height))
        
        currentViewSize = frame
    }
    
    func windowSizeUpdated(withSize size: CGSize) {
        minWidth = max(350, size.width * 0.25)
        idealWidth = max(350, size.width * 0.75)
        maxWidth = max(350, size.width * 0.9)
        minHeight = max(350, size.height * 0.25)
        idealHeight = max(350, size.height * 0.75)
        maxHeight = max(350, size.height * 0.9)
    }
}

//extension TypeWriterInfoModalViewModel: NSWindowDelegate {
//    func windowDidResize(_ notification: Notification) {
//        print(notification.object)
//        print("Breakpoint")
//
//        if let window = notification.object as? NSWindow {
//            windowSizeUpdated(withFrame: window.frame)
//        }
//        else {
//            logEvent(.warning, "Unable to resize modal")
//        }
//    }
//}
