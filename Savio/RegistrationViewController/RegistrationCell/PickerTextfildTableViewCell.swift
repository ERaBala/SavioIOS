//
//  PickerTextfildTableViewCell.swift
//  Savio
//
//  Created by Prashant Mali on 21/05/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

protocol PickerTxtFieldTableViewCellDelegate {
    func selectedDate(txtFldCell:PickerTextfildTableViewCell)
//    func cancleToSelectDate(txtFldCell:PickerTextfildTableViewCell)
}

class PickerTextfildTableViewCell: UITableViewCell,UITextFieldDelegate{

    @IBOutlet weak var tfDatePicker: UITextField!
    weak var tblView: UITableView?
    var previousDate: String?

    @IBOutlet weak var toolBarInput: UIToolbar?

    var delegate: PickerTxtFieldTableViewCellDelegate?


    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tfDatePicker.inputAccessoryView = toolBarInput
        previousDate = tfDatePicker.text!
        
        tfDatePicker?.layer.cornerRadius = 2.0
        tfDatePicker?.layer.masksToBounds = true
        tfDatePicker?.layer.borderWidth=1.0
        tfDatePicker?.layer.borderColor = UIColor(red: 202/256.0, green: 175/256.0, blue: 120/256.0, alpha: 1.0).CGColor;

        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func selectDate(sender: UITextField) {
        previousDate = tfDatePicker.text
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: "datePickerValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
      
        
    }

    func datePickerValueChanged(sender:UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        tfDatePicker.text = dateFormatter.stringFromDate(sender.date)
    }
    
    @IBAction func toolBarDoneBtnClicked(){
        tfDatePicker.resignFirstResponder()
        previousDate = tfDatePicker.text!
        delegate?.selectedDate(self)
        
    }
    
    @IBAction func toolBarCancleBtnClicked(){
        tfDatePicker.resignFirstResponder()
        tfDatePicker.text = previousDate
        delegate?.selectedDate(self)

//        delegate?.cancleToSelectDate(self)
    }

}








































































