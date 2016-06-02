//
//  SetDayTableViewCell.swift
//  Savio
//
//  Created by Maheshwari on 01/06/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class SetDayTableViewCell: UITableViewCell {

    @IBOutlet weak var dayDateLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
       weak var tblView : UITableView?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let attr = NSDictionary(object: UIFont(name: "GothamRounded-Book", size: 10.0)!, forKey: NSFontAttributeName)
        segmentControl.setTitleTextAttributes(attr as [NSObject : AnyObject], forState: UIControlState.Normal)
        segmentControl.selectedSegmentIndex = 0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
