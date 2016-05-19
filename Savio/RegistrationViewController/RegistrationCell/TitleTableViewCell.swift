//
//  TitleTableViewCell.swift
//  Savio
//
//  Created by Prashant on 18/05/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var tfTitle: UITextField?
    @IBOutlet weak var tfName: UITextField?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tfTitle?.layer.cornerRadius = 2.0
        tfTitle?.layer.masksToBounds = true
        tfTitle?.layer.borderWidth=1.0
        tfTitle?.layer.borderColor = UIColor(red: 202/256.0, green: 175/256.0, blue: 120/256.0, alpha: 1.0).CGColor;
        
        tfName?.layer.cornerRadius = 2.0
        tfName?.layer.masksToBounds = true
        tfName?.layer.borderWidth=1.0
        tfName?.layer.borderColor = UIColor(red: 202/256.0, green: 175/256.0, blue: 120/256.0, alpha: 1.0).CGColor;
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
