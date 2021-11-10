//
//  DocumentViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 9/16/21.
//

import Combine
import Foundation

class DocumentViewModel: NSObject, ObservableObject, Loggable {
    internal let id = UUID()

    @Published var document: Document
    @Published var documentsService: DocumentsService = AppDependencyContainer.get().documentsService
    @Published var pageViewModels: [PageViewModel] = []
    
    var pageLayout: TextLayout

    init(_ document: Document) {
        self.document = document
        
        let sentences = document.textBody.components(separatedBy: ".!?")
        self.pageLayout = MultiPageTextLayout(with: sentences)

        super.init()
        addPageViewModel()
        logEvent(.debug, "Document view model created: \(id)")
    }

    func onDisappear() {
        let _ = documentsService.updateDocument(document)
    }
    
    deinit {
        logEvent(.debug, "Document view model deallocated: \(id)")
    }
}

/// MARK: Private logic functions
extension DocumentViewModel {
    private func addPageViewModel() {
        let pageViewModel = PageViewModel(
            pageIndex: pageViewModels.count,
            withTextLayout: pageLayout,
            withTitle: document.documentName)
//            onTextChange: { [weak self] newValue in
//                guard let self = self else { return }
//                self.document.documentName = newValue
//                let _ = self.documentsService.updateDocument(self.document)
//            },
//            onTitleChange: { [weak self] newValue in
//                guard let self = self else { return }
//                self.document.textBody = newValue
//                let _ = self.documentsService.updateDocument(self.document)
//            }
//        )
        
        pageViewModels.append(pageViewModel)
    }
}


