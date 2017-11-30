//
//  CategoryTests.swift
//  MenuApp
//
//  Created by Apps Incorporated on 11/29/17.
//  Copyright © 2017 Apps Incorporated. All rights reserved.
//

import Foundation
import XCTest
import CoreData
@testable import MenuApp

class CategoryTests: MenuAppTests {
        
    let ExpectedCategoryName = "Hamburgers"
    let ExpectedCategoryIndex: Int32 = 3
    let ExpectedCategoryImageName = "hamburger.png"
    let ExpectedFoodMenuItemsCount = 2
    
    override func setUp() {
        super.setUp()
        
        testDataManager.initTestManagedObjectContext()
    }
    
    func testMapSetsCategoryName() {
        if let category = mapCategory() {
            XCTAssertEqual(category.categoryName, ExpectedCategoryName)
        } else {
            XCTFail("Could not map category")
        }
    }
    
    func testMapSetsImageName() {
        if let category = mapCategory() {
            XCTAssertEqual(category.imageName, ExpectedCategoryImageName)
        } else {
            XCTFail("Could not map category")
        }
    }
    
    func testMapSetsFoodMenuItems() {
        if let category = mapCategory() {
            XCTAssertEqual(category.foodMenuItems?.count, ExpectedFoodMenuItemsCount)
        } else {
            XCTFail("Could not map category")
        }
    }
    
    func testMapSetsCategoryIndex() {
        if let category = mapCategory() {
            XCTAssertEqual(category.categoryIndex, ExpectedCategoryIndex)
        } else {
            XCTFail("Could not map category")
        }
    }

    
}
