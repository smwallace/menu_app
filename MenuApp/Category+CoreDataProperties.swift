//
//  Category+CoreDataProperties.swift
//  MenuApp
//
//  Created by Apps Incorporated on 11/22/17.
//  Copyright © 2017 Apps Incorporated. All rights reserved.
//

import Foundation
import CoreData

extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var categoryName: String?
    @NSManaged public var imageName: String?
    @NSManaged public var foodMenuItems: NSSet?
    @NSManaged public var categoryIndex: Int32

}

// MARK: Generated accessors for foodItems
extension Category {

    @objc(addFoodMenuItemsObject:)
    @NSManaged public func addToFoodMenuItems(_ value: FoodMenuItem)

    @objc(removeFoodMenuItemsObject:)
    @NSManaged public func removeFromFoodMenuItems(_ value: FoodMenuItem)

    @objc(addFoodMeniItems:)
    @NSManaged public func addToFoodMenuItems(_ values: NSSet)

    @objc(removeFoodMeniItems:)
    @NSManaged public func removeFromFoodMenuItems(_ values: NSSet)

}
