//
//  SASavingPlanViewController.swift
//  Savio
//
//  Created by Maheshwari on 01/06/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class SASavingPlanViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate,PopOverDelegate,SavingPlanCostTableViewCellDelegate,SavingPlanDatePickerCellDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var topBackgroundImageView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var savingPlanTitleLabel: UILabel!
    var cost : Int = 0
    var dateDiff : Int = 0
    var dateString = ""
    var popOverSelectedStr = ""
    var imageDataDict : Dictionary<String,AnyObject> = [:]
    var offerCount = 0
    
    
    var isPopoverValueChanged = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Savings plan setup"
        let font = UIFont(name: "GothamRounded-Book", size: 15)
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: font!]
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        savingPlanTitleLabel.layer.borderWidth = 1
        savingPlanTitleLabel.layer.borderColor = UIColor.whiteColor().CGColor
        
        tblView!.registerNib(UINib(nibName: "SavingPlanTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "SavingPlanTitleIdentifier")
        tblView!.registerNib(UINib(nibName: "SavingPlanCostTableViewCell", bundle: nil), forCellReuseIdentifier: "SavingPlanCostIdentifier")
        tblView!.registerNib(UINib(nibName: "SavingPlanDatePickerTableViewCell", bundle: nil), forCellReuseIdentifier: "SavingPlanDatePickerIdentifier")
        tblView!.registerNib(UINib(nibName: "SetDayTableViewCell", bundle: nil), forCellReuseIdentifier: "SavingPlanSetDateIdentifier")
        tblView!.registerNib(UINib(nibName: "CalculationTableViewCell", bundle: nil), forCellReuseIdentifier: "SavingPlanCalculationIdentifier")
        //OfferTableViewCell
        tblView!.registerNib(UINib(nibName: "OfferTableViewCell", bundle: nil), forCellReuseIdentifier: "OfferTableViewCellIdentifier")
        tblView!.registerNib(UINib(nibName: "NextButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "NextButtonCellIdentifier")
        tblView!.registerNib(UINib(nibName: "ClearButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "ClearButtonIdentifier")
        
        
        self.setUpView()
     
    }
    

    func setUpView(){
        
        //set Navigation left button
        let leftBtnName = UIButton()
        leftBtnName.setImage(UIImage(named: "nav-back.png"), forState: UIControlState.Normal)
        leftBtnName.frame = CGRectMake(0, 0, 30, 30)
        leftBtnName.addTarget(self, action: #selector(SASavingPlanViewController.backButtonClicked), forControlEvents: .TouchUpInside)
        
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = leftBtnName
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        //set Navigation right button nav-heart
        
        let btnName = UIButton()
        btnName.setBackgroundImage(UIImage(named: "nav-heart.png"), forState: UIControlState.Normal)
        btnName.frame = CGRectMake(0, 0, 30, 30)
        btnName.setTitle("0", forState: UIControlState.Normal)
        btnName.setTitleColor(UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1), forState: UIControlState.Normal)
        btnName.titleLabel!.font = UIFont(name: "GothamRounded-Book", size: 12)
        //  btnName.addTarget(self, action: #selector(SACreateSavingPlanViewController.heartBtnClicked), forControlEvents: .TouchUpInside)
        
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = btnName
        self.navigationItem.rightBarButtonItem = rightBarButton
        imageDataDict =  NSUserDefaults.standardUserDefaults().objectForKey("colorDataDict") as! Dictionary<String,AnyObject>
        if(imageDataDict["header"] as! String == "Group Save")
        {
            topBackgroundImageView.image = UIImage(named: "groupsave-setup-bg.png")
        }
        else if(imageDataDict["header"] as! String == "Wedding")
        {
            topBackgroundImageView.image = UIImage(named: "wdding-setup-bg.png")
        }
        else if(imageDataDict["header"] as! String == "Baby")
        {
//            topBackgroundImageView.image = UIImage(named: "baby-setup-bg.png")
        }
        else if(imageDataDict["header"] as! String == "Holiday")
        {
            topBackgroundImageView.image = UIImage(named: "holiday-setup-bg.png")
        }
        else if(imageDataDict["header"] as! String == "Ride")
        {
            topBackgroundImageView.image = UIImage(named: "ride-setup-bg.png")
        }
        else if(imageDataDict["header"] as! String == "Home")
        {
            topBackgroundImageView.image = UIImage(named: "home-setup-bg.png")
        }
        else if(imageDataDict["header"] as! String == "Gadget")
        {
            topBackgroundImageView.image = UIImage(named: "gadget-setup-bg.png")
        }
        else
        {
            topBackgroundImageView.image = UIImage(named: "generic-setup-bg.png")
        }
    }
    
    func backButtonClicked()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func cameraButtonPressed(sender: AnyObject) {
        
        
        let alertController = UIAlertController(title: "select image from", message: "", preferredStyle:UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default)
        { action -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
                imagePicker.allowsEditing = false
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
            else {
                let alert = UIAlertView(title: "Warning", message: "No camera available", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }

            })
        alertController.addAction(UIAlertAction(title: "Gallery", style: UIAlertActionStyle.Default)
        { action -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                imagePicker.allowsEditing = false
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
            else {
                let alert = UIAlertView(title: "Warning", message: "No camera available", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
            
            })

        self.presentViewController(alertController, animated: true, completion: nil)
        
        
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return offerCount+7
        
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
            cell1.setDayDateButton.tag = indexPath.section
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
        else if(indexPath.section == offerCount+5)
        {
            let cell1 = tableView.dequeueReusableCellWithIdentifier("NextButtonCellIdentifier", forIndexPath: indexPath) as! NextButtonTableViewCell
            cell1.tblView = tblView
            return cell1
        }
        else if(indexPath.section == offerCount+6)
        {
            let cell1 = tableView.dequeueReusableCellWithIdentifier("ClearButtonIdentifier", forIndexPath: indexPath) as! ClearButtonTableViewCell
            cell1.tblView = tblView
            return cell1
        }
        else{
            let cell1 = tableView.dequeueReusableCellWithIdentifier("OfferTableViewCellIdentifier", forIndexPath: indexPath) as! OfferTableViewCell
            cell1.tblView = tblView
            cell1.closeButton.tag = indexPath.section
            cell1.closeButton.addTarget(self, action: Selector("closeOfferButtonPressed:"), forControlEvents: UIControlEvents.TouchUpInside)
            return cell1
        }
        
    }
    
    func datePickerText(date: Int) {
        print(date)
        dateDiff = date
    }
    
    
    func closeOfferButtonPressed(sender:UIButton)
    {
        offerCount = offerCount - 1
        tblView.reloadData()
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
            return 65
        }
        else if(indexPath.section == 4)
        {
            if(isPopoverValueChanged == true)
            {
                return 40
            }
            else{
                return 0
            }
        }
        else if(indexPath.section == offerCount+5)
        {
            return 65
        }
        else if(indexPath.section == offerCount+6){
            return 44
        }
        else {
            return 60
        }
        
    }
    
    //MARK: UIImagePickerControllerDelegate methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker .dismissViewControllerAnimated(true, completion: nil)
        topBackgroundImageView?.image = (info[UIImagePickerControllerOriginalImage] as? UIImage)
        cameraButton.hidden = true
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker .dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
