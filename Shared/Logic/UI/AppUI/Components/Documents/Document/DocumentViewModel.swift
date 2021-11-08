//
//  DocumentViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 9/16/21.
//

import Combine
import Foundation
import AppKit

class DocumentViewModel: NSObject, ObservableObject, Loggable {
    @Published var document: Document
    @Published var documentsService: DocumentsService = AppDependencyContainer.get().documentsService
    @Published var pageViewModels: [PageViewModel] = []

    @Published var currentPageXOffset: CGFloat = 0.0
    @Published var currentPageYOffset: CGFloat = 0.0
    
    @Published var pageLayout: MultiPageTextLayout

    init(_ document: Document) {
        self.document = document
        self.pageLayout = MultiPageTextLayout()
        super.init()
        
        let sentences = document.textBody.components(separatedBy: ".?")
        
        pageLayout.setup(sentences, storageDelegate: self, layoutManagerDelegate: self)

        addPageViewModel()
    }

    func onDisappear() {
        let _ = documentsService.updateDocument(document)
    }
}

/// MARK: Private logic functions
extension DocumentViewModel {
    private var shouldCreateTitleTextContainer: Bool {
        pageViewModels.count == 0
    }
    
    
    private func calculatePageOffsets(cursorFrame: CGRect, textViewFrame: CGRect) -> (xOffset: CGFloat, yOffset: CGFloat) {
        let startingXoffset = textViewFrame.width / 2
        let endingXOffset = startingXoffset - cursorFrame.origin.x
        
        let startingYoffset = textViewFrame.width
        let endingYOffset = startingYoffset - cursorFrame.height
        
        return (endingXOffset, endingYOffset)
    }
    
    private func addPageViewModel() {
        let titleContainer = shouldCreateTitleTextContainer ? pageLayout.createAndAddNewTextContainer() : nil
        let textContainer = pageLayout.createAndAddNewTextContainer()
        
        let pageViewModel = PageViewModel(
            withTextTextContainer: textContainer,
            withTitleTextContainer: titleContainer,
            onTextChange: { [weak self] newValue in
                guard let self = self else { return }
                self.document.documentName = newValue
                let _ = self.documentsService.updateDocument(self.document)
            },
            onTitleChange: { [weak self] newValue in
                guard let self = self else { return }
                self.document.textBody = newValue
                let _ = self.documentsService.updateDocument(self.document)
            },
            onCursorPositionChanged: { [weak self] (cursorFrame, textViewFrame) in
                guard let self = self else { return }
                
                let results = self.calculatePageOffsets(cursorFrame: cursorFrame,
                                                        textViewFrame: textViewFrame)
                
                self.currentPageXOffset = results.xOffset
                self.currentPageYOffset = results.yOffset
            }
        )
        
        pageViewModels.append(pageViewModel)
    }
}

extension DocumentViewModel: NSTextStorageDelegate {
    
}

extension DocumentViewModel: NSLayoutManagerDelegate {
    
}
