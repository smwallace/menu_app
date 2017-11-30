//
//  MenuAppTests.swift
//  MenuApp
//
//  Created by Apps Incorporated on 11/29/17.
//  Copyright © 2017 Apps Incorporated. All rights reserved.
//

import Foundation
import XCTest
import CoreData
@testable import MenuApp

class MenuAppTests: XCTestCase {
    
    var testDataManager:TestDataManager = TestDataManager.sharedInstance

    func convertToDictionary(text: String) -> [String : Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func mapCategory() -> MenuApp.Category? {
        if let categoryDictionary = testCategoryDictionary(),
            let category = NSEntityDescription.insertNewObject(forEntityName: Category.entityName(), into: testDataManager.managedObjectContext!) as? MenuApp.Category {
            category.map(values: categoryDictionary)
            return category
        }
        return nil
    }
    
    fileprivate func testCategoryDictionary() -> [String : Any]? {
        let categoryString = "{\"name\": \"Hamburgers\",\"imageName\": \"hamburger.png\",\"categoryIndex\": 3,\"foodItems\": [{\"name\": \"Dave's Single®\",\"shortInformation\": \"570 cal\",\"foodItemIndex\": 0,\"detailedInformation\": \"It's our classic the way Dave intended! A juicy quarter pound of fresh, never frozen beef decorated with premium toppings all between a warm toasted bun.\",\"imageName\": \"single.png\",\"ingredients\": \"Beef, bun, ketchup, mustard, pickles\",\"allergens\": \"Wheat, soy, milk, and egg\",\"nutrition\": {\"calories\": 570,\"fat\": 10,\"fiber\": 1,\"protein\": 4}},{\"name\": \"Dave's Double®\",\"shortInformation\": \"810 cal\",\"foodItemIndex\": 1,\"detailedInformation\": \"Oh yeah, you're seeing double. That's two fresh, never frozen beef patties with the freshest toppings on a warm toasted bun.\",\"imageName\": \"double.png\",\"ingredients\": \"Beef, bun, ketchup, mustard, pickles\",\"allergens\": \"Wheat, soy, milk, and egg\",\"nutrition\": {\"calories\": 810,\"fat\": 10,\"fiber\": 1,\"protein\": 4}}]}"
        return convertToDictionary(text: categoryString)
    }
    
}
