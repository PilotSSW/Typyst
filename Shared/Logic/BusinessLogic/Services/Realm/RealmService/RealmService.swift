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
    private var realmInstance: Realm!
    
    init?(withRealmInstance realmInstance: Realm? = RootDependencyContainer.get().realmInstance) {
        if realmInstance == nil {
            logEvent(.fatal, "Unable to create a Realm store for RealmService - nil realm instance provided")
            return nil
        }
        
        self.realmInstance = realmInstance
    }
    
    func createObject(_ object: Object) -> Bool {
        do {
            try realmInstance.write {
                realmInstance.add(object, update: .error)
            }

            logEvent(.info, "Successfully created realm object")
            return true
        }
        catch (let error) {
            logEvent(.error, "Unable to create realm object", error: error, context: object)
            return false
        }
    }
    
    func getObject<Element: Object, KeyType>(ofType type: Element.Type, forPrimaryKey key: KeyType) -> Element? {
        realmInstance.object(ofType: type, forPrimaryKey: key)
    }
    
    func getObjects<Element: Object>(_ type: Element.Type) -> RealmSwift.Results<Element> {
        realmInstance.objects(type)
    }
    
    func saveObject(_ object: Object) -> Bool {
        do {
            try realmInstance.write {
                realmInstance.add(object, update: .modified)
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
            try realmInstance.write {
                realmInstance.delete(object)
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
