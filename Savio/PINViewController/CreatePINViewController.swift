//
//  CreatePINViewController.swift
//  Savio
//
//  Created by Maheshwari on 20/05/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class CreatePINViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var toolBar: UIToolbar!
    @IBOutlet weak var backgroundScrollView: UIScrollView!
    @IBOutlet weak var enterFiveDigitCodeLabel: UILabel!
    @IBOutlet weak var reEnterFourDigitPIN: UITextField!
    @IBOutlet weak var enterFourDigitPIN: UITextField!
    @IBOutlet weak var confirmPIN: UIButton!
    
    var objAPI = API()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //Add borderWidth and borderColor to UITextFields
        enterFourDigitPIN.layer.borderWidth = 1
        enterFourDigitPIN.layer.borderColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        enterFourDigitPIN.attributedPlaceholder = NSAttributedString(string:"4 digit passcode",
                                                                     attributes:[NSForegroundColorAttributeName:UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1),NSFontAttributeName :UIFont(name: "GothamRounded-Light", size: 15)!])
        //Set input accessory view to the UITextfield
        enterFourDigitPIN.inputAccessoryView = toolBar
        
        reEnterFourDigitPIN.layer.borderWidth = 1
        reEnterFourDigitPIN.layer.borderColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        reEnterFourDigitPIN.attributedPlaceholder = NSAttributedString(string:"Re-enter 4 digit passcode",
                                                                       attributes:[NSForegroundColorAttributeName:UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1),NSFontAttributeName :UIFont(name: "GothamRounded-Light", size: 15)!])
        //Set input accessory view to the UITextfield
        reEnterFourDigitPIN.inputAccessoryView = toolBar
        
        //Add shadowcolor to confirmPIN
        confirmPIN.layer.shadowColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        confirmPIN.layer.shadowOffset = CGSizeMake(0, 4)
        confirmPIN.layer.shadowOpacity = 1
        confirmPIN.layer.cornerRadius = 5
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
         // Set the scrollview content size.
        backgroundScrollView.contentSize = CGSizeMake(0, 500)
    }
    
    //UITextFieldDelegateMethods
    func textFieldDidBeginEditing(textField: UITextField){
        
        //Change the border color of UITextfields
        enterFourDigitPIN.layer.borderColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        reEnterFourDigitPIN.layer.borderColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        
        enterFourDigitPIN.textColor = UIColor.blackColor()
        reEnterFourDigitPIN.textColor = UIColor.blackColor()
        
        enterFiveDigitCodeLabel.hidden = true;
        //Change the content offset of scrollview so UITextfield will not be hidden by keyboard
        
        if(UIScreen.mainScreen().bounds.size.height == 480)
        {
            
            if(textField == enterFourDigitPIN)
            {
                backgroundScrollView.contentOffset = CGPointMake(0, 23)
            }
            else if(textField == reEnterFourDigitPIN)
            {
                backgroundScrollView.contentOffset = CGPointMake(0, 69)
            }
        }
    }
    
    @IBAction func toolBarDoneButtonPressed(sender: AnyObject) {
         enterFourDigitPIN.resignFirstResponder()
         reEnterFourDigitPIN.resignFirstResponder()
        backgroundScrollView.contentOffset = CGPointMake(0, 0)
    }
    @IBAction func onclickBackButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onClickConfirmButton(sender: AnyObject) {
        enterFourDigitPIN.resignFirstResponder()
        reEnterFourDigitPIN.resignFirstResponder()
        //Confirm button click
        if(enterFourDigitPIN.text == "" || reEnterFourDigitPIN.text == "")
        {
            //Show error when field is empty
            enterFiveDigitCodeLabel.hidden = false;
            enterFourDigitPIN.layer.borderColor = UIColor.redColor().CGColor
            reEnterFourDigitPIN.layer.borderColor = UIColor.redColor().CGColor
            
        }
        else if(enterFourDigitPIN.text  != reEnterFourDigitPIN.text)
        {
            //Show error when fields are not same
            
            enterFiveDigitCodeLabel.hidden = false;
            enterFiveDigitCodeLabel.text = "Passcode do not match"
            
            
            enterFourDigitPIN.textColor = UIColor.redColor()
            reEnterFourDigitPIN.textColor = UIColor.redColor()
        }
        else
        {
            
            enterFiveDigitCodeLabel.hidden = true;
            //Store the passcode in Keychain
            objAPI.storeValueInKeychainForKey("myPasscode", value: reEnterFourDigitPIN.text!.MD5())
            //Navigate user to HurrayViewController to start Saving plan
            let objHurrrayView = HurreyViewController(nibName:"HurreyViewController",bundle: nil)
            self.navigationController?.pushViewController(objHurrrayView, animated: true)
            
        }
    }
    
}
