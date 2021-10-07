//
//  DocumentsSListViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 8/27/21.
//

import Combine
import Foundation
#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

class DocumentsListViewModel: ObservableObject {
    private var store = Set<AnyCancellable>()
    private var documentsService: DocumentsService = AppDependencyContainer.get().documentsService
    @Published var documents: [Document]

    init() {
        documents = documentsService.fetchDocuments()
        documentsService.$documents
            .sink { [weak self] documents in
                guard let self = self else { return }
                self.documents = documents
            }
            .store(in: &store)
    }

    func deleteDocument(_ document: Document) {
        let _ = documentsService.deleteDocument(document)
    }
}
