//
//  DocumentModel.swift
//  Typyst
//
//  Created by Sean Wolford on 11/10/21.
//

import Foundation

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
    
    var currentLine: Int {
        (textBody.count / 80) + 1
    }
    
    var currentIndex: Int {
        textBody.count % 80
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
