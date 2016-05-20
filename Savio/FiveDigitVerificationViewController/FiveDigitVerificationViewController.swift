//
//  FiveDigitVerificationViewController.swift
//  Savio
//
//  Created by Maheshwari on 20/05/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class FiveDigitVerificationViewController: UIViewController {

    @IBOutlet weak var headerText: UILabel!
   
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var gotItButton: UIButton!
    @IBOutlet weak var resentCodeButton: UIButton!
    @IBOutlet weak var fiveDigitTextField: UITextField!
    @IBOutlet weak var yourCodeSentLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //change the border color of UITextField
        fiveDigitTextField.layer.borderWidth = 1
        fiveDigitTextField.layer.borderColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        
        gotItButton.layer.shadowColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        gotItButton.layer.shadowOffset = CGSizeMake(0, 4)
        gotItButton.layer.shadowOpacity = 1
        gotItButton.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func clickOnBackButton(sender: AnyObject) {
        fiveDigitTextField.hidden = true
        resentCodeButton.hidden = true
        backButton.hidden = true
        yourCodeSentLabel.hidden = false
        headerText.text = "We've sent you a 5 digit code"
         gotItButton.setTitle("Got It", forState: UIControlState.Normal)
    }
    @IBAction func clickOnGotItButton(sender: AnyObject) {
        
        if(yourCodeSentLabel.hidden == false)
        {
            fiveDigitTextField.hidden = false
            resentCodeButton.hidden = false
            backButton.hidden = false
            yourCodeSentLabel.hidden = true
            headerText.text = "Enter your 5 digit code"
            gotItButton.setTitle("Confirm", forState: UIControlState.Normal)
        }
        else if(yourCodeSentLabel.hidden == true){
            let createPINView = CreatePINViewController(nibName: "CreatePINViewController",bundle: nil)
            self.navigationController?.pushViewController(createPINView, animated: true)
        }

        
    }
    @IBAction func clickOnResentCodeButton(sender: AnyObject) {
        
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
