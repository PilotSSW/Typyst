//
//  AppWindowViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 9/5/21.
//

import Combine
import struct CoreGraphics.CGFloat
import struct CoreGraphics.CGSize
import Foundation

class AppWindowViewModel: ObservableObject, Loggable {
//    private var store = Set<AnyCancellable>()
    
    /// View properties
    enum InterfaceControlPosition {
        case closed
        case inline
        case above
    }
    @Published var interfaceControlPosition: InterfaceControlPosition = .inline {
        didSet {
            setLayoutProperties(for: interfaceControlPosition)
        }
    }
    
    private(set) var compactWidth: CGFloat = 380
    private(set) var viewDimensions: CGSize = CGSize(width: 0, height: 0)
    @Published var shouldShowMenu: Bool = true
    @Published var shouldShowMenuPositionControls: Bool = true
    @Published var shouldShowWritersView: Bool = true

    init() {

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
        shouldShowWritersView = setShouldShowWritersView()
        shouldShowMenuPositionControls = shouldShowWritersView
    }
    
    private func setShouldShowMenu(for interfaceControlPosition: AppWindowViewModel.InterfaceControlPosition) -> Bool {
        if viewDimensions.width <= compactWidth { return true }
        
        return [.above, .inline].contains(interfaceControlPosition)
    }
        
    private func setShouldShowWritersView() -> Bool {
        viewDimensions.width > compactWidth
    }
}
