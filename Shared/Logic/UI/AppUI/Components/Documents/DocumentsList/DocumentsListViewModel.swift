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

    init(isFullyExpanded: Bool = false) {
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
    
    func deleteDocument(at offsets: IndexSet) {
        for offset in offsets {
            if let document = documents[safe: offset] {
                deleteDocument(document)
            }
        }
    }
    
    @Published private(set) var headerHeight: CGFloat = 20
    @Published private(set) var rowHeight: CGFloat = 25
    @Published var isFullyExpanded: Bool = false
    var minHeight: CGFloat {
        isFullyExpanded
            ? CGFloat(documents.count) * rowHeight + 300
            : 300
    }
}
