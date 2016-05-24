//
//  CreatePINViewController.swift
//  Savio
//
//  Created by Maheshwari on 20/05/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class CreatePINViewController: UIViewController,UITextFieldDelegate {
    
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
        
        reEnterFourDigitPIN.layer.borderWidth = 1
        reEnterFourDigitPIN.layer.borderColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        reEnterFourDigitPIN.attributedPlaceholder = NSAttributedString(string:"Re-enter 4 digit passcode",
                                                                       attributes:[NSForegroundColorAttributeName:UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1),NSFontAttributeName :UIFont(name: "GothamRounded-Light", size: 15)!])
        
        //Add shadowcolor to confirmPIN
        confirmPIN.layer.shadowColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        confirmPIN.layer.shadowOffset = CGSizeMake(0, 4)
        confirmPIN.layer.shadowOpacity = 1
        confirmPIN.layer.cornerRadius = 5
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundScrollView.contentSize = CGSizeMake(0, 500)
    }
    
    //UITextFieldDelegateMethods
    func textFieldDidBeginEditing(textField: UITextField){
        
        enterFourDigitPIN.layer.borderColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        reEnterFourDigitPIN.layer.borderColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        
        enterFourDigitPIN.textColor = UIColor.blackColor()
        reEnterFourDigitPIN.textColor = UIColor.blackColor()
        
        enterFiveDigitCodeLabel.hidden = true;
        
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
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        if(textField.isFirstResponder())
        {
            textField.resignFirstResponder()
        }
        backgroundScrollView.contentOffset = CGPointMake(0, 0)
        
        return true
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onclickBackButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func onClickConfirmButton(sender: AnyObject) {
        enterFourDigitPIN.resignFirstResponder()
        reEnterFourDigitPIN.resignFirstResponder()
        if(enterFourDigitPIN.text == "" || reEnterFourDigitPIN.text == "")
        {
            enterFiveDigitCodeLabel.hidden = false;
            enterFourDigitPIN.layer.borderColor = UIColor.redColor().CGColor
            reEnterFourDigitPIN.layer.borderColor = UIColor.redColor().CGColor

        }
        else if(enterFourDigitPIN.text  != reEnterFourDigitPIN.text)
        {
            enterFiveDigitCodeLabel.hidden = false;
            enterFiveDigitCodeLabel.text = "Passcode do not match"

            
            enterFourDigitPIN.textColor = UIColor.redColor()
            reEnterFourDigitPIN.textColor = UIColor.redColor()
        }
        else{
            enterFiveDigitCodeLabel.hidden = true;
        
            let objEnterPasscode = SAEnterYourPINViewController(nibName: "SAEnterYourPINViewController",bundle: nil)
            self.navigationController?.pushViewController(objEnterPasscode, animated: true)
            
            print(reEnterFourDigitPIN.text!.MD5())
            objAPI.storeValueInKeychainForKey("myPasscode", value: reEnterFourDigitPIN.text!.MD5())
            
            /*
            let alert = UIAlertController(title: "Now we can start saving plan.", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            */
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
