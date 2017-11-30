//
//  TextMessageViewController.swift
//  MenuApp
//
//  Created by Apps Incorporated on 11/28/17.
//  Copyright © 2017 Apps Incorporated. All rights reserved.
//

import UIKit

class TextMessageViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    
    static let TitleLabelFontSize: CGFloat = IsiPad ? 36 : 24
    static let TextLabelFontSize: CGFloat = IsiPad ? 36 : 24
    
    var viewTitle: String?
    var text: String?
    
    func setTitleAndText(title: String, text: String) {
        self.title = title
        self.text = text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        textLabel.text = text
        textLabel.styleLabel(size: TextMessageViewController.TextLabelFontSize)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(TextMessageViewController.dismissMe))
        tap.delegate = self as? UIGestureRecognizerDelegate
        view.addGestureRecognizer(tap)

    }
    
    @IBAction func dismissMe() {
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }

}
