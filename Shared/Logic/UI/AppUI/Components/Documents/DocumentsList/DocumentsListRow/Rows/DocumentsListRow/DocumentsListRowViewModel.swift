//
//  DocumentsListRowViewModel.swift
//  Typyst
//
//  Created by Sean Wolford on 11/19/21.
//

import Combine
import Foundation

class DocumentsListRowViewModel: ObservableObject {
    private let id = UUID()
    private var store = Set<AnyCancellable>()
    
    private var documentsService: DocumentsService
    private(set) var document: Document

    lazy var onSelect: (() -> Void) = { [weak self] in
        guard let self = self else { return }
        let _ = self.documentsService.setCurrentDocument(self.document)
        self.isSelected = true
    }
    
    lazy var onDeselect: (() -> Void) = { [weak self] in
        guard let self = self else { return }
        let _ = self.documentsService.setCurrentDocument(nil)
        self.isSelected = false
    }
    
    @Published var isSelected: Bool = false
    
    init(document: Document,
         documentsService: DocumentsService = AppDependencyContainer.get().documentsService
    ) {
        self.document = document
        self.documentsService = documentsService
        
        documentsService.$currentDocument
            .sink { [weak self] newSelectedDocument in
                guard let self = self else { return }
                if newSelectedDocument?.id != document.id {
                    self.isSelected = false
                }
            }
            .store(in: &store)
    }
    
    
    var documentName: String {
        document.documentName
    }
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M-dd-yyyy, h:mm:p"
        
        return dateFormatter.string(from: document.dateLastOpened)
    }
}
