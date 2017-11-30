//
//  PersistentStoreManager.swift
//  MenuApp
//
//  Created by Apps Incorporated on 11/22/17.
//  Copyright © 2017 Apps Incorporated. All rights reserved.
//

import Foundation
import CoreData

// MARK: - Core Data stack
class PersistentStoreManager {
    
    static var sharedInstance = PersistentStoreManager()
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // print("documents directory is \(urls[urls.count-1])")
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "MenuApp", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("MenuApp.sqlite")
        
        // Enable lightweight migrations.
        let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true];
        do {
            try coordinator!.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch let error {
            coordinator = nil
            fatalError()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        if let moc = managedObjectContext {
            if moc.hasChanges {
                do {
                    try moc.save()
                } catch { }
            }
        }
    }
    
    func managedObjectContextHasBeenInitialized() -> Bool {
        return managedObjectContext != nil
    }
    
    func removeObjectFromStoreAndSave(_ object: NSManagedObject) -> Void {
        managedObjectContext!.delete(object)
        saveContext()
    }
    
    // Used mainly for testing
    class func resetPersistentStore() {
        if let psc = PersistentStoreManager.sharedInstance.managedObjectContext?.persistentStoreCoordinator{
            
            if let store = psc.persistentStores.last{
                
                let storeUrl = psc.url(for: store)
                
                PersistentStoreManager.sharedInstance.managedObjectContext?.performAndWait(){
                    
                    PersistentStoreManager.sharedInstance.managedObjectContext?.reset()
                    
                    do {
                        try psc.remove(store)
                        try FileManager.default.removeItem(at: storeUrl)
                        try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeUrl, options: nil)
                    } catch { }
                }
            }
        }
    }
}
