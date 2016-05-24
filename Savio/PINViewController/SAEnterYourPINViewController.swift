//
//  SAEnterYourPINViewController.swift
//  Savio
//
//  Created by Vishal  on 21/05/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class SAEnterYourPINViewController: UIViewController,UITextFieldDelegate,OTPSentDelegate {

    @IBOutlet weak var passcodeDoesNotMatchLabel: UILabel!
    @IBOutlet weak var btnForgottPasscode: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var lblSentYouCode: UILabel!
    @IBOutlet weak var lblForgottonYourPasscode: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var forgotPasscodeButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var enterPasscodeTextField: UITextField!
    var objAnimView = ImageViewAnimation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    

        // Do any additional setup after loading the view.
        //change the border color and placeholder color of UITextField
        enterPasscodeTextField.layer.borderWidth = 1
        enterPasscodeTextField.layer.borderColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        enterPasscodeTextField.attributedPlaceholder = NSAttributedString(string:"Enter 4 digit passcode",
            attributes:[NSForegroundColorAttributeName:UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1),NSFontAttributeName :UIFont(name: "GothamRounded-Light", size: 15)!])
        
        //Add shadowcolor to UIButtons
        registerButton.layer.shadowColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        registerButton.layer.shadowOffset = CGSizeMake(0, 4)
        registerButton.layer.shadowOpacity = 1
        registerButton.layer.cornerRadius = 5
        
        
        loginButton.layer.shadowColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        loginButton.layer.shadowOffset = CGSizeMake(0, 4)
        loginButton.layer.shadowOpacity = 1
        loginButton.layer.cornerRadius = 5
        
    }
    //UITextField delegate method
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        if(textField.isFirstResponder())
        {
            textField.resignFirstResponder()
        }
        return true
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {

        enterPasscodeTextField.layer.borderColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        enterPasscodeTextField.textColor = UIColor.blackColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func clickOnRegisterButton(sender: AnyObject) {
        
        if(registerButton.titleLabel?.text == "Register")
        {
            let saRegisterViewController = SARegistrationViewController(nibName:"SARegistrationViewController",bundle: nil)
            self.navigationController?.pushViewController(saRegisterViewController, animated: true)
        }
        else{
             let objAPI = API()
            objAPI.otpSentDelegate = self
            var dict = objAPI.getValueFromKeychainOfKey("userInfo") as! Dictionary<String,String>
            objAPI.getOTPForNumber(dict["Mobile number"]! as String, country_code: "91")
            objAnimView = (NSBundle.mainBundle().loadNibNamed("ImageViewAnimation", owner: self, options: nil)[0] as! ImageViewAnimation)
            objAnimView.frame = self.view.frame
            objAnimView.animate()
            self.view.addSubview(objAnimView)
        }
  
    }
    
    @IBAction func clickedOnForgotPasscode(sender: AnyObject) {

            lblSentYouCode.hidden = false
            lblForgottonYourPasscode.hidden = false
            btnCancel.hidden = false
            registerButton .setTitle("Send me a code", forState: UIControlState.Normal)
            
            forgotPasscodeButton.hidden = true
            loginButton.hidden = true
            enterPasscodeTextField.hidden = true


    }
    
    //OTP Verification Delegate Method
    func successResponseForOTPSentAPI(objResponse:Dictionary<String,AnyObject>)
    {
        objAnimView.removeFromSuperview()
        let fiveDigitVerificationViewController = FiveDigitVerificationViewController(nibName:"FiveDigitVerificationViewController",bundle: nil)
        self.navigationController?.pushViewController(fiveDigitVerificationViewController, animated: true)
    }
    func errorResponseForOTPSentAPI(error:String){
        objAnimView.removeFromSuperview()
        let fiveDigitVerificationViewController = FiveDigitVerificationViewController(nibName:"FiveDigitVerificationViewController",bundle: nil)
        self.navigationController?.pushViewController(fiveDigitVerificationViewController, animated: true)
        
    }
    

   
    @IBAction func onClickCancelButton(sender: AnyObject) {
 
        lblSentYouCode.hidden = true
        lblForgottonYourPasscode.hidden = true
        btnCancel.hidden = true
        registerButton .setTitle("Register", forState: UIControlState.Normal)
        
        forgotPasscodeButton.hidden = false
        loginButton.hidden = false
        enterPasscodeTextField.hidden = false
    }
    @IBAction func clickOnLoginButton(sender: AnyObject) {
        if(enterPasscodeTextField.text == "")
        {
            
            enterPasscodeTextField.layer.borderColor = UIColor.redColor().CGColor
            passcodeDoesNotMatchLabel.hidden = false
            passcodeDoesNotMatchLabel.text = "Please enter passcode"
        }
        else{
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
