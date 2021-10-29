//
//  DocumentViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 9/16/21.
//

import Combine
import Foundation

class DocumentViewModel: ObservableObject, Loggable {
    private var store = Set<AnyCancellable>()

    @Published var document: Document
    @Published var documentsService: DocumentsService = AppDependencyContainer.get().documentsService
    @Published var pageViewModels: [PageViewModel] = []

    @Published var currentPageXOffset: CGFloat = 0.0
    @Published var currentPageYOffset: CGFloat = 0.0
    

    init(_ document: Document) {
        self.document = document
        
        setupPageViewModel()
    }

    func onDisappear() {
        let _ = documentsService.updateDocument(document)
    }
}

extension DocumentViewModel {
    private func setupPageViewModel() {
        let pageViewModel = PageViewModel(withText: document.textBody,
                                          withTitle: document.documentName)
        pageViewModel.$title
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newValue in
                guard let self = self else { return }
                self.document.documentName = newValue
                let _ = self.documentsService.updateDocument(self.document)
            }
            .store(in: &store)
        
        pageViewModel.$text
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newValue in
                guard let self = self else { return }
                self.document.textBody = newValue
                let _ = self.documentsService.updateDocument(self.document)
            }
        .store(in: &store)
        
        pageViewModel.onCursorPositionChanged = { [weak self] (cursorFrame, textViewFrame) in
            guard let self = self else { return }
            
            let results = self.calculatePageOffsets(cursorFrame: cursorFrame,
                                                    textViewFrame: textViewFrame)
            
            self.currentPageXOffset = results.xOffset
            self.currentPageYOffset = results.yOffset
        }
        
        pageViewModels.append(pageViewModel)
    }
}

/// MARK: Private logic functions
extension DocumentViewModel {
    private func calculatePageOffsets(cursorFrame: CGRect, textViewFrame: CGRect) -> (xOffset: CGFloat, yOffset: CGFloat) {
        let startingXoffset = textViewFrame.width / 2
        let endingXOffset = startingXoffset - cursorFrame.origin.x
        
        let startingYoffset = textViewFrame.width
        let endingYOffset = startingYoffset - cursorFrame.height
        
        return (endingXOffset, endingYOffset)
    }
}
