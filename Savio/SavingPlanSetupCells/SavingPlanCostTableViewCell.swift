//
//  SavingPlanCostTableViewCell.swift
//  Savio
//
//  Created by Maheshwari on 01/06/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit
protocol SavingPlanCostTableViewCellDelegate {
    func txtFieldCellText(txtFldCell:SavingPlanCostTableViewCell)
}
class SavingPlanCostTableViewCell: UITableViewCell,UITextFieldDelegate {
    weak var tblView : UITableView?
    weak var view : UIView?
    var delegate: SavingPlanCostTableViewCellDelegate?
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var costTextField: UITextField!
    
    
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        costTextField.delegate = self
        
        minusButton.layer.cornerRadius = minusButton.frame.size.height / 2
        minusButton.layer.masksToBounds = true
        
        plusButton.layer.cornerRadius = plusButton.frame.size.height / 2
        plusButton.layer.masksToBounds = true
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func getAttributedString() -> NSMutableAttributedString
    {
        let attrString = NSMutableAttributedString(
            string: "£",
            attributes: [NSFontAttributeName:UIFont(
                name: "GothamRounded-Book",
                size: 14.0)!,NSForegroundColorAttributeName:UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1)])
        return attrString
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        if(sender.value >= 2000)
        {
            sender.value = sender.value + 300;
        }
        else{
            sender.value = sender.value + 100;
        }
        
        costTextField.text = String(format: "%@ %d",self.getAttributedString().mutableString as String,Int(sender.value))
    }
    func registerForKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SavingPlanCostTableViewCell.keyboardWasShown(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SavingPlanCostTableViewCell.keyboardWillBeHidden(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotification(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    @IBAction func plusButtonPressed(sender: AnyObject) {
        if(slider.value >= 2000)
        {
            slider.value = slider.value + 300;
        }
        else{
            slider.value = slider.value + 100;
        }
        
        let attrString = NSMutableAttributedString(
            string: String(format: "%d",Int(slider.value)),
            attributes: [NSFontAttributeName:UIFont(
                name: "GothamRounded-Book",
                size: 14.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
        
        self.getAttributedString().appendAttributedString(attrString)
        var dict = Dictionary<String,UIColor>()
        dict["£"] = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1)
        dict[String(format: "%d",Int(slider.value))] = UIColor.whiteColor()
        costTextField.text = String(format: "%@ %d",self.getAttributedString().mutableString as String,Int(slider.value))
    }
    @IBAction func minusButtonPressed(sender: AnyObject) {
        if(slider.value >= 2000)
        {
            slider.value = slider.value - 300;
        }
        else
        {
            slider.value = slider.value - 100;
        }
        
        costTextField.text = String(format: "%@ %d",self.getAttributedString().mutableString as String,Int(slider.value))
    }
    
    @objc func keyboardWasShown(notification: NSNotification){
        //do stuff
        
        var info = notification.userInfo as! Dictionary<String,AnyObject>
        let kbSize = info[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue.size
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, (kbSize?.height)!, 0.0)
        tblView?.contentInset = contentInsets
        tblView?.scrollIndicatorInsets = contentInsets
        
        var aRect = costTextField?.frame
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
        costTextField!.textColor = UIColor.blackColor()
        //self.registerForKeyboardNotifications()
        if(UIScreen.mainScreen().bounds.size.height == 480)
        {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDelegate(self)
            UIView.setAnimationDuration(0.5)
            UIView.setAnimationBeginsFromCurrentState(true)
            view!.frame = CGRectMake(view!.frame.origin.x, (view!.frame.origin.y-100), view!.frame.size.width, view!.frame.size.height)
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
            view!.frame = CGRectMake(view!.frame.origin.x, (view!.frame.origin.y+100), view!.frame.size.width, view!.frame.size.height)
            UIView.commitAnimations()
        }
        return true
    }
    
}
