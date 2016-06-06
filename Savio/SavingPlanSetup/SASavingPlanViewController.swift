//
//  SASavingPlanViewController.swift
//  Savio
//
//  Created by Maheshwari on 01/06/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class SASavingPlanViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate,PopOverDelegate,SavingPlanCostTableViewCellDelegate,SavingPlanDatePickerCellDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var savingPlanTitleLabel: UILabel!
    var tableViewCellArray = []
    var cost : Int = 0
    var dateDiff : Int = 0
    var dateString = ""
    var popOverSelectedStr = ""
    
    var isPopoverValueChanged = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savingPlanTitleLabel.layer.borderWidth = 1
        savingPlanTitleLabel.layer.borderColor = UIColor.whiteColor().CGColor
        
        tblView!.registerNib(UINib(nibName: "SavingPlanTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "SavingPlanTitleIdentifier")
        tblView!.registerNib(UINib(nibName: "SavingPlanCostTableViewCell", bundle: nil), forCellReuseIdentifier: "SavingPlanCostIdentifier")
        tblView!.registerNib(UINib(nibName: "SavingPlanDatePickerTableViewCell", bundle: nil), forCellReuseIdentifier: "SavingPlanDatePickerIdentifier")
        tblView!.registerNib(UINib(nibName: "SetDayTableViewCell", bundle: nil), forCellReuseIdentifier: "SavingPlanSetDateIdentifier")
        tblView!.registerNib(UINib(nibName: "CalculationTableViewCell", bundle: nil), forCellReuseIdentifier: "SavingPlanCalculationIdentifier")
        tblView!.registerNib(UINib(nibName: "NextButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "NextButtonCellIdentifier")
        tblView!.registerNib(UINib(nibName: "ClearButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "ClearButtonIdentifier")
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if(isPopoverValueChanged == false) {
            return 6
        }
        else {
            return 7
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        if(indexPath.section == 0)
        {
            let cell1 = tableView.dequeueReusableCellWithIdentifier("SavingPlanTitleIdentifier", forIndexPath: indexPath) as! SavingPlanTitleTableViewCell
            cell1.tblView = tblView
            cell1.view = self.view
            return cell1
        }
        else if(indexPath.section == 1){
            let cell1 = tableView.dequeueReusableCellWithIdentifier("SavingPlanCostIdentifier", forIndexPath: indexPath) as! SavingPlanCostTableViewCell
            cell1.tblView = tblView
            cell1.delegate = self
            cell1.view = self.view
            return cell1
        }
        else if(indexPath.section == 2){
            let cell1 = tableView.dequeueReusableCellWithIdentifier("SavingPlanDatePickerIdentifier", forIndexPath: indexPath) as! SavingPlanDatePickerTableViewCell
            cell1.tblView = tblView
            cell1.savingPlanDatePickerDelegate = self
            cell1.view = self.view
            return cell1
        }
        else if(indexPath.section == 3){
            let cell1 = tableView.dequeueReusableCellWithIdentifier("SavingPlanSetDateIdentifier", forIndexPath: indexPath) as! SetDayTableViewCell
            cell1.tblView = tblView
            cell1.setDayDateButton.tag = indexPath.row
            if(popOverSelectedStr != "")
            {
                cell1.setDayDateButton.setTitle(popOverSelectedStr, forState: UIControlState.Normal)
                cell1.setDayDateButton.titleLabel?.textAlignment = NSTextAlignment.Left
                cell1.setDayDateButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
            }
            cell1.setDayDateButton.addTarget(self, action: Selector("setDayDateButtonButtonPressed:"), forControlEvents: UIControlEvents.TouchUpInside)
            return cell1
        }
        else if(indexPath.section == 4){
            let cell1 = tableView.dequeueReusableCellWithIdentifier("SavingPlanCalculationIdentifier", forIndexPath: indexPath) as! CalculationTableViewCell
            cell1.tblView = tblView
            if(isPopoverValueChanged)
            {
                if(dateString == "day")
                {
                    cell1.calculationLabel.text = String(format: "You will need to save £%d per week for %d week(s)",cost/(dateDiff/168),(dateDiff/168))
                }
                else{
                    cell1.calculationLabel.text = String(format: "You will need to save £%d per month for %d month(s)",(cost/((dateDiff/168)/4)),(dateDiff/168)/4)
                }
            }
            return cell1
        }
        else if(indexPath.section == 5){
            
            let cell1 = tableView.dequeueReusableCellWithIdentifier("NextButtonCellIdentifier", forIndexPath: indexPath) as! NextButtonTableViewCell
            cell1.tblView = tblView
            return cell1
        }
        else
        {
            let cell1 = tableView.dequeueReusableCellWithIdentifier("ClearButtonIdentifier", forIndexPath: indexPath) as! ClearButtonTableViewCell
            cell1.tblView = tblView
            return cell1
        }
        
        
    }
    
    func datePickerText(date: Int) {
        print(date)
        dateDiff = date
    }
    
    func setDayDateButtonButtonPressed(sender:UIButton)
    {
        if(cost != 0 && dateDiff != 0)
        {
            let cell = sender.superview?.superview as? SetDayTableViewCell
            //let indexPath = tblView.indexPathForCell(cell)
            //tblView.scrollToRowAtIndexPath(indexPath!, atScrollPosition: .Top, animated: true)
            
            let objPopOverView = SAPopOverViewController(nibName: "SAPopOverViewController",bundle: nil)
            if(cell?.dayDateLabel.text == "day") {
                objPopOverView.setArrayString = "day"
                dateString = "day"
            }
            else {
                objPopOverView.setArrayString = "date"
                dateString = "date"
            }
            
            objPopOverView.popOverDelegate = self
            
            objPopOverView.modalPresentationStyle = UIModalPresentationStyle.Popover
            objPopOverView.popoverPresentationController?.delegate = self
            objPopOverView.popoverPresentationController?.sourceView = sender
            objPopOverView.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.Up
            objPopOverView.preferredContentSize = CGSizeMake(60, 80)
            objPopOverView.popoverPresentationController?.sourceRect = CGRectMake(0, -70, 53, 90)
            self.presentViewController(objPopOverView, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertView(title: "Warning", message: "Please select cost and date first", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
    }
    
    func popOverValueChanged(value: String) {
        
        isPopoverValueChanged = true
        if(dateString == "day")
        {
            print(dateDiff/168)
        }
        else{
            
            print((dateDiff/168)/4)
        }
        popOverSelectedStr = value
        tblView.reloadData()
        
    }
    
    
    func txtFieldCellText(txtFldCell: SavingPlanCostTableViewCell) {
        cost = Int(txtFldCell.slider.value)
    }
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view : UIView = UIView()
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 3
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        if(indexPath.section == 0)
        {
            return 44
        }
        else if(indexPath.section == 1){
            return 90
        }
        else if(indexPath.section == 2){
            return 70
        }
        else if(indexPath.section == 3){
            return 95
        }
        else if(indexPath.section == 4){
            if(isPopoverValueChanged == true)
            {
                return 40
            }
            else{
                return 0
            }
        }
        else if(indexPath.section == 5){
            return 60
        }
        else {
            return 44
        }
    }
    
    
}
