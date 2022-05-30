//
//  DocumentsService.swift
//  Typyst
//
//  Created by Sean Wolford on 8/29/21.
//

import Foundation

class DocumentsService: ObservableObject {
    private var realmDocumentService = RealmDocumentService()

    @Published private(set) var webDocumentIsLoaded: Bool = false {
        didSet { if webDocumentIsLoaded { currentDocument = nil }}
    }
    @Published private(set) var currentDocument: Document? = nil
    @Published private(set) var documents: [Document] = []
    @Published private(set) var services = []

    func createNewDocument(withName name: String = "",
                           shouldSetCurrentDocument: Bool = true) -> Document? {
        let document = Document(documentName: name)
        if let _ = realmDocumentService.createNewRealmDocument(from: document) {
            documents.append(document)
            return document
        }

        if shouldSetCurrentDocument {
            setCurrentDocument(document)
        }

        return nil
    }

    func fetchDocuments() -> [Document] {
        documents = realmDocumentService
            .fetchRealmDocuments()
        
        return documents
    }

    func updateDocument(_ document: Document) -> Bool {
        realmDocumentService.saveRealmDocument(document)
    }

    func deleteDocument(_ document: Document) -> Bool {
        // Case: Is a persisted document
        if realmDocumentService.hasRealmDocument(withID: document.id) &&
           realmDocumentService.deleteRealmDocument(document) {
            documents.removeAll(where: { $0.id == document.id })
            return true
        }
        // Case: Is a newly created document that is not yet saved in realm
        else if let indexOfDocumentWithPrimaryKey = documents.firstIndex(where: { $0.id == document.id }) {
            documents.remove(at: indexOfDocumentWithPrimaryKey)
            
            return true
        }
        
        return false
    }

    func setCurrentDocument(_ document: Document?) {
        if currentDocument?.id == document?.id { return }
        
        currentDocument = document
        webDocumentIsLoaded = false
    }

    func setWebDocument() {
//        if webDocumentIsLoaded { return }
        
        currentDocument = nil
        webDocumentIsLoaded = true
    }
}


