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
        if let _ = realmDocumentService?.createNewRealmDocument(from: document) {
            documents.append(document)
            return document
        }

        if shouldSetCurrentDocument {
            setCurrentDocument(document)
        }

        return nil
    }

    func fetchDocuments() -> [Document] {
        let realmDocuments = realmDocumentService?
            .fetchRealmDocuments()
            .map(Document.init)

        documents = realmDocuments ?? []
        return documents
    }

    func updateDocument(_ document: Document) -> Bool {
        realmDocumentService?.saveDocument(document) ?? false
    }

    func deleteDocument(_ document: Document) -> Bool {
        realmDocumentService?.deleteDocument(document) ?? false
    }

    func setCurrentDocument(_ document: Document) {
        currentDocument = document
        webDocumentIsLoaded = false
    }

    func setWebDocument() {
        currentDocument = nil
        webDocumentIsLoaded = true
    }
}

class Document: ObservableObject, Identifiable {
    @Published var id: Int
    @Published var documentName: String
    @Published var dateCreated: Date
    @Published var dateLastOpened: Date
    @Published var textBody: String

    init(id: Int = UUID().hashValue,
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
