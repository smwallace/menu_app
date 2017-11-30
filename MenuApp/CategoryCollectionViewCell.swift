//
//  CategoryCollectionViewCell.swift
//  MenuApp
//
//  Created by Apps Incorporated on 11/26/17.
//  Copyright © 2017 Apps Incorporated. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
        
    var dataBinder = DataBinder.sharedInstance
    
    var category: Category?
    
    func setCategory(category: Category?) {
        self.category = category
        itemNameLabel.styleLabel(size: IsiPad ? 24 : 16)

        if let category = category {
            imageView.image = dataBinder.image(name: category.imageName)
            itemNameLabel.text = category.categoryName
        } else {
            itemNameLabel.text = "No Categories Available"
        }
    }

}
