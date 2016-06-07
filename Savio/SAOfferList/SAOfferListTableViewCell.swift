//
//  SAOfferListTableViewCell.swift
//  Savio
//
//  Created by Prashant on 06/06/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class SAOfferListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var btnAddOffer: UIButton?


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //Set Shadow to saving plan button
        btnAddOffer!.layer.shadowColor = UIColor(red: 133/255, green: 226/255, blue: 177/255, alpha: 1).CGColor
        btnAddOffer!.layer.shadowOffset = CGSizeMake(0, 2)
        btnAddOffer!.layer.shadowOpacity = 1
        btnAddOffer!.layer.cornerRadius = 5
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
