//
//  FiveDigitVerificationViewController.swift
//  Savio
//
//  Created by Maheshwari on 20/05/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class FiveDigitVerificationViewController: UIViewController,UITextFieldDelegate,OTPSentDelegate,OTPVerificationDelegate {
    
    @IBOutlet weak var headerText: UILabel!
    
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet weak var codeDoesNotMatchLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var gotItButton: UIButton!
    @IBOutlet weak var resentCodeButton: UIButton!
    @IBOutlet weak var fiveDigitTextField: UITextField!
    @IBOutlet weak var yourCodeSentLabel: UILabel!
    let objAPI = API()
    var objAnimView = ImageViewAnimation()
    var userInfoDict : Dictionary<String,AnyObject> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objAnimView = (NSBundle.mainBundle().loadNibNamed("ImageViewAnimation", owner: self, options: nil)[0] as! ImageViewAnimation)
        objAnimView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        
        
        // Do any additional setup after loading the view.
        //change the border color of UITextField
        fiveDigitTextField.layer.borderWidth = 1
        fiveDigitTextField.layer.borderColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        //Set input accessory view to the UITextfield
        fiveDigitTextField.inputAccessoryView = toolbar
        
        gotItButton.layer.shadowColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        gotItButton.layer.shadowOffset = CGSizeMake(0, 4)
        gotItButton.layer.shadowOpacity = 1
        gotItButton.layer.cornerRadius = 5
        //Get user details from Keychain
        userInfoDict = objAPI.getValueFromKeychainOfKey("userInfo") as! Dictionary<String,AnyObject>
        
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        objAnimView.removeFromSuperview()
        let dict = userInfoDict["party"] as! Dictionary<String,AnyObject>
        
        yourCodeSentLabel.text = String(format:"Your code was sent to  %@",dict["phone_number"]! as! String)
   
        fiveDigitTextField.hidden = true
        resentCodeButton.hidden = true
        backButton.hidden = true
        yourCodeSentLabel.hidden = false
        
    }
    
    //UITextField delegate method
    func textFieldDidBeginEditing(textField: UITextField) {
        codeDoesNotMatchLabel.hidden = true;
        fiveDigitTextField.layer.borderColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        fiveDigitTextField.textColor = UIColor.blackColor()
    }
    
    @IBAction func clickOnBackButton(sender: AnyObject) {
        fiveDigitTextField.hidden = true
        resentCodeButton.hidden = true
        backButton.hidden = true
        yourCodeSentLabel.hidden = false
        headerText.text = "We've sent you a verfication code"
        gotItButton.setTitle("Got It", forState: UIControlState.Normal)
        codeDoesNotMatchLabel.hidden = true
    }
    @IBAction func doneButtonToolBarPressed(sender: AnyObject) {
        fiveDigitTextField.resignFirstResponder()
    }
    @IBAction func clickOnGotItButton(sender: AnyObject) {
        
        if(yourCodeSentLabel.hidden == false)
        {
            fiveDigitTextField.hidden = false
            resentCodeButton.hidden = false
            backButton.hidden = false
            yourCodeSentLabel.hidden = true
            headerText.text = "Enter your verification code"
            gotItButton.setTitle("Confirm", forState: UIControlState.Normal)
        }
        else
        {
            if(fiveDigitTextField.text == "")
            {   //Show error when field is empty
                fiveDigitTextField.layer.borderColor = UIColor.redColor().CGColor
                codeDoesNotMatchLabel.text = "Please enter code"
                codeDoesNotMatchLabel.hidden = false;
            }
            else {
                //Set the OTPVerificationDelegate
                /*
                objAPI.otpVerificationDelegate = self
                
                objAPI.verifyOTP(userInfoDict["phone_number"]! as! String, country_code: "91", OTP: fiveDigitTextField.text!)
                codeDoesNotMatchLabel.hidden = true;
                fiveDigitTextField.resignFirstResponder()
                objAnimView.animate()
                self.view.addSubview(objAnimView)
 */
                let objCreatePINView = CreatePINViewController(nibName: "CreatePINViewController",bundle: nil)
                self.navigationController?.pushViewController(objCreatePINView, animated: true)
                
            }
            
        }
        
        
    }
    
    @IBAction func clickOnResentCodeButton(sender: AnyObject) {
        //Set the OTPSentDelegate
        objAPI.otpSentDelegate = self
        
        //Resend the OTP to the mobile number present in keychain
        objAPI.getOTPForNumber(userInfoDict["phone_number"]! as! String, country_code: "91")
        
        fiveDigitTextField.resignFirstResponder()
        
        objAnimView.animate()
        self.view.addSubview(objAnimView)
    }
    
    
    //OTP sent Delegate Method
    func successResponseForOTPSentAPI(objResponse:Dictionary<String,AnyObject>)
    {
        
        objAnimView.removeFromSuperview()
        fiveDigitTextField.hidden = false
        resentCodeButton.hidden = false
        backButton.hidden = false
        yourCodeSentLabel.hidden = true
        headerText.text = "Enter your verification code"
        gotItButton.setTitle("Confirm", forState: UIControlState.Normal)
        
    }
    func errorResponseForOTPSentAPI(error:String){
        
        objAnimView.removeFromSuperview()
        fiveDigitTextField.textColor = UIColor.redColor()
        fiveDigitTextField.hidden = true
        resentCodeButton.hidden = true
        backButton.hidden = true
        yourCodeSentLabel.hidden = false
        headerText.text = "We've sent you a verfication code"
        gotItButton.setTitle("Got It", forState: UIControlState.Normal)
    }
    
    
    //OTP Verification Delegate Method
    func successResponseForOTPVerificationAPI(objResponse:Dictionary<String,AnyObject>)
    {
        
        let objCreatePINView = CreatePINViewController(nibName: "CreatePINViewController",bundle: nil)
        self.navigationController?.pushViewController(objCreatePINView, animated: true)
    }
    func errorResponseForOTPVerificationAPI(error:String){
        objAnimView.removeFromSuperview()
        codeDoesNotMatchLabel.text = error
        codeDoesNotMatchLabel.hidden = false;
    }
}
