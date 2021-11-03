//
//  RealmDocumentService.swift
//  Typyst
//
//  Created by Sean Wolford on 9/4/21.
//

import Combine
import Foundation
import RealmSwift

class RealmDocumentService: Loggable {
    private var realmService: RealmService

    init(withRealmService realmService: RealmService = RealmService()!) {
        self.realmService = realmService
    }
    
    private var documents: Results<RealmDocument>? = nil

    func createNewRealmDocument(from document: Document) -> RealmDocument? {
        let realmDocument = RealmDocument(document: document)
        let wasSaved = realmService.createObject(realmDocument)
        if wasSaved {
            let _ = fetchRealmDocuments()
        }

        return wasSaved ? realmDocument : nil
    }

    func fetchRealmDocuments() -> [Document] {
        let results = realmService.getObjects(RealmDocument.self)
        documents = results
        if let results = results { return results.map(Document.init) }
        return []
    }

    func saveRealmDocument(_ document: Document) -> Bool {
        if let realmDocument = realmService.getObject(ofType: RealmDocument.self, forPrimaryKey: document.id) {
            return realmService.saveObject(realmDocument)
        }
        
        logEvent(.warning, "Failed to find document object in realm database")
        return false
    }


    func deleteRealmDocument(_ document: Document) -> Bool {
        if let realmDocument = realmService.getObject(ofType: RealmDocument.self, forPrimaryKey: document.id) {
            return realmService.deleteObject(realmDocument)
        }
        
        logEvent(.warning, "Failed to find document object in realm database")
        return false
    }
}

class RealmDocument: RealmSwift.Object {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var documentName: String = ""
    @Persisted var dateCreated: Date = Date()
    @Persisted var dateLastOpened: Date = Date()
    @Persisted var textBody: String = ""
    var document: Document?

    func toDocument() -> Document {
        Document(id: id,
                 documentName: documentName,
                 dateCreated: dateCreated,
                 dateLastOpened: dateLastOpened,
                 textBody: textBody)
    }

    convenience init(document: Document) {
        self.init()
        self.id = document.id
        self.documentName = document.documentName
        self.dateCreated = document.dateCreated
        self.dateLastOpened = document.dateLastOpened
        self.textBody = document.textBody
        self.document = document
    }
}

extension Document {
    convenience init(documentDB: RealmDocument) {
        self.init(id: documentDB.id,
                  documentName: documentDB.documentName,
                  dateCreated: documentDB.dateCreated,
                  dateLastOpened: documentDB.dateLastOpened,
                  textBody: documentDB.textBody)
    }
}
