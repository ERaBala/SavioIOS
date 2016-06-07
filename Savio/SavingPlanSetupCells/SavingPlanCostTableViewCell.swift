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
    var colorDataDict : Dictionary<String,AnyObject> = [:]
    
    @IBOutlet weak var currencyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        costTextField.delegate = self
         colorDataDict =  NSUserDefaults.standardUserDefaults().objectForKey("colorDataDict") as! Dictionary<String,AnyObject>
        
        minusButton.layer.cornerRadius = minusButton.frame.size.height / 2
        minusButton.setTitleColor(self.setUpColor(), forState: UIControlState.Normal)
        minusButton.layer.masksToBounds = true
        
        plusButton.layer.cornerRadius = plusButton.frame.size.height / 2
        plusButton.layer.masksToBounds = true
        plusButton.setTitleColor(self.setUpColor(), forState: UIControlState.Normal)

        slider.thumbTintColor = self.setUpColor()
        //slider.setThumbImage(UIImage(named: "offer-close.png"), forState: UIControlState.Normal)

        currencyLabel.textColor = self.setUpColor()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setUpColor()-> UIColor
    {
        var red : CGFloat = 0.0
        var green : CGFloat = 0.0
        var blue: CGFloat  = 0.0
        
        if(colorDataDict["header"] as! String == "Group Save")
        {
            red = 161/255
            green = 214/255
            blue = 248/255
            
        }
        else if(colorDataDict["header"] as! String == "Wedding")
        {
            red = 189/255
            green = 184/255
            blue = 235/255
        }
        else if(colorDataDict["header"] as! String == "Baby")
        {
            red = 122/255
            green = 223/255
            blue = 172/255
        }
        else if(colorDataDict["header"] as! String == "Holiday")
        {
            red = 109/255
            green = 214/255
            blue = 200/255
        }
        else if(colorDataDict["header"] as! String == "Ride")
        {
            red = 242/255
            green = 104/255
            blue = 107/255
        }
        else if(colorDataDict["header"] as! String == "Home")
        {
            red = 244/255
            green = 161/255
            blue = 111/255
        }
        else if(colorDataDict["header"] as! String == "Gadget")
        {
            red = 205/255
            green = 220/255
            blue = 57/255
        }
        else
        {
            red = 161/255
            green = 214/255
            blue = 248/255
        }
        return UIColor(red:red as CGFloat, green: green as CGFloat, blue: blue as CGFloat, alpha: 1)
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
            sender.value = sender.value + 30;
        }
        else{
            sender.value = sender.value + 10;
        }
        
        costTextField.text = String(format: " %d",Int(sender.value))
        costTextField.textColor = UIColor.whiteColor()
        delegate?.txtFieldCellText(self)
    }
    func registerForKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWasShown:"), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillBeHidden:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotification(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    @IBAction func plusButtonPressed(sender: AnyObject) {
        if(slider.value >= 2000)
        {
            slider.value = slider.value + 30;
        }
        else{
            slider.value = slider.value + 10;
        }
        
        costTextField.text = String(format: " %d",Int(slider.value))
        costTextField.textColor = UIColor.whiteColor()
        delegate?.txtFieldCellText(self)
    }
    @IBAction func minusButtonPressed(sender: AnyObject) {
        if(slider.value >= 2000)
        {
            slider.value = slider.value - 30;
        }
        else
        {
            slider.value = slider.value - 10;
        }
        
        costTextField.text = String(format: " %d",Int(slider.value))
        costTextField.textColor = UIColor.whiteColor()
         delegate?.txtFieldCellText(self)
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

        textField.textColor = UIColor.whiteColor()
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
        //costTextField.text = String(format: "%@ %d",self.getAttributedString().mutableString as String,Int(slider.value))
       
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        
        slider.value = (costTextField.text! as NSString).floatValue
        delegate?.txtFieldCellText(self)
        
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
