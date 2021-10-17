//
//  RealmService.swift
//  Typyst
//
//  Created by Sean Wolford on 10/15/21.
//

import Foundation
import RealmSwift
import struct RealmSwift.Results

class RealmService: Loggable {
    private var realm: Realm
    
    init?() {
        do {
//            if let url = Bundle.main.url(forResource: "typyst", withExtension: "realm") {
//                let config = Realm.Configuration(fileURL: url)
//                self.realm = try Realm(configuration: config)
//            }
//            else {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
                //Realm.Configuration(schemaVersion: 1)
            self.realm = try Realm(configuration: config)
        }
        catch(let error) {
            print(error)
            logEvent(.fatal, "Unable to create a Realm store for RealmService", error: error)
            
            return nil
        }
    }
    
    func createObject(_ object: Object) -> Bool {
        do {
            try realm.write {
                realm.add(object, update: .error)
            }
            
            logEvent(.info, "Successfully created realm object")
            return true
        }
        catch (let error) {
            logEvent(.error, "Unable to create realm object", error: error, context: object)
            return false
        }
    }
    
    func getObjects<Element: Object>(ofType element: Element) -> Results<Element> {
        realm.objects(Element.self)
    }
    
    func saveObject(_ object: Object) -> Bool {
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
            
            logEvent(.info, "Successfully saved realm object")
            return true
        }
        catch(let error) {
            logEvent(.error, "Failed to add object to realm database", error: error)
            return false
        }
    }
    
    func deleteObject(_ object: Object) -> Bool {
        do {
            try realm.write {
                realm.delete(object)
            }
            
            logEvent(.info, "Successfully deleted realm object")
            return true
        }
        catch(let error) {
            logEvent(.error, "Failed to remove object from realm database", error: error)
            return false
        }
    }
}
