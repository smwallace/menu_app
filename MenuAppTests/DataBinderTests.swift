//
//  DataBinderTests.swift
//  MenuApp
//
//  Created by Apps Incorporated on 11/29/17.
//  Copyright © 2017 Apps Incorporated. All rights reserved.
//

import Foundation
import XCTest
import CoreData
@testable import MenuApp

class DataBinderTests: MenuAppTests {
    
    var persistentStoreManager = PersistentStoreManager()
    var dataBinder = DataBinder()
    
    override func setUp() {
        super.setUp()
        
        testDataManager.initTestManagedObjectContext()
    }
    
    func testFetchCategoriesWhenNoDataHasBeenLoaded() {
        let categories = dataBinder.fetchCategories()
        XCTAssertEqual(categories.count, 0)
    }
    
    func testFetchCategoriesWhenDataHasBeenLoaded() {
        if let category = mapCategory() {
            let categories = dataBinder.fetchCategories()
            XCTAssertEqual(categories.count, 1)
            XCTAssertEqual(categories[0].categoryName, category.categoryName)
        }
    }
    
    func testLoadImageWhenImageExists() {
        let image = dataBinder.image(name: "triple", defaultImage: "")
        XCTAssertNotNil(image)
    }
    
    func testLoadImageReturnsDefaultImageWhenImageDoesNotExist() {
        let image = dataBinder.image(name: "someImage", defaultImage: "triple")
        XCTAssertNotNil(image)
    }
    
    func testLoadImageReturnsNilWhenImageAndDefaultImageDoNotExist() {
        let image = dataBinder.image(name: "someImage", defaultImage: "someOtherImage")
        XCTAssertNil(image)
    }


}
