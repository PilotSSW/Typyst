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
    
    private var documents: [RealmDocument] = []

    func createNewRealmDocument(from document: Document) -> RealmDocument? {
        let realmDocument = document.toRealmDocument()
        let wasSaved = realmService.createObject(realmDocument)
        if wasSaved {
            documents.append(realmDocument)
        }

        return wasSaved ? realmDocument : nil
    }

    func fetchRealmDocuments() -> [RealmDocument] {
        documents = realmService.getObjects(ofType: RealmDocument).sorted(by: { $0.documentName < $0.documentName })
        return documents
    }

    func saveDocument(_ document: Document) -> Bool {
        if let realmDocument = documents.first(where: { $0.id == document.id })  {
            return realmService.saveObject(realmDocument)
        }
        
        logEvent(.warning, "Failed to find document object in realm database")
        return false
    }


    func deleteDocument(_ document: Document) -> Bool {
        if let realmDocument = documents.first(where: { $0.id == document.id })  {
            return realmService.deleteObject(realmDocument)
        }
        
        logEvent(.warning, "Failed to find document object in realm database")
        return false
    }
}

class RealmDocument: Object {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var documentName: String = ""
    @Persisted var dateCreated: Date = Date()
    @Persisted var dateLastOpened: Date = Date()
    @Persisted var textBody: String = ""

    func toDocument() -> Document {
        Document(id: id,
                 documentName: documentName,
                 dateCreated: dateCreated,
                 dateLastOpened: dateLastOpened,
                 textBody: textBody)
    }
//
//    convenience init(document: Document) {
//        self.init(id: document.id,
//                  documentName: document.documentName,
//                  dateCreated: document.dateCreated,
//                  dateLastOpened: document.dateLastOpened,
//                  textBody: document.textBody)
//    }
}

extension Document {
    convenience init(documentDB: RealmDocument) {
        self.init(id: documentDB.id,
                  documentName: documentDB.documentName,
                  dateCreated: documentDB.dateCreated,
                  dateLastOpened: documentDB.dateLastOpened,
                  textBody: documentDB.textBody)
    }

    fileprivate func toRealmDocument() -> RealmDocument {
        let doc = RealmDocument()
        doc.id = id
        doc.documentName = documentName
        doc.dateCreated = dateCreated
        doc.dateLastOpened = dateLastOpened
        doc.textBody = textBody

        return doc
    }
}
