//
//  CreatePINViewController.swift
//  Savio
//
//  Created by Maheshwari on 20/05/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class CreatePINViewController: UIViewController {

    @IBOutlet weak var reEnterFourDigitPIN: UITextField!
    @IBOutlet weak var enterFourDigitPIN: UITextField!
    @IBOutlet weak var confirmPIN: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Add borderWidth and borderColor to UITextFields
        enterFourDigitPIN.layer.borderWidth = 1
        enterFourDigitPIN.layer.borderColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        enterFourDigitPIN.attributedPlaceholder = NSAttributedString(string:"4 digit passcode",
                                                               attributes:[NSForegroundColorAttributeName:UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1),NSFontAttributeName :UIFont(name: "GothamRounded-Light", size: 14)!])
        
        reEnterFourDigitPIN.layer.borderWidth = 1
        reEnterFourDigitPIN.layer.borderColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        reEnterFourDigitPIN.attributedPlaceholder = NSAttributedString(string:"Re-enter 4 digit passcode",
                                                                     attributes:[NSForegroundColorAttributeName:UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1),NSFontAttributeName :UIFont(name: "GothamRounded-Light", size: 14)!])
        
        //Add shadowcolor to confirmPIN
        confirmPIN.layer.shadowColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        confirmPIN.layer.shadowOffset = CGSizeMake(0, 4)
        confirmPIN.layer.shadowOpacity = 1
        confirmPIN.layer.cornerRadius = 5
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onclickBackButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func onClickConfirmButton(sender: AnyObject) {
        
        let saEnterPINViewController = SAEnterYourPINViewController(nibName:"SAEnterYourPINViewController",bundle: nil)
        self.navigationController?.pushViewController(saEnterPINViewController, animated: true)
        
        
        //Below part should be called from register page(Why do we need this information)
        /*
        let importantInfo = NSBundle.mainBundle().loadNibNamed("ImportantInformationView", owner: self, options: nil)[0] as! ImportantInformationView
        importantInfo.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
        self.view.addSubview(importantInfo)
 */
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
