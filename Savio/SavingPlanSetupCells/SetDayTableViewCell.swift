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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let attr = NSDictionary(object: UIFont(name: "GothamRounded-Book", size: 10.0)!, forKey: NSFontAttributeName)
        segmentControl.setTitleTextAttributes(attr as [NSObject : AnyObject], forState: UIControlState.Normal)
        segmentControl.selectedSegmentIndex = 1
        //UISegmentedControl.appearance().tintColor = UIColor.clearColor()
        UISegmentedControl.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: .Normal)
        let layer =  CAGradientLayer()
        layer.frame.size = setDayDateButton.frame.size
        layer.startPoint = CGPointZero
        layer.endPoint = CGPointMake(1, 0)
        let colorGreen = UIColor.whiteColor().CGColor
        let colorBlack = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        
        layer.colors = [colorGreen, colorGreen, colorBlack, colorBlack]
        layer.locations = [0.0, 0.7, 0.7, 1.0]
        layer.cornerRadius = 5
        
        setDayDateButton.layer.insertSublayer(layer, atIndex: 0)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func setDayDatePressed(sender: AnyObject) {

    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    @IBAction func segmentControlChanged(sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0)
        {
            dayDateLabel.text = "day"
        }
        else{
            dayDateLabel.text = "date"
        }
        
    }
}
