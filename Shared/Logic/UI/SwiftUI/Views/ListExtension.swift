//
//  ListExtension.swift
//  Typyst
//
//  Created by Sean Wolford on 10/12/21.
//

import Foundation
import Introspect
import SwiftUI

extension List {
    /// List on macOS uses an opaque background with no option for
    /// removing/changing it. listRowBackground() doesn't work either.
    /// This workaround works because List is backed by NSTableView.
    func removeBackground() -> some View {
        introspectTableView { tableView in
            tableView.backgroundColor = .clear
            if let scrollView = tableView.enclosingScrollView {
                scrollView.drawsBackground = false
            }
        }
        .introspectTableViewCell { cell in
            print(cell.superview)
        }
        .introspectScrollView { scrollView in
            scrollView.drawsBackground = false
            scrollView.backgroundColor = .clear
        }
    }
}
