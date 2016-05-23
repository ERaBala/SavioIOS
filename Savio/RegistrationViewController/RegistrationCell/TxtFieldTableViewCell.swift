//
//  TxtFieldTableViewCell.swift
//  Savio
//
//  Created by Prashant on 19/05/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

protocol TxtFieldTableViewCellDelegate {
    func txtFieldCellText(txtFldCell:TxtFieldTableViewCell)
}

class TxtFieldTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    var delegate: TxtFieldTableViewCellDelegate?
    @IBOutlet weak var tf: UITextField?
    weak var tblView: UITableView?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        tf?.layer.cornerRadius = 2.0
        tf?.layer.masksToBounds = true
        tf?.layer.borderWidth=1.0
        tf?.layer.borderColor = UIColor(red: 202/256.0, green: 175/256.0, blue: 120/256.0, alpha: 1.0).CGColor;
        tf?.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        let placeholder = NSAttributedString(string:"" , attributes: [NSForegroundColorAttributeName : UIColor.redColor()])
        tf?.attributedPlaceholder = placeholder;
        tf?.delegate = self
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func registerForKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotification(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    

    @objc func keyboardWasShown(notification: NSNotification){
        //do stuff
    /*
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame: CGRect = info.objectForKey(UIKeyboardFrameEndUserInfoKey)!.CGRectValue
        let loginFormFrame: CGRect = self.convertRect(tblView!.frame, fromView: nil)
        let coveredFrame: CGRect = CGRectIntersection(loginFormFrame, keyboardFrame)
        
        
        tblView!.setContentOffset(CGPointMake(0, coveredFrame.height + 20), animated: true)
        */
        
        
        var info = notification.userInfo as! Dictionary<String,AnyObject>
        let kbSize = info[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue.size
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, (kbSize?.height)!, 0.0)
        tblView?.contentInset = contentInsets
        tblView?.scrollIndicatorInsets = contentInsets
        
        var aRect = tf?.frame
        aRect?.size.height = (aRect?.size.height)! - (kbSize?.height)!
        if !CGRectContainsPoint(aRect!, self.frame.origin) {
            tblView?.scrollRectToVisible(self.frame, animated: true)
        }
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification){
        //do stuff
        
         let contentInsets: UIEdgeInsets =  UIEdgeInsetsZero;
        tblView?.contentInset = contentInsets;
        tblView?.scrollIndicatorInsets = contentInsets;
    }
    
   func textFieldShouldBeginEditing(textField: UITextField) -> Bool
     {
        self.registerForKeyboardNotifications()
        return true
    }
    func textFieldDidEndEditing(textField: UITextField){
//        self.removeKeyboardNotification()
        self.delegate?.txtFieldCellText(self)

    }
//    func textFieldShouldEndEditing(textField: UITextField) -> Bool{
//        self.removeKeyboardNotification()
//        textField.resignFirstResponder()
//        return true
//    }
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        self.delegate?.txtFieldCellText(self)
        return true
    }
}
