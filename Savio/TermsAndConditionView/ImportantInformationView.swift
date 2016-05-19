//
//  TermsAndConditionView.swift
//  PostalCodeVerification-Demo
//
//  Created by Maheshwari on 19/05/16.
//  Copyright © 2016 Maheshwari. All rights reserved.
//

import UIKit

class ImportantInformationView: UIView {

    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var termsAndConditionTextView: UITextView!
    @IBOutlet weak var gotItButton: UIButton!
    var isChecked : Bool!
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        isChecked = false
        
        //set the shadow color for accept button
        gotItButton.layer.shadowColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        
        //set the content offset for textview so it,will begin at point(0,0)
        termsAndConditionTextView.contentOffset = CGPointMake(0, 0)
        
        //set the bordercolor and borderwidth to check button
        checkButton.layer.borderColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        checkButton.layer.borderWidth = 1
        
    }
    
    @IBAction func gotItButtonPressed(sender: AnyObject) {
        
    }
    @IBAction func checkButtonPressed(sender: AnyObject) {
        
        if(isChecked == true)
        {
            isChecked = false
            checkButton.setImage(UIImage(named:""), forState: UIControlState.Normal)
            
        }
        else{
            isChecked = true
            checkButton.setImage(UIImage(named:""), forState: UIControlState.Normal)
        }
        
    }

    @IBAction func cancelButtonPressed(sender: AnyObject) {
    }
}
