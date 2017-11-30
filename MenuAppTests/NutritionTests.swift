//
//  NutritionTests.swift
//  MenuApp
//
//  Created by Apps Incorporated on 11/29/17.
//  Copyright © 2017 Apps Incorporated. All rights reserved.
//

import Foundation
import XCTest
import CoreData
@testable import MenuApp

class NutritionTests: MenuAppTests {
        
    let ExpectedCalories: Int64 = 570
    let ExpectedFat: Int64 = 10
    let ExpectedFiber: Int64 = 1
    let ExpectedProtein: Int64 = 4
    
    override func setUp() {
        super.setUp()
        
        testDataManager.initTestManagedObjectContext()
    }
    
    func testMapSetsCalories() {
        if let nutrition = mapNutrition() {
            XCTAssertEqual(nutrition.calories, ExpectedCalories)
        } else {
            XCTFail("Could not map Nutrition")
        }
    }
    
    func testMapSetsFat() {
        if let nutrition = mapNutrition() {
            XCTAssertEqual(nutrition.fat, ExpectedFat)
        } else {
            XCTFail("Could not map Nutrition")
        }
    }
    
    func testMapSetsFiber() {
        if let nutrition = mapNutrition() {
            XCTAssertEqual(nutrition.fiber, ExpectedFiber)
        } else {
            XCTFail("Could not map Nutrition")
        }
    }
    
    func testMapSetsProtein() {
        if let nutrition = mapNutrition() {
            XCTAssertEqual(nutrition.protein, ExpectedProtein)
        } else {
            XCTFail("Could not map Nutrition")
        }
    }
    
    fileprivate func mapNutrition() -> Nutrition? {
        if let nutrionDictionary = testNutritionDictionary(),
            let nutrition = NSEntityDescription.insertNewObject(forEntityName: Nutrition.entityName(), into: testDataManager.managedObjectContext!) as? Nutrition {
            nutrition.map(values: nutrionDictionary)
            return nutrition
        }
        return nil
    }

    fileprivate func testNutritionDictionary() -> [String : Any]? {
        let nutritionString = "{\"calories\": 570,\"fat\": 10,\"fiber\": 1,\"protein\": 4}"
        return convertToDictionary(text: nutritionString)
    }
}
