//
//  FoodMenuItem+CoreDataProperties.swift
//  MenuApp
//
//  Created by Apps Incorporated on 11/26/17.
//  Copyright © 2017 Apps Incorporated. All rights reserved.
//

import Foundation
import CoreData

extension FoodMenuItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodMenuItem> {
        return NSFetchRequest<FoodMenuItem>(entityName: "FoodMenuItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var detailedInformation: String?
    @NSManaged public var shortInformation: String?
    @NSManaged public var imageName: String?
    @NSManaged public var ingredients: String?
    @NSManaged public var nutrition: Nutrition?
    @NSManaged public var category: Category?
    @NSManaged public var allergenInformation: String?
    @NSManaged public var itemIndex: Int32

}
