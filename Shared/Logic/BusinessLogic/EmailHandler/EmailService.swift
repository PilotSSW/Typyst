
//
//  EmailHandler.swift
//  Typyst (iOS)
//
//  Created by Sean Wolford on 6/11/21.
//

import Foundation

#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#endif

struct EmailService {
    func emailDeveloper() {
        if let mailtoString = "mailto:support@typyst.app".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let mailtoUrl = URL(string: mailtoString) {
            #if os(iOS)
            UIApplication.shared.open(mailtoUrl)
            #elseif os(macOS)
            NSWorkspace.shared.open(mailtoUrl)
            #endif
        }
    }
}
