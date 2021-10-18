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
        if realmDocumentService.deleteRealmDocument(document) {
            documents.removeAll(where: { $0.id == document.id })
            return true
        }
        
        return false
    }

    func setCurrentDocument(_ document: Document?) {
        currentDocument = document
        webDocumentIsLoaded = false
    }

    func setWebDocument() {
        currentDocument = nil
        webDocumentIsLoaded = true
    }
}

class Document: ObservableObject, Identifiable {
    @Published var id: UUID
    @Published var documentName: String
    @Published var dateCreated: Date
    @Published var dateLastOpened: Date
    @Published var textBody: String

    init(id: UUID = UUID(),
         documentName: String,
         dateCreated: Date = Date(),
         dateLastOpened: Date = Date(),
         textBody: String = "") {
        self.id = id
        self.documentName = documentName
        self.dateCreated = dateCreated
        self.dateLastOpened = dateLastOpened
        self.textBody = textBody
    }
}

extension Document: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(documentName.hashValue)
        hasher.combine(dateCreated.hashValue)
    }
    
    static func == (lhs: Document, rhs: Document) -> Bool {
        lhs.id != rhs.id &&
        lhs.documentName != rhs.documentName &&
        lhs.dateCreated != rhs.dateCreated
    }
}
