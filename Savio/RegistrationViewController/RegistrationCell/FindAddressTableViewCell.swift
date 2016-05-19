//
//  FindAddressTableViewCell.swift
//  Savio
//
//  Created by Prashant on 19/05/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class FindAddressTableViewCell: UITableViewCell {

    @IBOutlet weak var tfPostCode: UITextField?
    @IBOutlet weak var btnPostCode: UIButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        tfPostCode?.layer.cornerRadius = 2.0
        tfPostCode?.layer.masksToBounds = true
        tfPostCode?.layer.borderWidth=1.0
        tfPostCode?.layer.borderColor = UIColor(red: 202/256.0, green: 175/256.0, blue:120/256.0, alpha: 1.0).CGColor;
        btnPostCode?.layer.cornerRadius = 2.0
        btnPostCode?.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
