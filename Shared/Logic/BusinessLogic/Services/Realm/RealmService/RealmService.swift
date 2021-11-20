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
    private var realmConfiguration: TypystRealmConfiguration
    
    init?(withRealmConfiguration config: TypystRealmConfiguration = .mainRealm) {
//        if realmInstance == nil {
//            logEvent(.fatal, "Unable to create a Realm store for RealmService - nil realm instance provided")
//            return nil
//        }
//
        self.realmConfiguration = config
    }
    
    func createObject(_ object: Object) -> Bool {
        if let realm = Realm(realmConfiguration) {
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
        
        return false
    }
    
    func getObject<Element: Object, KeyType>(ofType type: Element.Type, forPrimaryKey key: KeyType) -> Element? {
        if let realm = Realm(realmConfiguration) {
            return realm.object(ofType: type, forPrimaryKey: key)
        }
        
        return nil
    }
    
    func getObjects<Element: Object>(_ type: Element.Type) -> RealmSwift.Results<Element>? {
        if let realm = Realm(realmConfiguration) {
            return realm.objects(type)
        }
        
        return nil
    }
    
    func updateObject(_ updateBlock: (() -> Object)) -> Bool {
        if let realm = Realm(realmConfiguration) {
            do {
                try realm.write {
                    let object = updateBlock()
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
        
        return false
    }
    
    func saveObject(_ object: Object) -> Bool {
        if let realm = Realm(realmConfiguration) {
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
        
        return false
    }
    
    func deleteObject(_ object: Object) -> Bool {
        if let realm = Realm(realmConfiguration) {
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
        
        return false
    }
}
