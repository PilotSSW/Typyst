//
//  AppWindowViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 9/5/21.
//

import Combine
import Foundation
import struct SwiftUI.CGSize

class AppWindowViewModel: ObservableObject, Loggable {
    private var store = Set<AnyCancellable>()
    
    /// Services
    private let documentsService: DocumentsService = AppDependencyContainer.get().documentsService
    @Published var currentDocument: Document? = nil
    
    /// View properties
    enum InterfaceControlPosition {
        case closed
        case inline
        case above
    }
    @Published var interfaceControlPosition: InterfaceControlPosition = .above
    
    private(set) var compactWidth: CGFloat = 380
    private(set) var viewDimensions: CGSize = CGSize(width: 0, height: 0)
    @Published var shouldShowMenu: Bool = true
    @Published var shouldShowMenuPositionControls: Bool = true
    @Published var shouldShowTypeWriterView: Bool = true

    init() {
        documentsService.$currentDocument
            .sink { [weak self] currentDocument in
                self?.currentDocument = currentDocument
            }
            .store(in: &store)
        
        $interfaceControlPosition
            .sink{ [weak self] currentPosition in
                guard let self = self else { return }
                self.setLayoutProperties(for: currentPosition)
            }
            .store(in: &store)
    }

    func setViewDimensions(_ dimensions: CGSize) {
        let currentViewSizeIsCompact = viewDimensions.width <= compactWidth
        let newViewSizeIsCompact = dimensions.width <= compactWidth
        let sizeHasChanged = (currentViewSizeIsCompact != newViewSizeIsCompact)
        if (!sizeHasChanged) { return }
        
        logEvent(.debug, "Updating layout for window size change")
        
        viewDimensions = dimensions
        setLayoutProperties(for: interfaceControlPosition)
    }
}

/// MARK: Private logic functions
extension AppWindowViewModel {
    private func setLayoutProperties(for interfaceControlPosition: AppWindowViewModel.InterfaceControlPosition) {
        shouldShowMenu = setShouldShowMenu(for: interfaceControlPosition)
        shouldShowTypeWriterView = setShouldShowTypeWriterView()
        shouldShowMenuPositionControls = shouldShowTypeWriterView
    }
    
    private func setShouldShowMenu(for interfaceControlPosition: AppWindowViewModel.InterfaceControlPosition) -> Bool {
        if viewDimensions.width <= compactWidth { return true }
        
        return [.above, .inline].contains(interfaceControlPosition)
    }
        
    private func setShouldShowTypeWriterView() -> Bool {
        return viewDimensions.width > compactWidth
    }
}
