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

    @Published
    var document: Document

    @Published
    var documentsService: DocumentsService = AppDependencyContainer.get().documentsService

    @Published
    var pageViewModels: [PageViewModel] = []

    init(_ document: Document) {
        self.document = document
        
        setupPageViewModel()

//        document.$textBody
//            .sink { [weak self] updatedTextBody in
//                guard let self = self else { return }
//                self.handleTextChanges(updatedTextBody)
//            }
//            .store(in: &store)

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
                self.documentsService.updateDocument(self.document)
            }
            .store(in: &store)
        
        pageViewModel.$text
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newValue in
                guard let self = self else { return }
                self.document.textBody = newValue
                self.documentsService.updateDocument(self.document)
            }
        .store(in: &store)
        
        pageViewModels.append(pageViewModel)
    }
}

/// MARK: Private logic functions
extension DocumentViewModel {
//    private func calculateNumberOfPages(textBody: String) -> Int {
//        max(1, Int(textBody.count / 500) + 1)
//    }
//
//    private func updatePageViewModels(_ numPages: Int) {
//        if numPages > pageViewModels.count {
//            let text = document.textBody
//
//            for _ in 1...numPages {
//                let startingIndex = pageViewModels.count * 500
//                let endingIndex = min(text.substring(from: startingIndex).count, 500)
//                let newText = text.substring(with: startingIndex..<endingIndex)
//                let vm = PageViewModel(withText: newText)
//                pageViewModels.append(vm)
//
//                logEvent(.trace, "new page added!")
//            }
//        }
//        else if numPages < pageViewModels.count {
//            let numPageRemove = numPages - pageViewModels.count
//            pageViewModels.removeLast(numPageRemove)
//        }
//        else {
//            logEvent(.trace, "No page updates :/")
//        }
//    }
//
//    private func handleTextChanges(_ textBody: String) {
//        let numPages = self.calculateNumberOfPages(textBody: textBody)
//
//        if numPages != pageViewModels.count {
//            logEvent(.trace, "Handle the text changes! \(numPages)")
//            updatePageViewModels(numPages)
//        }
//        else {
//            logEvent(.trace, "Or don't handle the text changes! \(numPages)")
//        }
//    }
}
