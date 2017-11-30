//
//  FoodMenuItem+CoreDataClass.swift
//  MenuApp
//
//  Created by Apps Incorporated on 11/26/17.
//  Copyright © 2017 Apps Incorporated. All rights reserved.
//

import Foundation
import CoreData

@objc(FoodMenuItem)
public class FoodMenuItem: NSManagedObject {

    class func entityName() -> String {
        return "FoodMenuItem"
    }
    
    func map(values: [String : Any]) {
        detailedInformation = values[DetailedInformationKey] as? String
        imageName = values[ImageNameKey] as? String
        ingredients = values[IngredientsKey] as? String
        name = values[NameKey] as? String
        shortInformation = values[ShortInformationKey] as? String
        itemIndex = values[FoodItemIndexKey] as? Int32 ?? 0
        allergenInformation = values[AllergensKey] as? String
        if let nutrition = NSEntityDescription.insertNewObject(forEntityName: Nutrition.entityName(), into: managedObjectContext!) as? Nutrition, let nutritionValues = values[NutritionKey] as? [String : Any] {
            nutrition.map(values: nutritionValues)
            self.nutrition = nutrition
        }
    }
    

}
