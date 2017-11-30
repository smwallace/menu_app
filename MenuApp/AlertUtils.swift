//
//  AlertUtils.swift
//  MenuApp
//
//  Created by Apps Incorporated on 11/29/17.
//  Copyright © 2017 Apps Incorporated. All rights reserved.
//

import UIKit

class AlertUtils {
    
    static var sharedInstance = AlertUtils()

    func showAlertController(_ baseViewController: UIViewController, alertTitle: String, alertMessage: String, buttonTitle: String, handler: ((_ action: UIAlertAction?) -> ())?) {
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        var alertAction: UIAlertAction
        alertAction = UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.default, handler: handler)
        alertAction.accessibilityLabel = "alertButtonOne"
        alertController.addAction(alertAction)
        
        baseViewController.present(alertController, animated: true, completion: nil)
    }
    
}

