//
//  ServicesManagerTests.swift
//  ServicesManagerTests
//
//  Created by Apps Incorporated on 11/22/17.
//  Copyright © 2017 Apps Incorporated. All rights reserved.
//

import XCTest
import CoreData
@testable import MenuApp

class ServicesManagerTests: MenuAppTests {
        
    let servicesManager = MockServicesManagerForFileName()

    override func setUp() {
        super.setUp()
        
        testDataManager.initTestManagedObjectContext()
    }
    
    func testRefreshDataWithValidFilePopulatesCategories() {
        servicesManager.refreshData(success: { 
            let categories = self.fetchCategories()
            XCTAssertEqual(categories.count, 3)
        }, failure: { (Error) in
            XCTFail("refreshData should not fail")
        })
    }
    
    func testRefreshDataWithValidFilePopulatesFoodItems() {
        servicesManager.refreshData(success: {
            let categories = self.fetchCategories() as [MenuApp.Category]
            let menuItems = categories[0].foodMenuItems!.allObjects
            XCTAssertEqual(menuItems.count, 4)
        }, failure: { (Error) in
            XCTFail("refreshData should not fail")
        })
    }
    
    func testRefreshDataTwiceOnlyIncludesOneSetOfData() {
        servicesManager.refreshData(success: {
            self.servicesManager.refreshData(success: {
                let categories = self.fetchCategories()
                XCTAssertEqual(categories.count, 3)
            }, failure: { (Error) in
                XCTFail("second refreshData should not fail")
            })
        }, failure: { (Error) in
            XCTFail("refreshData should not fail")
        })
    }
    
    func testRefreshDataWithInvalidFileCallsFailureClosure() {
        let servicesManager = MockServicesManagerForInvalidFileName()
        servicesManager.refreshData(success: {
            XCTFail("refreshData should not succeed")
        }, failure: { (Error) in
            let categories = self.fetchCategories() as [MenuApp.Category]
            XCTAssertEqual(categories.count, 0)
        })
    }

    func testRefreshDataWithInvalidFileDoesNotClearData() {
        servicesManager.refreshData(success: {
            let categories = self.fetchCategories() as [MenuApp.Category]
            XCTAssertEqual(categories.count, 3)
            
            let failureServicesManager = MockServicesManagerForInvalidFileName()
            failureServicesManager.refreshData(success: {
                XCTFail("Second call to refreshData should not succeed")
            }, failure: { (Error) in
                let categories = self.fetchCategories() as [MenuApp.Category]
                XCTAssertEqual(categories.count, 3)
            })

        }, failure: { (Error) in
            XCTFail("First call to refreshData should not fail")
        })
    }
    
    fileprivate func fetchCategories() -> [MenuApp.Category] {
        if let objContext = TestDataManager.sharedInstance.managedObjectContext {
            let fetchRequest : NSFetchRequest<MenuApp.Category> = NSFetchRequest(entityName: Category.entityName())
            do {
                let categories = try objContext.fetch(fetchRequest)
                return categories.sorted { $0.categoryIndex < $1.categoryIndex }
            } catch let error as NSError {
                print("CategoryBinder.fetchCategories(): Error\n\(error)")
            }
        }
        return []
    }

}

class MockServicesManagerForInvalidFileName: ServicesManager {
    
    override func dataFileName() -> String {
        return "data0"
    }
    
}
