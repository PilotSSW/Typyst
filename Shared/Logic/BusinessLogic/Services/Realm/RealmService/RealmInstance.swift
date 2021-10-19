//
//  RealmInstance.swift
//  Typyst
//
//  Created by Sean Wolford on 10/18/21.
//

import Foundation
import RealmSwift

enum TypystRealmConfiguration {
    case mainRealm
    
    func getRealmConfiguration() -> Realm.Configuration? {
        switch self {
        case .mainRealm:
            return Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        }
    }
}
extension Realm: Loggable {
    init?(_ configuration: TypystRealmConfiguration,
          withLoggingInstance logger: Logging = RootDependencyContainer.get().logging) {
        do {
            if let config = configuration.getRealmConfiguration() {
                try self.init(configuration: config)
            }
            else {
                try self.init()
            }
        }
        catch(let error) {
            Logging.log(inInstance: logger, .fatal, "Unable to create a Realm store for RealmService", error: error, context: configuration)
            return nil
        }
    }
}
