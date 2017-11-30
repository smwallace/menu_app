//
//  FoodItemCollectionViewCell.swift
//  MenuApp
//
//  Created by Apps Incorporated on 11/26/17.
//  Copyright © 2017 Apps Incorporated. All rights reserved.
//

import UIKit

class FoodItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailedInformationLabel: UILabel!
    
    var dataBinder = DataBinder.sharedInstance
    
    var foodMenuItem: FoodMenuItem?

    func setFoodItem(foodMenuItem: FoodMenuItem?) {
        self.foodMenuItem = foodMenuItem
        nameLabel.styleLabel(size: IsiPad ? 24 : 18)
        detailedInformationLabel.styleLabel(size: IsiPad ? 22 : 16)

        if let foodMenuItem = foodMenuItem {
            imageView.image = dataBinder.image(name: foodMenuItem.imageName)
            nameLabel.text = foodMenuItem.name
            detailedInformationLabel.text = foodMenuItem.shortInformation
        } else {
            imageView.isHidden = true
            nameLabel.text = "No items in this category"
            detailedInformationLabel.isHidden = true
        }
        
    }
}
