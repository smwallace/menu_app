//
//  Nutrition+CoreDataClass.swift
//  MenuApp
//
//  Created by Apps Incorporated on 11/22/17.
//  Copyright © 2017 Apps Incorporated. All rights reserved.
//

import Foundation
import CoreData

@objc(Nutrition)
public class Nutrition: NSManagedObject {

    class func entityName () -> String {
        return "Nutrition"
    }

    func map(values: [String : Any]) {
        calories = values[CaloriesKey] as? Int64 ?? 0
        fat = values[FatKey] as? Int64 ?? 0
        fiber = values[FiberKey] as? Int64 ?? 0
        protein = values[ProteinKey] as? Int64 ?? 0
    }
    
    func nutritionText() -> String {
        let caloriesString = "\(calories) Calories, "
        let fatString = "\(fat) g Fat, "
        let fiberString = "\(fiber) g Fiber, "
        let proteinString = "\(protein) g Protein"
        return caloriesString + fatString + fiberString + proteinString
    }
    
}
