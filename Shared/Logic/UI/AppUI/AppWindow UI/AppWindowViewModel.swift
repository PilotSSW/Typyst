//
//  AppWindowViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 9/5/21.
//

import Combine
import Foundation
import struct SwiftUI.CGSize

class AppWindowViewModel: ObservableObject {
    private var store = Set<AnyCancellable>()
    
    // Services
    private let documentsService: DocumentsService = AppDependencyContainer.get().documentsService
    @Published var currentDocument: Document? = nil
    
    // View properties
    @Published var showMenu: Bool = true
    private(set) var viewDimensions: CGSize = CGSize(width: 0, height: 0)

    var shouldShowMenu: Bool {
        if viewDimensions.width <= 380 { return true }
        
        return showMenu
    }
    
    var shouldShowTypeWriterView: Bool {
        if OSHelper.runtimeEnvironment == .ipadOS { return true }
        else if OSHelper.runtimeEnvironment == .macOS {
            if viewDimensions.width > 380 { return true }
        }

        return false
    }

    init() {
        documentsService.$currentDocument
            .sink { [weak self] currentDocument in
                self?.currentDocument = currentDocument
            }
            .store(in: &store)
    }

    func setViewDimensions(_ dimensions: CGSize) {
        viewDimensions = dimensions
    }
}