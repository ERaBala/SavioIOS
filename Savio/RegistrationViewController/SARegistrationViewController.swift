//
//  SARegistrationViewController.swift
//  Savio
//
//  Created by Prashant on 18/05/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class SARegistrationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,TxtFieldTableViewCellDelegate,TitleTableViewCellDelegate,FindAddressCellDelegate,linkButtonTableViewCellDelegate,ButtonCellDelegate{
    
    @IBOutlet weak var tblView: UITableView!
    var arrRegistration  = [Dictionary <String, AnyObject>]()
    var arrRegistrationFields = [UITableViewCell]()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //tblView.registerClass(TitleTableViewCell.self, forCellReuseIdentifier: "CellID")
        
        self.tblView.estimatedRowHeight = 35
        self.tblView.rowHeight = UITableViewAutomaticDimension
        
        let fileUrl: NSURL = NSBundle.mainBundle().URLForResource("Registration", withExtension: "json")!
        let jsonData: NSData = NSData(contentsOfURL: fileUrl)!
//        let jsonError: NSError?
//        let arr: NSArray = (try! NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)) as! NSArray
        let json = (try! NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments))
        self.arrRegistration = json as! Array
         print("\(self.arrRegistration)")
        self.createCells()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createCells(){
//        let flag = true
        if arrRegistrationFields.count>0{
    arrRegistrationFields.removeAll()
        }
        for var i=0; i<arrRegistration.count; i++ {
            let dict = arrRegistration[i] as Dictionary<String,AnyObject>
            let bundleArr : Array = NSBundle.mainBundle().loadNibNamed(dict["classType"] as! String, owner: nil, options: nil)
            
                if dict["classType"]!.isEqualToString("ErrorTableViewCell"){
                    let metadataDict = dict["metaData"]as! Dictionary<String,AnyObject>
                    let cell = bundleArr[0] as! ErrorTableViewCell
                    let tfTitleDict = metadataDict["lable"]as! Dictionary<String,AnyObject>
                    cell.lblError?.text = tfTitleDict["title"] as? String
                    let isErrorShow = tfTitleDict["isErrorShow"] as! String
                    if isErrorShow == "Yes"{
                    arrRegistrationFields.append(cell)
                    }
                }
            
            if dict["classType"]!.isEqualToString("TitleTableViewCell"){
                let metadataDict = dict["metaData"]as! Dictionary<String,AnyObject>
                let cell = bundleArr[0] as! TitleTableViewCell
                cell.delegate = self
                cell.tblView = tblView
                cell.dict = dict
                 let tfTitleDict = metadataDict["textField1"]as! Dictionary<String,AnyObject>
//                cell.tfTitle!.attributedPlaceholder = NSAttributedString(string:(tfTitleDict["placeholder"] as? String)!, attributes:[NSForegroundColorAttributeName:UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1),NSFontAttributeName :UIFont(name: "GothamRounded-Light", size: 14)!])
                
                cell.tfTitle!.attributedPlaceholder = NSAttributedString(string:(tfTitleDict["placeholder"] as? String)!, attributes:[NSForegroundColorAttributeName:UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1)])

                
//                cell.tfTitle?.placeholder = tfTitleDict["placeholder"] as? String
                let tfNameDict = metadataDict["textField2"]as! Dictionary<String,AnyObject>
                 cell.tfName!.attributedPlaceholder = NSAttributedString(string:(tfNameDict["placeholder"] as? String)!, attributes:[NSForegroundColorAttributeName:UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1)])
                
//                cell.tfName?.placeholder = tfNameDict["placeholder"] as? String
                arrRegistrationFields.append(cell)
            
            }
            if dict["classType"]!.isEqualToString("TxtFieldTableViewCell"){
                let metadataDict = dict["metaData"]as! Dictionary<String,AnyObject>
                let cell = bundleArr[0] as! TxtFieldTableViewCell
                cell.delegate = self
                cell.tblView = tblView
                let tfTitleDict = metadataDict["textField1"]as! Dictionary<String,AnyObject>
                 cell.tf!.attributedPlaceholder = NSAttributedString(string:(tfTitleDict["placeholder"] as? String)!, attributes:[NSForegroundColorAttributeName:UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1)])
                arrRegistrationFields.append(cell)

            }
            if dict["classType"]!.isEqualToString("FindAddressTableViewCell"){
                let metadataDict = dict["metaData"]as! Dictionary<String,AnyObject>
                let cell = bundleArr[0] as! FindAddressTableViewCell
                cell.delegate = self
                cell.tblView = tblView
                let tfPostcodeDict = metadataDict["textField1"]as! Dictionary<String,AnyObject>
                cell.tfPostCode!.attributedPlaceholder = NSAttributedString(string:(tfPostcodeDict["placeholder"] as? String)!, attributes:[NSForegroundColorAttributeName:UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1)])

                
                let btnPostcodeDict = metadataDict["button"]as! Dictionary<String,AnyObject>
                cell.btnPostCode?.setTitle(btnPostcodeDict["placeholder"] as? String, forState: UIControlState.Normal)
                arrRegistrationFields.append(cell)
            }
            
            if dict["classType"]!.isEqualToString("linkButtonTableViewCell"){
                let metadataDict = dict["metaData"]as! Dictionary<String,AnyObject>
                let cell = bundleArr[0] as! linkButtonTableViewCell
                cell.delegate = self
                cell.tblView = tblView
                let btnPostcodeDict = metadataDict["button"]as! Dictionary<String,AnyObject>
                cell.btnLink?.setTitle(btnPostcodeDict["placeholder"] as? String, forState: UIControlState.Normal)
                arrRegistrationFields.append(cell)
            }
            
            if dict["classType"]!.isEqualToString("ButtonTableViewCell"){
                let metadataDict = dict["metaData"]as! Dictionary<String,AnyObject>
                let cell = bundleArr[0] as! ButtonTableViewCell
                cell.delegate = self
                cell.tblView = tblView
                let btnPostcodeDict = metadataDict["button"]as! Dictionary<String,AnyObject>
                cell.btn?.setTitle(btnPostcodeDict["placeholder"] as? String, forState: UIControlState.Normal)
                arrRegistrationFields.append(cell)
            }
        }
        tblView.reloadData()
    }

     func numberOfSectionsInTableView(tableView: UITableView) -> Int  {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arrRegistrationFields.count;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        return arrRegistrationFields[indexPath.row]
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        for var i=0; i<arrRegistration.count; i++ {
            let dict = arrRegistration[i] as Dictionary<String,AnyObject>
                if dict["classType"]!.isEqualToString("ErrorTableViewCell"){
        return 35.0
            }
                else{
                    35.0
            }
    }
        return 30.0
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func TxtFieldCellText(txt:String){
        
    }
    func TitleCellText(txt:String){
        
    }
    
    func FindAddressCellText(txt:String){
        
    }
    func getAddressButtonClicked(sender:UIButton){
        
    }
    
    func linkButtonClicked(sender:UIButton){
        
    }
    
    func buttonClicked(sender:UIButton){
        for var i=0; i<1; i++ {
            
            
            let cell = arrRegistrationFields[i] as! TitleTableViewCell
            if cell.isKindOfClass(TitleTableViewCell){
                let str = cell.tfName?.text
                if str==""{
                    let dict = arrRegistration[i] as Dictionary<String,AnyObject>
                    let metadataDict = dict["metaData"]as! Dictionary<String,AnyObject>
                    let lableDict = metadataDict["lable"]!.mutableCopy()
                    lableDict.setValue("Yes", forKey: "isErrorShow")
//                    lableDict.setObject("Yes", forKey: "isErrorShow")
                }
            }
            
            
        }
       self.createCells()
    }
    
//    @IBAction func clickOnRegisterButton(sender:UIButton){
//        
//        for var i=0; i<arrRegistrationFields.count; i++ {
//            let cell = arrRegistrationFields[i] as! TitleTableViewCell
//            if cell.isKindOfClass(TitleTableViewCell){
//              let str = cell.tfName?.text
//                if str==""{
//                    let dict = arrRegistration[i-1] as Dictionary<String,AnyObject>
//                     let metadataDict = dict["metaData"]as! Dictionary<String,AnyObject>
//                    let lableDict = metadataDict["metaData"]as? NSMutableDictionary
//                    lableDict?.setValue("Yes", forKey: "isErrorShow")
//                }
//            }
//            
//            
//            }
//    }
    
    
}
