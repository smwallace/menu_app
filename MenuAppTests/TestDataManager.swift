//
//  TestDataManager.swift
//  MenuApp
//
//  Created by Apps Incorporated on 11/29/17.
//  Copyright © 2017 AppsIncorporated. All rights reserved.
//

import Foundation
import CoreData
import XCTest
@testable import MenuApp

@objc (TestDataManager)
class TestDataManager: NSObject {
    
    var managedObjectContext: NSManagedObjectContext? = nil
    
    static var sharedInstance = TestDataManager()
    
    func initTestManagedObjectContext() {
        
        let modelURL = Bundle.main.url(forResource: "MenuApp", withExtension: "momd")!
        let model = NSManagedObjectModel(contentsOf: modelURL)!
        let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
        do {
            try psc.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            XCTFail("could not initialize in memory persistent store")
        }
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext!.persistentStoreCoordinator = psc;
        
        PersistentStoreManager.sharedInstance.managedObjectContext = managedObjectContext!
    }
    
    func modelByChangingEntitiyManagedObjectClassNameSwiftModuleName(_ moduleName: String, originalModel: NSManagedObjectModel) -> NSManagedObjectModel {
        for entity in originalModel.entities {
            let originalManagedObjectClassName = entity.managedObjectClassName
            
            let components = originalManagedObjectClassName?.components(separatedBy: ".")
            let newManagedObjectClassName = "\(moduleName).\(String(describing:components?[components?.count == 2 ? 1 : 0]))"
            
            entity.managedObjectClassName = newManagedObjectClassName
        }
        
        return originalModel
    }
    
    func saveManagedObjectContext() {
        do {
            try managedObjectContext?.save()
        } catch {
        }
    }
    
}

class MockServicesManagerForFileName: ServicesManager {
    
    override func dataFileName() -> String {
        return "data3" // use the same data for each test
    }
    
}

