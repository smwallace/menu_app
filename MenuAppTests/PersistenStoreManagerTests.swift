//
//  PersistentStoreManagerTests.swift
//  MenuApp
//
//  Created by Apps Incorporated on 11/29/17.
//  Copyright © 2017 Apps Incorporated. All rights reserved.
//

import Foundation
import XCTest
@testable import MenuApp

class PersistentStoreManagerTests: XCTestCase {
    
    var persistentStoreManager = PersistentStoreManager()
    var testDataManager:TestDataManager = TestDataManager.sharedInstance

    override func setUp() {
        super.setUp()
        
        if testDataManager.managedObjectContext == nil {
            testDataManager.initTestManagedObjectContext()
        }
    }
    
    func testApplicationDocumentsDirectory() {
        let add = persistentStoreManager.applicationDocumentsDirectory
        XCTAssertNotNil(add)
    }
    
    func testManagedObjectModel() {
        let mom = persistentStoreManager.managedObjectModel
        XCTAssertNotNil(mom)
    }
    
    func testPersistentStoreCoordinator() {
        let psc = persistentStoreManager.persistentStoreCoordinator
        XCTAssertNotNil(psc)
    }
    
    func testManagedObjectContext() {
        let moc = persistentStoreManager.persistentStoreCoordinator
        XCTAssertNotNil(moc)
    }
    
    func testManageObjectContextHasBeenInitializedReturnsTrueWhenInitialzed() {
        let newPersistentStoreManager = PersistentStoreManager()
        let moc = persistentStoreManager.managedObjectContext!
        try! moc.save()
        XCTAssertTrue(newPersistentStoreManager.managedObjectContextHasBeenInitialized())
    }
    
}
