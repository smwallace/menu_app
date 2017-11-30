//
//  CategoryCollectionViewController.swift
//  MenuApp
//
//  Created by Apps Incorporated on 11/26/17.
//  Copyright © 2017 Apps Incorporated. All rights reserved.
//

import UIKit

class CategoryCollectionViewController: UICollectionViewController {
    
    var servicesManager = ServicesManager.sharedInstance
    var persistentStoreManager = PersistentStoreManager.sharedInstance
    var dataBinder = DataBinder.sharedInstance
    var alertUtils = AlertUtils.sharedInstance
    
    var refresher: UIRefreshControl!

    var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        title = "Your Fresh Menu"
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "Quicksand-Bold", size: 24) ?? UIFont.boldSystemFont(ofSize: 24)]
        
        installRefreshControl()

        getContent()
    }
    
    @IBAction func getContent() {
        servicesManager.refreshData(success: {
            self.refresher.endRefreshing()
            self.categories = self.dataBinder.fetchCategories()
            self.collectionView?.reloadData()
        }, failure: { (error: Error) in
            self.alertUtils.showAlertController(self.parent!, alertTitle: "Error retrieving data", alertMessage: "The data could not be retrieved. \(error.localizedDescription) Please try refreshing again.", buttonTitle: "OK", handler: { (_ action: UIAlertAction?) in
                    self.refresher.endRefreshing()
            })
        })
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! MenuItemsCollectionViewController
        if let cell = sender as? CategoryCollectionViewCell {
            controller.category = cell.category
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
        return max(categories.count, 1)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        cell.setCategory(category: indexPath.row >= categories.count ? nil : categories[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView : UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAtIndexPath indexPath:IndexPath) -> CGSize {
        let width = IsiPad ? self.view.frame.size.width / 2 - 16 : self.view.frame.size.width - 16
        return CGSize(width: width, height: IsiPad ? 100 : 80)
    }
    
    fileprivate func installRefreshControl() {
        refresher = UIRefreshControl()
        collectionView!.alwaysBounceVertical = true
        refresher.tintColor = UIColor.red
        refresher.addTarget(self, action: #selector(CategoryCollectionViewController.getContent), for: .valueChanged)
        collectionView!.addSubview(refresher)
    }

}
