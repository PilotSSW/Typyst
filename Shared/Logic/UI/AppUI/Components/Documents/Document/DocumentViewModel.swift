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

        document.$textBody
            .sink { [weak self] updatedTextBody in
                guard let self = self else { return }
                self.handleTextChanges(updatedTextBody)
            }
            .store(in: &store)
    }

    func onDisappear() {
        let _ = documentsService.updateDocument(document)
    }
}

/// MARK: Private logic functions
extension DocumentViewModel {
    private func calculateNumberOfPages(textBody: String) -> Int {
        max(1, Int(textBody.count / 500) + 1)
    }

    private func updatePageViewModels(_ numPages: Int) {
        if numPages > pageViewModels.count {
            let text = document.textBody

            for _ in 1...numPages {
                let startingIndex = pageViewModels.count * 500
                let endingIndex = min(text.substring(from: startingIndex).count, 500)
                let newText = text.substring(with: startingIndex..<endingIndex)
                let vm = PageViewModel(withText: newText)
                pageViewModels.append(vm)

                logEvent(.trace, "new page added!")
            }
        }
        else if numPages < pageViewModels.count {
            let numPageRemove = numPages - pageViewModels.count
            pageViewModels.removeLast(numPageRemove)
        }
        else {
            logEvent(.trace, "No page updates :/")
        }
    }

    private func handleTextChanges(_ textBody: String) {
        let numPages = self.calculateNumberOfPages(textBody: textBody)

        if numPages != pageViewModels.count {
            logEvent(.trace, "Handle the text changes! \(numPages)")
            updatePageViewModels(numPages)
        }
        else {
            logEvent(.trace, "Or don't handle the text changes! \(numPages)")
        }
    }
}
