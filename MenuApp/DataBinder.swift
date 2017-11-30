//
//  CategoryBinder.swift
//  MenuApp
//
//  Created by Apps Incorporated on 11/22/17.
//  Copyright © 2017 Apps Incorporated. All rights reserved.
//

import UIKit
import CoreData

class DataBinder {
    
    static var sharedInstance = DataBinder()
    
    var persistentStoreManager = PersistentStoreManager.sharedInstance
    
    func fetchCategories() -> [Category] {
        if let objContext = PersistentStoreManager.sharedInstance.managedObjectContext {
            let fetchRequest : NSFetchRequest<Category> = NSFetchRequest(entityName: Category.entityName())
            do {
                let categories = try objContext.fetch(fetchRequest)
                return categories.sorted { $0.categoryIndex < $1.categoryIndex }
            } catch let error as NSError {
                print("CategoryBinder.fetchCategories(): Error\n\(error)")
            }
        }
        return []
    }
    
    func image(name: String?, defaultImage: String = "Missing") -> UIImage? {
        if let name = name {
            return UIImage(named: name) ?? UIImage(named: defaultImage)
        } else {
            return UIImage(named: defaultImage)
        }
    }
    
}
