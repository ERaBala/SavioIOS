//
//  SetDayTableViewCell.swift
//  Savio
//
//  Created by Maheshwari on 01/06/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class SetDayTableViewCell: UITableViewCell,UIPopoverPresentationControllerDelegate {
    @IBOutlet weak var setDayDateButton: UIButton!
    
    @IBOutlet weak var dayDateTextField: UITextField!
    @IBOutlet weak var dayDateLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    weak var tblView : UITableView?
    var colorDataDict : Dictionary<String,AnyObject> = [:]
    override func awakeFromNib() {
        super.awakeFromNib()
        
        colorDataDict =  NSUserDefaults.standardUserDefaults().objectForKey("colorDataDict") as! Dictionary<String,AnyObject>
        
        // Initialization code
        let attr = NSDictionary(object: UIFont(name: "GothamRounded-Book", size: 10.0)!, forKey: NSFontAttributeName)
        segmentControl.setTitleTextAttributes(attr as [NSObject : AnyObject], forState: UIControlState.Normal)
        segmentControl.selectedSegmentIndex = 1
        segmentControl.backgroundColor = self.setUpColor()
        //UISegmentedControl.appearance().tintColor = UIColor.clearColor()
        
        UISegmentedControl.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: .Normal)
        segmentControl.selectedSegmentIndex = 0
        let layer =  CAGradientLayer()
        layer.frame.size = setDayDateButton.frame.size
        layer.startPoint = CGPointZero
        layer.endPoint = CGPointMake(1, 0)
        let colorGreen = UIColor.whiteColor().CGColor
        let colorBlack = self.setUpColor().CGColor
        
        layer.colors = [colorGreen, colorGreen, colorBlack, colorBlack]
        layer.locations = [0.0, 0.7, 0.7, 1.0]
        layer.cornerRadius = 5
        
        setDayDateButton.layer.insertSublayer(layer, atIndex: 0)
        
        
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
            red = 244/255
            green = 176/255
            blue = 58/255
        }
        return UIColor(red:red as CGFloat, green: green as CGFloat, blue: blue as CGFloat, alpha: 1)
    }
    
    
    @IBAction func setDayDatePressed(sender: AnyObject) {
        
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    @IBAction func segmentControlChanged(sender: UISegmentedControl) {
        
        print(sender.titleForSegmentAtIndex(sender.selectedSegmentIndex))
        if(sender.selectedSegmentIndex == 0) {
            dayDateLabel.text = "date"
            //sender.setImage(UIImage(named: "butn01-1.png"), forSegmentAtIndex: 1)
        }
        else{
            dayDateLabel.text = "day"
            //sender.setImage(UIImage(named: "butn01-1.png"), forSegmentAtIndex: 0)
        }
    }
}
