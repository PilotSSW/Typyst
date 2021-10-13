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
    private var realm: Realm!

    init?() {
        do {
//            if let url = Bundle.main.url(forResource: "typyst", withExtension: "realm") {
//                let config = Realm.Configuration(fileURL: url)
//                self.realm = try Realm(configuration: config)
//            }
//            else {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true) //Realm.Configuration(schemaVersion: 1)
            self.realm = try Realm(configuration: config)
//            }
        }
        catch(let error) {
            print(error)
            logEvent(.error, "Unable to create a Realm store for RealmDocumentService", error: error)

            return nil
        }
    }

    func createNewRealmDocument(from document: Document) -> RealmDocument? {
        let realmDocument = document.toRealmDocument()
        let wasSaved = saveRealmDocument(realmDocument)

        return wasSaved ? realmDocument : nil
    }

    func fetchRealmDocuments() -> [RealmDocument] {
        realm.objects(RealmDocument.self).sorted(by: { $0.dateLastOpened > $1.dateLastOpened })
    }

    func saveDocument(_ document: Document) -> Bool {
        saveRealmDocument(document.toRealmDocument())
    }

    func saveRealmDocument(_ realmDocument: RealmDocument) -> Bool {
        do {
            try realm.write {
                realm.add(realmDocument)
            }

            return true
        }
        catch(let error) {
            logEvent(.error, "Failed to add document object to realm database", error: error)
            return false
        }
    }

    func deleteDocument(_ document: Document) -> Bool {
        deleteRealmDocument(document.toRealmDocument())
    }

    func deleteRealmDocument(_ realmDocument: RealmDocument) -> Bool {
        do {
            try realm.write {
                realm.delete(realmDocument)
            }

            return true
        }
        catch(let error) {
            logEvent(.error, "Failed to remove document object from realm database", error: error)
            return false
        }
    }
}

class RealmDocument: Object {
    @objc dynamic var id: UUID = UUID()
    @objc dynamic var documentName: String = ""
    @objc dynamic var dateCreated: Date = Date()
    @objc dynamic var dateLastOpened: Date = Date()
    @objc dynamic var textBody: String = ""

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
