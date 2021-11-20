//
//  CurrentPageEditorViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 11/11/21.
//

import Combine
import Foundation

class CurrentPageEditorViewModel: ObservableObject, Identifiable, Loggable {
    internal let id = UUID()
    
    var documentTextLayout: MultiPageTextLayout
    @Published var currentPageViewModel: PageViewModel
    @Published private(set) var currentCursorPosition: CGPoint = CGPoint(x: 0, y: 0)
    
    @Published private(set) var viewWidth: CGFloat = 0.0
    @Published private(set) var viewHeight: CGFloat = 0.0
    
    @Published private(set) var xOffset: CGFloat = -500.0
    @Published private(set) var yOffset: CGFloat = 3000.0
    
    @Published private(set) var timeToLoadPage: Double = 0.5
    @Published private(set) var hasAppeared: Bool = false {
        didSet {
            if !hasAppeared { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + timeToLoadPage, execute: { [weak self] in
                self?.setPageOffsets()
            })
        }
    }
    
    init(layout: MultiPageTextLayout,
         currentPageViewModel: PageViewModel
    ) {
        self.documentTextLayout = layout
        self.currentPageViewModel = currentPageViewModel
        
        documentTextLayout.addDelegate(self)
                
        logEvent(.trace, "Current page editor viewModel created: \(id)")
    }
    
    deinit {
        documentTextLayout.removeDelegate(self)
    }
    
    func onAppear() {
        currentPageViewModel.setIsEditorPage(true)
        
        hasAppeared = true
    }
        
    func onDisappear() {
        currentPageViewModel.setIsEditorPage(false)
    }
    
    func viewSizeUpdated(_ size: CGSize) {
        var shouldUpdateOffsets = false
        
        if size.width != viewWidth {
            viewWidth = size.width
            shouldUpdateOffsets = true
        }
        
        if size.height != viewHeight {
            viewHeight = size.height
            shouldUpdateOffsets = true
        }
        
        if shouldUpdateOffsets {
            setPageOffsets()
        }
    }
}

/// MARK: Private functions
extension CurrentPageEditorViewModel {
    private func calculatePageOffsets() -> (xOffset: CGFloat, yOffset: CGFloat) {
        let textArea = currentPageViewModel.usableTextArea
        let textAreaWidth = textArea.width
        let textAreaHeight = textArea.height
        
        let viewCenterX = viewWidth / 2
        
        let documentXOffset: CGFloat = (textAreaWidth / 2)
        let documentYOffset: CGFloat = 10//(textAreaHeight / 6)
        
        // 1. Center document horizontally right in the middle
        // 2. Add half the textArea width to offset it to the right - aligned at left margin
        // 3. Then shift left by the current cursor placement
        let xOffset = viewCenterX + documentXOffset - currentCursorPosition.x
        
        // 1. Move the document all the way down, beneath the view
        // 2. Move up by half the document height
        // 3. Move up again by the cursor's current line / height in the textArea
        let yOffset = viewHeight - documentYOffset - currentCursorPosition.y
        
        return (xOffset, yOffset)
    }
    
    private func setPageOffsets() {
        let newOffsets = calculatePageOffsets()
        
        if newOffsets.xOffset != xOffset {
            xOffset = newOffsets.xOffset
        }
        
        if newOffsets.yOffset != yOffset {
            yOffset = newOffsets.yOffset
        }
    }
}

extension CurrentPageEditorViewModel: MultiPageTextLayoutDelegate {
    
    // TODO: Fix delegate listener for cursor position
    // Delegate func not currently working -- need to get cursor position manually
    func cursorPositionUpdated(_ point: CGPoint?) {
//        if let newCursorPosition = point {
//            self.currentCursorPosition = newCursorPosition
//            self.setPageOffsets()
//        }
    }
    
    func textWasUpdated(_ text: String) {
        if let textView = currentPageViewModel.pageLayoutViewModel.textView,
           let newCursorPosition = documentTextLayout.getCursorPositionInTextView(textView) {
            currentCursorPosition = newCursorPosition
            setPageOffsets()
        }
    }
}
