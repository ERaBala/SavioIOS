//
//  SavingPlanTitleTableViewCell.swift
//  Savio
//
//  Created by Maheshwari on 01/06/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class SavingPlanTitleTableViewCell: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    weak var tblView : UITableView?
    weak var view : UIView?
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleTextField.delegate = self
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func registerForKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SavingPlanTitleTableViewCell.keyboardWasShown(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SavingPlanTitleTableViewCell.keyboardWillBeHidden(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotification(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    
    @objc func keyboardWasShown(notification: NSNotification){
        //do stuff
        
        var info = notification.userInfo as! Dictionary<String,AnyObject>
        let kbSize = info[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue.size
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, (kbSize?.height)!, 0.0)
        tblView?.contentInset = contentInsets
        tblView?.scrollIndicatorInsets = contentInsets
        
        var aRect = titleTextField?.frame
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
        titleTextField!.textColor = UIColor.blackColor()
        if(UIScreen.mainScreen().bounds.size.height == 480)
        {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDelegate(self)
            UIView.setAnimationDuration(0.5)
            UIView.setAnimationBeginsFromCurrentState(true)
            view!.frame = CGRectMake(view!.frame.origin.x, (view!.frame.origin.y-30), view!.frame.size.width, view!.frame.size.height)
            UIView.commitAnimations()
        }
        else{
            self.registerForKeyboardNotifications()
        }
        return true
    }
    func textFieldDidEndEditing(textField: UITextField){
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
 
        if(UIScreen.mainScreen().bounds.size.height == 480)
        {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDelegate(self)
            UIView.setAnimationDuration(0.5)
            UIView.setAnimationBeginsFromCurrentState(true)
            view!.frame = CGRectMake(view!.frame.origin.x, (view!.frame.origin.y+30), view!.frame.size.width, view!.frame.size.height)
            UIView.commitAnimations()
        }
        return true
    }
    
    
}
