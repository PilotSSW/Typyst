
//
//  EmailHandler.swift
//  Typyst (iOS)
//
//  Created by Sean Wolford on 6/11/21.
//

import Foundation
import GBDeviceInfo

#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#endif

struct EmailService {
    func emailDeveloper() {
        let deviceInfo = GBDeviceInfo.deviceInfo()!

        let body =
        """
        Hey there, I am having some problems with Typyst. I am experiencing ...


        Here are my machine's specs: \n
        \(String(describing: deviceInfo))
        """
        let subject = "Email Support for Typyst"
        let link = "mailto:support@typyst.app?subject=\(subject)&body=\(body)"

        if let mailtoString = link.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let mailtoUrl = URL(string: mailtoString) {
            #if os(iOS)
            UIApplication.shared.open(mailtoUrl)
            #elseif os(macOS)
            NSWorkspace.shared.open(mailtoUrl)
            #endif
        }
    }
}
