//
//  Category+CoreDataClass.swift
//  MenuApp
//
//  Created by Apps Incorporated on 11/22/17.
//  Copyright © 2017 Apps Incorporated. All rights reserved.
//

import Foundation
import CoreData

@objc(Category)
public class Category: NSManagedObject {

    class func entityName () -> String {
        return "Category"
    }
    
    func map(values: [String : Any]) {
        categoryName = values[NameKey] as? String
        imageName = values[ImageNameKey] as? String
        categoryIndex = values[CategoryIndexKey] as? Int32 ?? 0
        
        if let foodItemValues = values[FoodItemsKey] as? [[String: Any]] {
            for itemDictionary in foodItemValues {
                if let foodMenuItem = NSEntityDescription.insertNewObject(forEntityName: FoodMenuItem.entityName(), into: managedObjectContext!) as? FoodMenuItem {
                    foodMenuItem.map(values: itemDictionary)
                    addToFoodMenuItems(foodMenuItem)
                }
            }
        }
    }
    
    func sortedFoodMenuItems() -> [FoodMenuItem] {
        if let items = foodMenuItems?.allObjects as? [FoodMenuItem] {
            return items.sorted { $0.itemIndex < $1.itemIndex }
        }
        return []
    }


}
