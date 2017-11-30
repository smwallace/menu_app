//
//  MenuItemsCollectionViewController.swift
//  MenuApp
//
//  Created by Apps Incorporated on 11/26/17.
//  Copyright © 2017 Apps Incorporated. All rights reserved.
//

import UIKit

class MenuItemsCollectionViewController: UICollectionViewController {
    
    var servicesManager = ServicesManager.sharedInstance
    var persistentStoreManager = PersistentStoreManager.sharedInstance
    var dataBinder = DataBinder.sharedInstance
    
    var category: Category? = nil
    var foodMenuItems: [FoodMenuItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        title = category?.categoryName
        
        self.navigationController?.navigationBar.tintColor = UIColor.gray
        
        foodMenuItems = category!.sortedFoodMenuItems()
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! FoodItemDetailViewController
        if let cell = sender as? FoodItemCollectionViewCell {
            controller.setFoodMenuItem(foodMenuItem: cell.foodMenuItem!)
        }
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    //MARK: - CollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return max(foodMenuItems.count, 1)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodMenuItemCollectionViewCell", for: indexPath) as! FoodItemCollectionViewCell
        cell.setFoodItem(foodMenuItem: indexPath.row >= foodMenuItems.count ? nil : foodMenuItems[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView : UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAtIndexPath indexPath:IndexPath) -> CGSize {
        let width = IsiPad ? self.view.frame.size.width / 2 - 16 : self.view.frame.size.width - 16
        return CGSize(width: width, height: IsiPad ? 100 : 80)
    }

}
