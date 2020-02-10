//
// Created by Sean Wolford on 2/3/20.
// Copyright (c) 2020 wickedPropeller. All rights reserved.
//

import Cocoa
import Foundation

class AppPersistence {
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Typist")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                //fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()


    // MARK: - Core Data Saving and Undo support
    func saveContext(_ sender: AnyObject?) -> NSApplication.TerminateReply {
        // Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
        let context = persistentContainer.viewContext

        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing before saving")
        }
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Customize this code block to include application-specific recovery steps.
                return App.instance.ui.couldntSaveAppStateAlert(error as NSError, sender as! NSApplication) 
            }
        }

        return .terminateNow
    }

    @IBAction func saveAction(_ sender: AnyObject?) {
        saveContext(sender)
    }
}
