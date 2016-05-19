//
//  TxtFieldTableViewCell.swift
//  Savio
//
//  Created by Prashant on 19/05/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class TxtFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var tf: UITextField?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        tf?.layer.cornerRadius = 2.0
        tf?.layer.masksToBounds = true
        tf?.layer.borderWidth=1.0
        tf?.layer.borderColor = UIColor(red: 202/256.0, green: 175/256.0, blue: 120/256.0, alpha: 1.0).CGColor;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
