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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nextButton.layer.shadowColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        nextButton.layer.shadowOffset = CGSizeMake(0, 3)
        nextButton.layer.shadowOpacity = 1
        nextButton.layer.cornerRadius = 5
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
