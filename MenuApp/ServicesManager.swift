//
//  ServicesManager.swift
//  MenuApp
//
//  Created by Apps Incorporated on 11/22/17.
//  Copyright © 2017 Apps Incorporated. All rights reserved.
//

import UIKit
import CoreData

let CategoriesKey = "categories"
let FoodItemsKey = "foodItems"
let NameKey = "name"
let ImageNameKey = "imageName"
let CategoryIndexKey = "categoryIndex"
let ShortInformationKey = "shortInformation"
let DetailedInformationKey = "detailedInformation"
let FoodItemIndexKey = "foodItemIndex"
let IngredientsKey = "ingredients"
let NutritionKey = "nutrition"
let AllergensKey = "allergens"
let CaloriesKey = "calories"
let FiberKey = "fiber"
let FatKey = "fat"
let ProteinKey = "protein"

public class ServicesManager {
    
    // MARK: - Shared Instance
    static var sharedInstance = ServicesManager()
    
    var persistentStoreManager = PersistentStoreManager.sharedInstance
    var lastFileIndex = 3
    
    func fetchCategories() -> [Category] {
        if let context = PersistentStoreManager.sharedInstance.managedObjectContext {
            let fetchRequest : NSFetchRequest<Category> = NSFetchRequest(entityName: Category.entityName())
            do {
                return try context.fetch(fetchRequest)
            } catch let error as NSError {
                print("ServicesManager(): Error\n\(error)")
            }
        }
        return []
    }
    
    func refreshData(success: @escaping () -> (), failure: @escaping (_ error: Error) -> ()) {
        // This could be replaced with services calls. This reads in JSON files.
        let fileName = dataFileName()
        if let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let jsonString = try? String(contentsOf: fileURL, encoding: .utf8) {
                clearData()
                if let error = populateData(json: jsonString) {
                    failure(error)
                } else {
                    success()
                }
        } else {
            failure(buildError(message: "Data file \"\(fileName).json\" could not be opened. (This error is generated on purpose to demonstrate error handling.)"))
        }
    }
    
    func dataFileName() -> String {
        let fileName = "data\(lastFileIndex)"
        lastFileIndex = (lastFileIndex + 1) % 4
        return fileName
    }
    
    fileprivate func clearData() {
        let allCategories = fetchCategories()
        for category in allCategories {
            if let context = PersistentStoreManager.sharedInstance.managedObjectContext {
                for foodMenuItem in category.foodMenuItems!.allObjects as! [FoodMenuItem] {
                    if let nutrition = foodMenuItem.nutrition {
                        context.delete(nutrition)
                    }
                    context.delete(foodMenuItem)
                }
                context.delete(category)
            }
        }        
    }
    
    fileprivate func populateData(json: String) -> Error? {
        var error: Error? = nil
        if let jsonDictionary = convertToDictionary(text: json) {
            if let categories: Array<[String : Any]> = jsonDictionary[CategoriesKey] as? Array<[String : Any]> {
                for categoryDictionary: [String : Any] in categories {
                    if let category = NSEntityDescription.insertNewObject(forEntityName: Category.entityName(), into: persistentStoreManager.managedObjectContext!) as? Category {
                        category.map(values: categoryDictionary)
                    }
                }
            } else {
                error = buildError(message: "The categories field is missing.")
            }
            
        } else {
            error = buildError()
        }
        
        persistentStoreManager.saveContext()
        return error
    }
    
    fileprivate func convertToDictionary(text: String) -> [String : Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    fileprivate func buildError(message: String = "An error occurred retrieving the menu data.") -> Error {
        return NSError(domain: "world", code: 500, userInfo: [NSLocalizedDescriptionKey : message])
    }

}
