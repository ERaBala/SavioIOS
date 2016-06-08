//
//  SAOfferListTableViewCell.swift
//  Savio
//
//  Created by Prashant on 06/06/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class SAOfferListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblProductOffer: UILabel?

    @IBOutlet weak var btnAddOffer: UIButton?
    @IBOutlet weak var btnOfferDetail: UIButton?
    @IBOutlet weak var lblProductDetail: UILabel?

    @IBOutlet weak var lblHT: NSLayoutConstraint!

    @IBOutlet weak var vwBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var bottomSpace: NSLayoutConstraint!
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
    
    @IBAction func clickedOnOfferDetail(sender:UIButton){
        
        let str = "This is Savio application and team size is 4, name: Prashant, Maheshwari, Manoj and Gagan"
        lblHT.constant = 30.0
        lblProductDetail?.text = str
        
    }
    
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }

}
