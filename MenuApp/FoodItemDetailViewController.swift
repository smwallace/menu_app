//
//  FoodItemDetailViewController.swift
//  MenuApp
//
//  Created by Apps Incorporated on 11/26/17.
//  Copyright © 2017 Apps Incorporated. All rights reserved.
//

import UIKit

public class FoodItemDetailViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var allergensButton: UIButton!
    @IBOutlet weak var nutritionButton: UIButton!
    @IBOutlet weak var ingredientsButton: UIButton!
    
    static let ButtonFontSize: CGFloat = IsiPad ? 20 : 16
    static let NameLabelFontSize: CGFloat = IsiPad ? 40 : 24
    static let DescriptionLabelFontSize: CGFloat = IsiPad ? 32 : 16
    
    var dataBinder = DataBinder.sharedInstance
    
    var foodMenuItem: FoodMenuItem? = nil
    
    func setFoodMenuItem(foodMenuItem: FoodMenuItem) {
        self.foodMenuItem = foodMenuItem
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.gray

        imageView.image = dataBinder.image(name: foodMenuItem?.imageName)
        nameLabel.text = foodMenuItem?.name
        nameLabel.styleLabel(size: FoodItemDetailViewController.NameLabelFontSize)
        descriptionLabel.text = foodMenuItem?.detailedInformation
        descriptionLabel.styleLabel(size: FoodItemDetailViewController.DescriptionLabelFontSize)
        
        allergensButton.titleLabel?.styleLabel(size: FoodItemDetailViewController.ButtonFontSize)
        nutritionButton.titleLabel?.styleLabel(size: FoodItemDetailViewController.ButtonFontSize)
        ingredientsButton.titleLabel?.styleLabel(size: FoodItemDetailViewController.ButtonFontSize)
    }
    
    @IBAction func showAllergens(_ sender: UIButton) {
        let allergenText = foodMenuItem?.allergenInformation ?? "None of the allergens we track are contained in this item. Please review the full ingredients list for detailed information."
        showTextMessageViewController(title: "Allergens", text: allergenText)
    }
    
    @IBAction func showNutrition(_ sender: UIButton) {
        let nutritionText = foodMenuItem?.nutrition?.nutritionText() ?? "No nutrition information is available for this item."
        showTextMessageViewController(title: "Nutrition", text: nutritionText)
    }
    
    @IBAction func showIngredients(_ sender: UIButton) {
        showTextMessageViewController(title: "Ingredients", text: foodMenuItem?.ingredients ?? "No ingredient information is available for this item.")
    }

    fileprivate func showTextMessageViewController(title: String, text: String) {
        let textMessageViewController = storyboard!.instantiateViewController(withIdentifier: "TextMessageViewController") as! TextMessageViewController
        textMessageViewController.setTitleAndText(title: title, text: text)
        
        let nav = UINavigationController(rootViewController: textMessageViewController)
        nav.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "Quicksand-Bold", size: 24) ?? UIFont.boldSystemFont(ofSize: 24)]

        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        let popover = nav.popoverPresentationController
        textMessageViewController.preferredContentSize = CGSize(width: IsiPad ? 400 : 300, height: IsiPad ? 400 : 300)
        popover?.delegate = self
        popover?.sourceView = self.view
        popover?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        popover?.permittedArrowDirections = .init(rawValue: 0)

        present(nav, animated: true, completion: nil)
    }
    
}
