//
//  DataProtectionPolicy.swift
//  Savio
//
//  Created by Maheshwari on 19/05/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class DataProtectionPolicy: UIView {

    @IBOutlet weak var backButton: UIButton!
    
    override func drawRect(rect: CGRect) {
        backButton.layer.shadowColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
    }
    @IBAction func backButtonPressed(sender: AnyObject) {
    }
}
