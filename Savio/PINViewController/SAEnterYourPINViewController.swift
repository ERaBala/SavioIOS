//
//  SAEnterYourPINViewController.swift
//  Savio
//
//  Created by Vishal  on 21/05/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class SAEnterYourPINViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var forgotPasscodeButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var enterPasscodeTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //change the border color and placeholder color of UITextField
        enterPasscodeTextField.layer.borderWidth = 1
        enterPasscodeTextField.layer.borderColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        enterPasscodeTextField.attributedPlaceholder = NSAttributedString(string:"Enter 4 digit passcode",
            attributes:[NSForegroundColorAttributeName:UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1),NSFontAttributeName :UIFont(name: "GothamRounded-Light", size: 14)!])
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func clickOnRegisterButton(sender: AnyObject) {
        
        let saRegisterViewController = SARegistrationViewController(nibName:"SARegistrationViewController",bundle: nil)
        self.navigationController?.pushViewController(saRegisterViewController, animated: true)
    }
    
    @IBAction func clickedOnForgotPasscode(sender: AnyObject) {
        let createPINViewController = CreatePINViewController(nibName:"CreatePINViewController",bundle: nil)
        self.navigationController?.pushViewController(createPINViewController, animated: true)
    }
   
    @IBAction func clickOnLoginButton(sender: AnyObject) {
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
