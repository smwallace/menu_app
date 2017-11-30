//
//  FoodItemTests.swift
//  MenuApp
//
//  Created by Apps Incorporated on 11/29/17.
//  Copyright © 2017 Apps Incorporated. All rights reserved.
//

import Foundation
import XCTest
import CoreData
@testable import MenuApp

class FoodMenuItemTests: MenuAppTests {
        
    let ExpectedDetailedInformation = "It's our classic the way Dave intended! A juicy quarter pound of fresh, never frozen beef decorated with premium toppings all between a warm toasted bun."
    let ExpectedImageName = "single.png"
    let ExpectedIngredients = "Beef, bun, ketchup, mustard, pickles"
    let ExpectedName = "Dave's Single®"
    let ExpectedShortInformation = "570 cal"
    let ExpectedItemIndex: Int32 = 2
    let ExpectedAllergenInformation = "Wheat, soy, milk, and egg"
    let ExpectedNutritionCount = 4
    
    override func setUp() {
        super.setUp()
        
        testDataManager.initTestManagedObjectContext()
    }
    
    func testMapSetsDetailedInformation() {
        if let foodMenuItem = mapFoodMenuItem() {
            XCTAssertEqual(foodMenuItem.detailedInformation, ExpectedDetailedInformation)
        } else {
            XCTFail("Could not map FoodMenuItem")
        }
    }
    
    func testMapSetsImageName() {
        if let foodMenuItem = mapFoodMenuItem() {
            XCTAssertEqual(foodMenuItem.imageName, ExpectedImageName)
        } else {
            XCTFail("Could not map FoodMenuItem")
        }
    }
    
    func testMapSetsIngredients() {
        if let foodMenuItem = mapFoodMenuItem() {
            XCTAssertEqual(foodMenuItem.ingredients, ExpectedIngredients)
        } else {
            XCTFail("Could not map FoodMenuItem")
        }
    }
    
    func testMapSetsName() {
        if let foodMenuItem = mapFoodMenuItem() {
            XCTAssertEqual(foodMenuItem.name, ExpectedName)
        } else {
            XCTFail("Could not map FoodMenuItem")
        }
    }
    
    func testMapSetsShortInformation() {
        if let foodMenuItem = mapFoodMenuItem() {
            XCTAssertEqual(foodMenuItem.shortInformation, ExpectedShortInformation)
        } else {
            XCTFail("Could not map FoodMenuItem")
        }
    }

    func testMapSetsItemIndex() {
        if let foodMenuItem = mapFoodMenuItem() {
            XCTAssertEqual(foodMenuItem.itemIndex, ExpectedItemIndex)
        } else {
            XCTFail("Could not map FoodMenuItem")
        }
    }
    
    func testMapSetsAllergenInformation() {
        if let foodMenuItem = mapFoodMenuItem() {
            XCTAssertEqual(foodMenuItem.allergenInformation, ExpectedAllergenInformation)
        } else {
            XCTFail("Could not map FoodMenuItem")
        }
    }
    
    func testMapSetsNutritionItem() {
        if let foodMenuItem = mapFoodMenuItem() {
            XCTAssertNotNil(foodMenuItem.nutrition)
        } else {
            XCTFail("Could not map FoodMenuItem")
        }
    }
    
    fileprivate func mapFoodMenuItem() -> FoodMenuItem? {
        if let foodMenuItemDictionary = testFoodMenuItemDictionary(),
            let foodMenuItem = NSEntityDescription.insertNewObject(forEntityName: FoodMenuItem.entityName(), into: testDataManager.managedObjectContext!) as? FoodMenuItem {
            foodMenuItem.map(values:foodMenuItemDictionary)
            return foodMenuItem
        }
        return nil
    }
    
    fileprivate func testFoodMenuItemDictionary() -> [String : Any]? {
        let foodItemString = "{\"name\": \"Dave's Single®\",\"shortInformation\": \"570 cal\",\"foodItemIndex\": 2,\"detailedInformation\": \"It's our classic the way Dave intended! A juicy quarter pound of fresh, never frozen beef decorated with premium toppings all between a warm toasted bun.\",\"imageName\": \"single.png\",\"ingredients\": \"Beef, bun, ketchup, mustard, pickles\",\"allergens\": \"Wheat, soy, milk, and egg\",\"nutrition\": {\"calories\": 570,\"fat\": 10,\"fiber\": 1,\"protein\": 4}}"
        return convertToDictionary(text: foodItemString)
    }
}

