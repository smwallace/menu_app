//
//  Nutrition+CoreDataProperties.swift
//  MenuApp
//
//  Created by Apps Incorporated on 11/22/17.
//  Copyright © 2017 Apps Incorporated. All rights reserved.
//

import Foundation
import CoreData

extension Nutrition {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Nutrition> {
        return NSFetchRequest<Nutrition>(entityName: "Nutrition")
    }

    @NSManaged public var calories: Int64
    @NSManaged public var fat: Int64
    @NSManaged public var fiber: Int64
    @NSManaged public var protein: Int64
    @NSManaged public var forFoodMenuItem: FoodMenuItem?

}
