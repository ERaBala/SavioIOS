//
//  NextButtonTableViewCell.swift
//  Savio
//
//  Created by Maheshwari on 02/06/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class NextButtonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nextButton: UIButton!
    weak var tblView : UITableView?
    var colorDataDict : Dictionary<String,AnyObject> = [:]
    
   override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        colorDataDict =  NSUserDefaults.standardUserDefaults().objectForKey("colorDataDict") as! Dictionary<String,AnyObject>
        nextButton.layer.shadowColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        nextButton.layer.shadowOffset = CGSizeMake(0, 3)
        nextButton.layer.shadowOpacity = 1
        nextButton.layer.cornerRadius = 5
        nextButton.backgroundColor = self.setUpColor()
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
    
    
}
