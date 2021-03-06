//
//  SARegistrationViewController.swift
//  Savio
//
//  Created by Prashant on 18/05/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit
//Extend all delegates which are required
class SARegistrationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,TxtFieldTableViewCellDelegate,TitleTableViewCellDelegate,FindAddressCellDelegate,linkButtonTableViewCellDelegate,ButtonCellDelegate,PostCodeVerificationDelegate,DropDownTxtFieldTableViewCellDelegate,PickerTxtFieldTableViewCellDelegate,ImportantInformationViewDelegate,OTPSentDelegate{
    
    @IBOutlet weak var tblView: UITableView!
    var arrRegistration  = [Dictionary <String, AnyObject>]()     //Array for hold json file data to create UI
    var arrRegistrationFields = [UITableViewCell]()               //Array of textfield cell
    var dictForTextFieldValue : Dictionary<String, AnyObject> = [:] // dictionary for saving user data and error messages
    //    var strPostCode = String()
    var objAnimView : ImageViewAnimation?                     //Instance of ImageViewAnimation to showing loding aniation on API call
    var arrAddress = [String]()
    var firstName = ""
    var lastName = ""
    var dateOfBirth = ""
    var phoneNumber = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tblView.estimatedRowHeight = 35
        self.tblView.rowHeight = UITableViewAutomaticDimension
        //Get Registration UI Json data
        self.getJSONForUI()
        //Setup Registration UI
        self.createCells()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    func getJSONForUI(){
        //create file url
        let fileUrl: NSURL = NSBundle.mainBundle().URLForResource("Registration", withExtension: "json")!
        //getting file data
        let jsonData: NSData = NSData(contentsOfURL: fileUrl)!
        //parsing json file to setup UI
        let json = (try! NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments))
        self.arrRegistration = json as! Array
        
    }
    
    func createCells(){
        // if any old cell belong in array then remove all
        if arrRegistrationFields.count>0{
            arrRegistrationFields.removeAll()
        }
        for var i=0; i<arrRegistration.count; i++ {
            // dictionary to identifying cell and its properies
            let dict = arrRegistration[i] as Dictionary<String,AnyObject>
            //get tableviewCell as per the classtype
            let bundleArr : Array = NSBundle.mainBundle().loadNibNamed(dict["classType"] as! String, owner: nil, options: nil)
            
            //Setup all error message lable tableViewCell
            if dict["classType"]!.isEqualToString("ErrorTableViewCell"){
                let metadataDict = dict["metaData"]as! Dictionary<String,AnyObject>
                let cell = bundleArr[0] as! ErrorTableViewCell
                let tfTitleDict = metadataDict["lable"]as! Dictionary<String,AnyObject>
                //Set Error messages to error lable
                cell.lblError?.text = tfTitleDict["title"] as? String
                let isErrorShow = tfTitleDict["isErrorShow"] as! String
                //identifying to which error message show for textfield
                if isErrorShow == "Yes"{
                    arrRegistrationFields.append(cell)
                }
            }
            
            //SetUp Titel and Name textfield tableView cell and its validation messages
            if dict["classType"]!.isEqualToString("TitleTableViewCell"){
                let metadataDict = dict["metaData"]as! Dictionary<String,AnyObject>
                let cell = bundleArr[0] as! TitleTableViewCell
                cell.delegate = self
                cell.tblView = tblView
                cell.dict = dict
                let tfTitleDict = metadataDict["textField1"]as! Dictionary<String,AnyObject>
                cell.tfTitle?.layer.borderColor = UIColor(red: 202/256.0, green: 175/256.0, blue: 120/256.0, alpha: 1.0).CGColor;
                
                cell.tfTitle!.attributedPlaceholder = NSAttributedString(string:(tfTitleDict["placeholder"] as? String)!, attributes:[NSForegroundColorAttributeName:UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1)])
                if (dictForTextFieldValue["title"] != nil){
                    cell.tfTitle?.text = dictForTextFieldValue["title"] as? String
                }
                //                cell.tfTitle?.placeholder = tfTitleDict["placeholder"] as? String
                let tfNameDict = metadataDict["textField2"]as! Dictionary<String,AnyObject>
                cell.tfName!.attributedPlaceholder = NSAttributedString(string:(tfNameDict["placeholder"] as? String)!, attributes:[NSForegroundColorAttributeName:UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1)])
                
                if (dictForTextFieldValue["name"] != nil){
                    cell.tfName?.text = dictForTextFieldValue["name"] as? String
                }
                
                if (dictForTextFieldValue["errorTitle"] != nil) {
                    if dictForTextFieldValue["errorTitle"]!.isEqualToString("We need to know your title and name"){
                        cell.tfName?.layer.borderColor = UIColor.redColor().CGColor
                        cell.tfTitle?.layer.borderColor = UIColor.redColor().CGColor
                    }
                    else if dictForTextFieldValue["errorTitle"]!.isEqualToString("Please select a title"){
                        cell.tfTitle?.layer.borderColor = UIColor.redColor().CGColor
                    }
                    else if dictForTextFieldValue["errorTitle"]!.isEqualToString("We need to know what to call you"){
                        cell.tfName?.layer.borderColor = UIColor.redColor().CGColor
                    }
                    else if (dictForTextFieldValue["errorTitle"]!.isEqualToString("Wow, that’s such a long name we can’t save it") || dictForTextFieldValue["errorTitle"]!.isEqualToString("Surname should contain character only") ){
                        cell.tfName?.textColor = UIColor.redColor()
                    }
                }
                //                cell.tfName?.placeholder = tfNameDict["placeholder"] as? String
                arrRegistrationFields.append(cell)
                
            }
            if dict["classType"]!.isEqualToString("TxtFieldTableViewCell"){
                let metadataDict = dict["metaData"]as! Dictionary<String,AnyObject>
                let cell = bundleArr[0] as! TxtFieldTableViewCell
                cell.delegate = self
                cell.tblView = tblView
                cell.tf?.textColor = UIColor.blackColor()
                cell.tf?.layer.borderColor = UIColor(red: 202/256.0, green: 175/256.0, blue: 120/256.0, alpha: 1.0).CGColor;
                
                let tfTitleDict = metadataDict["textField1"]as! Dictionary<String,AnyObject>
                cell.tf!.attributedPlaceholder = NSAttributedString(string:(tfTitleDict["placeholder"] as? String)!, attributes:[NSForegroundColorAttributeName:UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1)])
                if (dictForTextFieldValue[(cell.tf?.placeholder)!] != nil){
                    cell.tf?.text = dictForTextFieldValue[(cell.tf?.placeholder)!] as? String
                }
                
                if (dictForTextFieldValue["errorTxt"] != nil && cell.tf?.placeholder == "Surname") {
                    let str = dictForTextFieldValue["errorTxt"]
                    if (str!.isEqualToString("We need to know your surname")){
                        cell.tf?.layer.borderColor = UIColor.redColor().CGColor
                    }
                }
                
                if (dictForTextFieldValue["errorSurname"] != nil && cell.tf?.placeholder == "Surname") {
                    let str = dictForTextFieldValue["errorSurname"]
                    if (str!.isEqualToString("Wow, that’s such a long name we can’t save it")){
                        cell.tf?.textColor = UIColor.redColor()
                        cell.tf?.layer.borderColor = UIColor(red: 202/256.0, green: 175/256.0, blue: 120/256.0, alpha: 1.0).CGColor;
                        
                    }
                }
                
                
                if (dictForTextFieldValue["errorFirstAddress"] != nil && cell.tf?.placeholder == "First Address Line") {
                    let str = dictForTextFieldValue["errorFirstAddress"]
                    if (str!.isEqualToString("Don’t forget your house number")){
                        cell.tf?.layer.borderColor = UIColor.redColor().CGColor
                    }
                }
                if (dictForTextFieldValue["errorTown"] != nil && cell.tf?.placeholder == "Town") {
                    let str = dictForTextFieldValue["errorTown"]
                    if (str!.isEqualToString("Don’t forget your town")){
                        cell.tf?.layer.borderColor = UIColor.redColor().CGColor
                    }
                }
                if (dictForTextFieldValue["errorCounty"] != nil && cell.tf?.placeholder == "County") {
                    let str = dictForTextFieldValue["errorCounty"]
                    if (str!.isEqualToString("Don’t forget your county")){
                        cell.tf?.layer.borderColor = UIColor.redColor().CGColor
                    }
                }
                if (dictForTextFieldValue["errorMobile"] != nil && cell.tf?.placeholder == "Mobile number") {
                    let str = dictForTextFieldValue["errorMobile"]
                    if (str!.isEqualToString("Don't forget your mobile number")){
                        cell.tf?.layer.borderColor = UIColor.redColor().CGColor
                    }
                }
                if (dictForTextFieldValue["errorMobileValidation"] != nil && cell.tf?.placeholder == "Mobile number") {
                    let str = dictForTextFieldValue["errorMobileValidation"]
                    if (str!.isEqualToString("That mobile number doesn’t look right")){
                        cell.tf?.textColor = UIColor.redColor()
                        cell.tf?.layer.borderColor = UIColor(red: 202/256.0, green: 175/256.0, blue: 120/256.0, alpha: 1.0).CGColor;
                        
                    }
                }
                if (dictForTextFieldValue["errorEmail"] != nil && cell.tf?.placeholder == "Email") {
                    let str = dictForTextFieldValue["errorEmail"]
                    if (str!.isEqualToString("Don't forget your email address")){
                        cell.tf?.layer.borderColor = UIColor.redColor().CGColor
                    }
                }
                if (dictForTextFieldValue["errorEmailValid"] != nil && cell.tf?.placeholder == "Email") {
                    let str = dictForTextFieldValue["errorEmailValid"]
                    if (str!.isEqualToString("That email address doesn’t look right")){
                        cell.tf?.textColor = UIColor.redColor()
                        cell.tf?.layer.borderColor = UIColor(red: 202/256.0, green: 175/256.0, blue: 120/256.0, alpha: 1.0).CGColor;
                        
                    }
                }
                
                arrRegistrationFields.append(cell)
            }
            
            if dict["classType"]!.isEqualToString("PickerTextfildTableViewCell"){
                let metadataDict = dict["metaData"]as! Dictionary<String,AnyObject>
                let cell = bundleArr[0] as! PickerTextfildTableViewCell
                cell.delegate = self
                cell.tblView = tblView
                let tfTitleDict = metadataDict["textField1"]as! Dictionary<String,AnyObject>
                cell.tfDatePicker!.attributedPlaceholder = NSAttributedString(string:(tfTitleDict["placeholder"] as? String)!, attributes:[NSForegroundColorAttributeName:UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1)])
                cell.tfDatePicker?.layer.borderColor = UIColor(red: 202/256.0, green: 175/256.0, blue: 120/256.0, alpha: 1.0).CGColor;
                if (dictForTextFieldValue[(cell.tfDatePicker?.placeholder)!] != nil){
                    cell.tfDatePicker?.text = dictForTextFieldValue[(cell.tfDatePicker?.placeholder)!] as? String
                    print("\(dictForTextFieldValue)")
                }
                arrRegistrationFields.append(cell)
            }
            
            if dict["classType"]!.isEqualToString("FindAddressTableViewCell"){
                let metadataDict = dict["metaData"]as! Dictionary<String,AnyObject>
                let cell = bundleArr[0] as! FindAddressTableViewCell
                cell.delegate = self
                cell.tblView = tblView
                cell.tfPostCode?.layer.borderColor = UIColor(red: 202/256.0, green: 175/256.0, blue: 120/256.0, alpha: 1.0).CGColor;
                let tfPostcodeDict = metadataDict["textField1"]as! Dictionary<String,AnyObject>
                cell.tfPostCode!.attributedPlaceholder = NSAttributedString(string:(tfPostcodeDict["placeholder"] as? String)!, attributes:[NSForegroundColorAttributeName:UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1)])
                if (dictForTextFieldValue[(cell.tfPostCode?.placeholder)!] != nil){
                    cell.tfPostCode?.text = dictForTextFieldValue[(cell.tfPostCode?.placeholder)!] as? String
                }
                
                if (dictForTextFieldValue["errorPostcode"] != nil) {
                    if dictForTextFieldValue["errorPostcode"]!.isEqualToString("Don’t forget your postcode"){
                        cell.tfPostCode?.layer.borderColor = UIColor.redColor().CGColor
                    }
                }
                
                if (dictForTextFieldValue["errorPostcodeValid"] != nil) {
                    if dictForTextFieldValue["errorPostcodeValid"]!.isEqualToString("That postcode doesn't look right"){
                        cell.tfPostCode?.textColor = UIColor.redColor()
                    }
                }
                
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
                
                let attributes = [
                    NSForegroundColorAttributeName : UIColor(red:100/256, green: 101/256, blue: 109/256, alpha: 1),
                    NSUnderlineStyleAttributeName : NSUnderlineStyle.StyleSingle.rawValue
                ]
                let attributedString = NSAttributedString(string: (btnPostcodeDict["placeholder"] as? String)!, attributes: attributes)
                cell.btnLink?.setAttributedTitle(attributedString, forState: UIControlState.Normal)
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
            
            if dict["classType"]!.isEqualToString("DropDownTxtFieldTableViewCell"){
                let metadataDict = dict["metaData"]as! Dictionary<String,AnyObject>
                let cell = bundleArr[0] as! DropDownTxtFieldTableViewCell
                cell.delegate = self
                cell.tblView = tblView
                cell.dict = dict
                cell.tf?.layer.borderColor = UIColor(red: 202/256.0, green: 175/256.0, blue: 120/256.0, alpha: 1.0).CGColor;
                let tfTitleDict = metadataDict["textField1"]as! Dictionary<String,AnyObject>
                cell.tf!.attributedPlaceholder = NSAttributedString(string:(tfTitleDict["placeholder"] as? String)!, attributes:[NSForegroundColorAttributeName:UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1)])
                if (dictForTextFieldValue[(cell.tf?.placeholder)!] != nil){
                    //                    if (arrAddress.count>0){
                    cell.tf?.text = dictForTextFieldValue[(cell.tf?.placeholder)!] as? String
                    arrRegistrationFields.append(cell)
                }
                //                let arrDropDown = tfTitleDict["dropDownArray"] as! Array<String>
                let arrDropDown = arrAddress
                
                print("\(arrDropDown)")
                cell.arr = arrDropDown
                print("\(cell.arr)")
                if arrDropDown.count>0{
                    arrRegistrationFields.append(cell)
                }
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
//        for var i=0; i<arrRegistrationFields.count; i++ {
//            let cell = arrRegistrationFields[i] //as Dictionary<String,AnyObject>
//            
//            if cell.isKindOfClass(ErrorTableViewCell)          {
//                return 35
//            }
//            else {
//                40
//            }
//        }
        if(indexPath.row == arrRegistrationFields.count - 2){
            return 60.0
        }
        
        return 35
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func selectedDate(txtFldCell:PickerTextfildTableViewCell){
        
        dictForTextFieldValue.updateValue((txtFldCell.tfDatePicker?.text)!, forKey: (txtFldCell.tfDatePicker?.placeholder)!)
    }
    
    
    func txtFieldCellText(txtFldCell:TxtFieldTableViewCell){
        if txtFldCell.tf?.text?.characters.count>0{
            dictForTextFieldValue.updateValue((txtFldCell.tf?.text)!, forKey: (txtFldCell.tf?.placeholder)!)
        }
        else{
            dictForTextFieldValue.removeValueForKey((txtFldCell.tf?.placeholder)!)
        }
        print("\(dictForTextFieldValue)")
    }
    
    func titleCellText(titleCell:TitleTableViewCell){
        if titleCell.tfTitle?.text?.characters.count>0{
            dictForTextFieldValue.updateValue((titleCell.tfTitle?.text)!, forKey: "title")
        }
        if titleCell.tfName?.text?.characters.count>0{
            dictForTextFieldValue.updateValue((titleCell.tfName?.text)!, forKey: "name")
        }
        print("\(dictForTextFieldValue)")
    }
    
    
    func getAddressButtonClicked(findAddrCell: FindAddressTableViewCell){
        //        var strPostCode = String()
        
        let strPostCode = (findAddrCell.tfPostCode?.text)!
        dictForTextFieldValue.updateValue((findAddrCell.tfPostCode?.text)!, forKey: (findAddrCell.tfPostCode?.placeholder)!)
        
        let strCode = strPostCode
        print("\(strPostCode)")
        if strCode.characters.count == 0 {
            var dict = arrRegistration[6] as Dictionary<String,AnyObject>
            var metadataDict = dict["metaData"]as! Dictionary<String,AnyObject>
            let lableDict = metadataDict["lable"]!.mutableCopy()
            lableDict.setValue("Yes", forKey: "isErrorShow")
            lableDict.setValue("Don’t forget your postcode", forKey: "title")
            dictForTextFieldValue["errorPostcode"] = "Don’t forget your postcode"
            
            metadataDict["lable"] = lableDict
            dict["metaData"] = metadataDict
            arrRegistration[6] = dict
            self.createCells()
        }
        else if checkTextFieldContentSpecialChar(strPostCode){
            var dict = arrRegistration[6] as Dictionary<String,AnyObject>
            var metadataDict = dict["metaData"]as! Dictionary<String,AnyObject>
            let lableDict = metadataDict["lable"]!.mutableCopy()
            lableDict.setValue("Yes", forKey: "isErrorShow")
            lableDict.setValue("That postcode doesn't look right", forKey: "title")
            metadataDict["lable"] = lableDict
            dict["metaData"] = metadataDict
            dictForTextFieldValue["errorPostcodeValid"] = "That postcode doesn't look right"
            arrRegistration[6] = dict
            self.createCells()
        }
        else{
            //            NW1W 9BE
            objAnimView = (NSBundle.mainBundle().loadNibNamed("ImageViewAnimation", owner: self, options: nil)[0] as! ImageViewAnimation)
            objAnimView!.frame = self.view.frame
            objAnimView?.animate()
            self.view.addSubview(objAnimView!)
            
            let objGetAddressAPI: API = API()
            objGetAddressAPI.delegate = self
            let trimmedString = strCode.stringByReplacingOccurrencesOfString(" ", withString: "")
            objGetAddressAPI.verifyPostCode(trimmedString)
        }
        
    }
    
    func dropDownTxtFieldCellText(dropDownTextCell:DropDownTxtFieldTableViewCell)
    {
        
        let str = dropDownTextCell.tf?.text
        let fullNameArr = str!.characters.split{$0 == ","}.map(String.init)
        print(fullNameArr)
        //        var addressStr = ""
        //        for var i=0; i<fullNameArr.count-3; i++ {
        //            addressStr = addressStr+" \(fullNameArr[i])"
        //        }
        
        dictForTextFieldValue.updateValue(fullNameArr[0], forKey: "First Address Line")
        dictForTextFieldValue.updateValue(fullNameArr[1], forKey: "Second Address Line")
        dictForTextFieldValue.updateValue(fullNameArr[2], forKey: "Third Address Line")
        
        //        dictForTextFieldValue.updateValue(addressStr, forKey: "First Address Line")
        dictForTextFieldValue.updateValue(fullNameArr[fullNameArr.count-2], forKey: "Town")
        dictForTextFieldValue.updateValue(fullNameArr[fullNameArr.count-1], forKey: "County")
        
        print(dictForTextFieldValue)
        
        //        dictForTextFieldValue.updateValue((dropDownTextCell.tf?.text)!, forKey: (dropDownTextCell.tf?.placeholder)!)
        //        dictForTextFieldValue.updateValue((dropDownTextCell.tf?.text)!, forKey: (dropDownTextCell.tf?.placeholder)!)
        self.createCells()
    }
    func linkButtonClicked(sender:UIButton){
        
        let attributes = [
            NSForegroundColorAttributeName : UIColor(red:100/256, green: 101/256, blue: 109/256, alpha: 1),
            NSUnderlineStyleAttributeName : NSUnderlineStyle.StyleSingle.rawValue
        ]
        let attributedString = NSAttributedString(string: "Back", attributes: attributes)
        
        if(sender.currentAttributedTitle == attributedString){
            self.navigationController?.popViewControllerAnimated(true)
        }
        else
        {
            let objimpInfo = NSBundle.mainBundle().loadNibNamed("ImportantInformationView", owner: self, options: nil)[0] as! ImportantInformationView
            objimpInfo.lblHeader.text = "Why do we need this information?"
            objimpInfo.frame = self.view.frame
            self.view.addSubview(objimpInfo)
        }
    }
    
    
    func buttonClicked(sender:UIButton){
        
        if (checkTextFiledValidation() == false && dictForTextFieldValue["errorPostcodeValid"]==nil){
            //call term and condition screen
            var dict = self.getAllValuesFromTxtFild()
            if(firstName.characters.count>0 && lastName.characters.count>0 && dateOfBirth.characters.count>0)
            {
                for i in 0 ..< arrRegistrationFields.count {
                    //            var  dict : NSMutableDictionary = NSMutableDictionary()
                    if arrRegistrationFields[i].isKindOfClass(TitleTableViewCell){
                        let cell = arrRegistrationFields[i] as! TitleTableViewCell
                        dict["title"] = cell.tfTitle?.text
                        dict["first_name"] = cell.tfName?.text
                    }
                    
                    if arrRegistrationFields[i].isKindOfClass(TitleTableViewCell){
                    }
                }

                
                
                //Webservice call
                if(firstName == dict["first_name"] as! String || lastName == dict["second_name"] as! String || dateOfBirth == dict["date_of_birth"] as! String)
                {
                    objAnimView = (NSBundle.mainBundle().loadNibNamed("ImageViewAnimation", owner: self, options: nil)[0] as! ImageViewAnimation)
                    objAnimView!.frame = self.view.frame
                    objAnimView?.animate()
                    self.view.addSubview(objAnimView!)
                    
                    let objAPI = API()
                    objAPI.delegate = self
                    objAPI.registerTheUserWithTitle(dict,apiName: "Customers")
                }
                else{
                    let alert = UIAlertController(title: "Looks like you have earlier enrolled personal details", message: "Enter your firstname, lastname, date of birth as earlier", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                }
            }
            else{
                let objImpInfo = NSBundle.mainBundle().loadNibNamed("ImportantInformationView", owner: self, options: nil)[0] as! ImportantInformationView
                objImpInfo.delegate = self
                objImpInfo.lblHeader.text = "Terms & Conditions"
                //            objImpInfo.lblHeading.text = "Term And Condition"
                objImpInfo.frame = self.view.frame
                self.view.addSubview(objImpInfo)
            }
        }
        else{
            if dictForTextFieldValue["errorPostcodeValid"] != nil{
                var dict = arrRegistration[5] as Dictionary<String,AnyObject>
                var metadataDict = dict["metaData"]as! Dictionary<String,AnyObject>
                let lableDict = metadataDict["lable"]!.mutableCopy()
                lableDict.setValue("Yes", forKey: "isErrorShow")
                lableDict.setValue("That postcode doesn't look right", forKey: "title")
                metadataDict["lable"] = lableDict
                dict["metaData"] = metadataDict
                dictForTextFieldValue["errorPostcodeValid"] = "That postcode doesn't look right"
                arrRegistration[5] = dict
                self.createCells()
            }
        }
    }
    
    
    func getAllValuesFromTxtFild()-> Dictionary<String,AnyObject>{
        var dict = Dictionary<String, AnyObject>()
        
        for i in 0 ..< arrRegistrationFields.count {
            //            var  dict : NSMutableDictionary = NSMutableDictionary()
            if arrRegistrationFields[i].isKindOfClass(TitleTableViewCell){
                let cell = arrRegistrationFields[i] as! TitleTableViewCell
                dict["title"] = cell.tfTitle?.text
                dict["first_name"] = cell.tfName?.text
            }
            
            if arrRegistrationFields[i].isKindOfClass(TxtFieldTableViewCell){
                let cell = arrRegistrationFields[i] as! TxtFieldTableViewCell
                //                if cell.tf?.placeholder == "Surname"{
                //                    dict["second_name"] = cell.tf?.text
                //                }
                if cell.tf?.placeholder == "Surname"{
                    dict["second_name"] = cell.tf?.text
                }
                if cell.tf?.placeholder == "First Address Line"{
                    dict["address_1"] = cell.tf?.text
                }
                if cell.tf?.placeholder == "Second Address Line"{
                    dict["address_2"] = cell.tf?.text
                }
                if cell.tf?.placeholder == "Third Address Line"{
                    dict["address_3"] = cell.tf?.text
                }
                
                if cell.tf?.placeholder == "Town"{
                    dict["town"] = cell.tf?.text
                }
                
                if cell.tf?.placeholder == "Mobile number"{
                    dict["phone_number"] = cell.tf?.text
                }
                if cell.tf?.placeholder == "County"{
                    dict["county"] = cell.tf?.text
                }
                
                if cell.tf?.placeholder == "Email"{
                    dict["email"] = cell.tf?.text
                }
            }
            
            if arrRegistrationFields[i].isKindOfClass(FindAddressTableViewCell){
                let cell = arrRegistrationFields[i] as! FindAddressTableViewCell
                dict["post_code"] = cell.tfPostCode?.text
                //                dict["post_code"] = "se19dy"
            }
            
            if arrRegistrationFields[i].isKindOfClass(PickerTextfildTableViewCell){
                let cell = arrRegistrationFields[i] as! PickerTextfildTableViewCell
                dict["date_of_birth"] = cell.tfDatePicker?.text
            }
            //            let udidDict : Dictionary<String,String> = ["DEVICE_ID":NSUUID().UUIDString]
            //            dict["deviceRegistration"] = udidDict
            //            dict["device_ID"] = NSUUID().UUIDString
            
            let udidDict : Dictionary<String,AnyObject> = ["DEVICE_ID":UIDevice.currentDevice().identifierForVendor!.UUIDString]
            
            let udidArray: Array<Dictionary<String,AnyObject>> = [udidDict]
            dict["deviceRegistration"] =  udidArray
            
            
        }
        return dict
    }
    
    func checkTextFieldContentSpecialChar(str:String)->Bool{
        
        let characterSet:NSCharacterSet = NSCharacterSet(charactersInString: "~!@#$%^&*()_-+={}|\\;:'\",.<>*/")
        
        if (str.rangeOfCharacterFromSet(characterSet) != nil) {
            return true
        }
        else{
            return false
        }
    }

    
    
    
    func acceptPolicy(obj:ImportantInformationView){
        var dict = self.getAllValuesFromTxtFild()
        
        
        let objAPI = API()
        print("DictPara:\(dict)")
       // objAPI.storeValueInKeychainForKey("myUserInfo", value: dict)
        
        if(changePhoneNumber == false)
        {
            objAnimView = (NSBundle.mainBundle().loadNibNamed("ImageViewAnimation", owner: self, options: nil)[0] as! ImageViewAnimation)
            objAnimView!.frame = self.view.frame
            objAnimView?.animate()
            self.view.addSubview(objAnimView!)
            
            
            objAPI.delegate = self
            objAPI.registerTheUserWithTitle(dict,apiName: "Customers")
            return
            
        }
        else{
            if(objAPI.getValueFromKeychainOfKey("myMobile") as! String == dict["phone_number"] as! String)
            {
                objAnimView = (NSBundle.mainBundle().loadNibNamed("ImageViewAnimation", owner: self, options: nil)[0] as! ImageViewAnimation)
                objAnimView!.frame = self.view.frame
                objAnimView?.animate()
                self.view.addSubview(objAnimView!)
                
                
                objAPI.delegate = self
                objAPI.registerTheUserWithTitle(dict,apiName: "Customers")
                
            }
            else
            {
                let alert = UIAlertController(title: "Looks like you have an earlier enrolled mobile number", message: "", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
        
    }
    
    //Function checking textfield content only number or not
    func checkTextFieldContentOnlyNumber(str:String)->Bool{
        let set = NSCharacterSet.decimalDigitCharacterSet()
        if (str.rangeOfCharacterFromSet(set) != nil) {
            return true
        }
        else{
            return false
        }
    }
    
    func checkTextFieldContentCharacters(str:String)->Bool{
        let set = NSCharacterSet.letterCharacterSet()
        if (str.rangeOfCharacterFromSet(set) != nil) {
            return true
        }
        else{
            return false
        }
    }
    
    
    func checkTextFiledValidation()->Bool{
        var returnFlag = false
        self.getJSONForUI()
        var idx = 0
        for var i=0; i<arrRegistrationFields.count; i++ {
            var errorFLag = false
            var errorMsg = ""
            var dict = Dictionary<String, AnyObject>()
            //            var  dict : NSMutableDictionary = NSMutableDictionary()
            if arrRegistrationFields[i].isKindOfClass(TitleTableViewCell){
                let cell = arrRegistrationFields[i] as! TitleTableViewCell
                let str = cell.tfName?.text
                
                if (self.checkTextFieldContentOnlyNumber(str!) == true){
                    errorMsg = "Name should contain alphabets only"
                    errorFLag = true
                    dictForTextFieldValue["errorTitle"] = errorMsg
                }
                
                if checkTextFieldContentSpecialChar(str!){
                    errorMsg = "Name should not contain special characters"
                    errorFLag = true
                    dictForTextFieldValue["errorTitle"] = errorMsg
                }
                
                if str?.characters.count > 50{
                    errorMsg = "Wow, that’s such a long name we can’t save it"
                    errorFLag = true
                    dictForTextFieldValue["errorTitle"] = errorMsg
                }
                    
                else if(cell.tfTitle?.text?.characters.count == 0 && cell.tfName?.text?.characters.count == 0){
                    errorMsg = "We need to know your title and name"
                    errorFLag = true
                    cell.tfTitle?.layer.borderColor = UIColor.redColor().CGColor
                    cell.tfName?.layer.borderColor = UIColor.redColor().CGColor
                    dictForTextFieldValue["errorTitle"] = errorMsg
                    
                }
                else if cell.tfTitle?.text == ""{
                    errorMsg = "Please select a title"
                    errorFLag = true
                    dictForTextFieldValue["errorTitle"] = errorMsg
                    
                }
                else if str==""{
                    errorMsg = "We need to know what to call you"
                    errorFLag = true
                    dictForTextFieldValue["errorTitle"] = errorMsg
                    
                }
                else{
                    dictForTextFieldValue.removeValueForKey("errorTitle")
                    
                }
                
                dict = arrRegistration[0] as Dictionary<String,AnyObject>
                idx = 0
            }
            
            if arrRegistrationFields[i].isKindOfClass(TxtFieldTableViewCell){
                let cell = arrRegistrationFields[i] as! TxtFieldTableViewCell
                if cell.tf?.placeholder == "Surname"{
                    let str = cell.tf?.text
                    if str==""{
                        errorFLag = true
                        errorMsg = "We need to know your surname"
                        dictForTextFieldValue["errorTxt"] = errorMsg
                        
                    }
                    else{
                        dictForTextFieldValue.removeValueForKey("errorTxt")
                    }
                    
                    if(str?.characters.count>50){
                        errorMsg = "Wow, that’s such a long name we can’t save it"
                        errorFLag = true
                        dictForTextFieldValue["errorSurname"] = errorMsg
                        //                        dictForTextFieldValue["errorTxt"] = errorMsg
                    }
                    else if(self.checkTextFieldContentOnlyNumber(str!) == true){
                        errorMsg = "Surname should contain alphabets only"
                        errorFLag = true
                        dictForTextFieldValue["errorSurname"] = errorMsg
                        //                        dictForTextFieldValue["errorTxt"] = errorMsg
                    }
                    else if checkTextFieldContentSpecialChar(str!){
                        errorMsg = "Surname should not contain special characters"
                        errorFLag = true
                        dictForTextFieldValue["errorSurname"] = errorMsg
                    }
                    else{
                        dictForTextFieldValue.removeValueForKey("errorSurname")
                    }
                    
                    dict = arrRegistration[2]as Dictionary<String,AnyObject>
                    idx = 2
                }
                
                if cell.tf?.placeholder == "First Address Line"{
                    let str = cell.tf?.text
                    if str==""{
                        errorFLag = true
                        errorMsg = "Don’t forget your house number"
                        dictForTextFieldValue["errorFirstAddress"] = errorMsg
                        //                        dictForTextFieldValue["errorTxt"] = errorMsg
                    }
                    else{
                        dictForTextFieldValue.removeValueForKey("errorFirstAddress")
                    }
                    
                    dict = arrRegistration[9]as Dictionary<String,AnyObject>
                    idx = 9
                }
                
                if cell.tf?.placeholder == "Town"{
                    let str = cell.tf?.text
                    if str==""{
                        errorFLag = true
                        errorMsg = "Don’t forget your town"
                        dictForTextFieldValue["errorTown"] = errorMsg
                        //                        dictForTextFieldValue["errorTxt"] = errorMsg
                    }
                    else{
                        dictForTextFieldValue.removeValueForKey("errorTown")
                    }
                    
                    dict = arrRegistration[13]as Dictionary<String,AnyObject>
                    idx = 13
                }
                
                if cell.tf?.placeholder == "County"{
                    let str = cell.tf?.text
                    if str==""{
                        errorFLag = true
                        errorMsg = "Don’t forget your county"
                        dictForTextFieldValue["errorCounty"] = errorMsg
                        //                        dictForTextFieldValue["errorTxt"] = errorMsg
                    }
                    else{
                        dictForTextFieldValue.removeValueForKey("errorCounty")
                    }
                    
                    dict = arrRegistration[15]as Dictionary<String,AnyObject>
                    idx = 15
                }
                
                if cell.tf?.placeholder == "Mobile number"{
                    let str = cell.tf?.text
                    if str==""{
                        errorFLag = true
                        errorMsg = "Don't forget your mobile number"
                        dictForTextFieldValue["errorMobile"] = errorMsg
                        //                        dictForTextFieldValue["errorTxt"] = errorMsg
                        
                    }
                        
                    else{
                        dictForTextFieldValue.removeValueForKey("errorMobile")
                    }
                    
                    if(self.checkTextFieldContentCharacters(str!) == true || self.phoneNumberValidation(str!)==false){
                        errorFLag = true
                        errorMsg = "That mobile number doesn’t look right"
                        dictForTextFieldValue["errorMobileValidation"] = errorMsg
                    }
                    else if(str?.characters.count < 10)
                    {
                        errorFLag = true
                        errorMsg = "That mobile number should be greater than 10 digits"
                        dictForTextFieldValue["errorMobileValidation"] = errorMsg
                    }
                    else if(str?.characters.count > 16)
                    {
                        errorFLag = true
                        errorMsg = "That mobile number should be of 15 digits"
                        dictForTextFieldValue["errorMobileValidation"] = errorMsg
                    }
                    else{
                        dictForTextFieldValue.removeValueForKey("errorMobileValidation")
                    }
                    
                    dict = arrRegistration[18]as Dictionary<String,AnyObject>
                    idx = 18
                }
                
                if cell.tf?.placeholder == "Email"{
                    let str = cell.tf?.text
                    if str==""{
                        errorFLag = true
                        errorMsg = "Don't forget your email address"
                        //                        dictForTextFieldValue["errorTxt"] = errorMsg
                        dictForTextFieldValue["errorEmail"] = errorMsg
                    }
                        
                    else{
                        dictForTextFieldValue.removeValueForKey("errorEmail")
                        
                    }
                    
                    if str?.characters.count>0 && (self.isValidEmail(str!)==false){
                        errorFLag = true
                        errorMsg = "That email address doesn’t look right"
                        //                        dictForTextFieldValue["errorTxt"] = errorMsg
                        dictForTextFieldValue["errorEmailValid"] = errorMsg
                    }
                    else{
                        dictForTextFieldValue.removeValueForKey("errorEmailValid")
                    }
                    dict = arrRegistration[20]as Dictionary<String,AnyObject>
                    idx = 20
                }
                
                
                if errorMsg.characters.count > 0
                {
                    
                }
                
            }
            
            if arrRegistrationFields[i].isKindOfClass(FindAddressTableViewCell){
                let cell = arrRegistrationFields[i] as! FindAddressTableViewCell
                let str = cell.tfPostCode?.text
                if str==""{
                    errorFLag = true
                    errorMsg = "Don’t forget your postcode"
                    dictForTextFieldValue["errorPostcode"] = errorMsg
                    dictForTextFieldValue.removeValueForKey("errorPostcodeValid")
                    dictForTextFieldValue.removeValueForKey("Postcode")
                    
                }
                else{
                    dictForTextFieldValue.removeValueForKey("errorPostcode")
                }
                dict = arrRegistration[6]as Dictionary<String,AnyObject>
                idx = 6
            }
            
            if arrRegistrationFields[i].isKindOfClass(PickerTextfildTableViewCell){
                let cell = arrRegistrationFields[i] as! PickerTextfildTableViewCell
                let str = cell.tfDatePicker?.text
                if str==""{
                    errorFLag = true
                    errorMsg = "We need to know your date of birth"
                    dictForTextFieldValue["errorDOB"] = errorMsg
                    
                }
                else{
                    dictForTextFieldValue.removeValueForKey("errorDOB")
                }
                dict = arrRegistration[4]as Dictionary<String,AnyObject>
                idx = 4
            }
            
            print("\(idx)")
            
            if(errorFLag == true){
                returnFlag = true
                var metadataDict = dict["metaData"]as! Dictionary<String,AnyObject>
                let lableDict = metadataDict["lable"]!.mutableCopy()
                
                lableDict.setValue("Yes", forKey: "isErrorShow")
                if errorMsg.characters.count>0{
                    lableDict.setValue(errorMsg, forKey: "title")
                }
                metadataDict["lable"] = lableDict
                dict["metaData"] = metadataDict
                arrRegistration[idx] = dict
                //                    print("\(dict)")
                
            }
        }
        self.createCells()
        return returnFlag
    }
    
    
    
    func phoneNumberValidation(value: String) -> Bool {
        //        var flag: Bool = false
        //        if(self.checkTextFieldContentOnlyNumber(value) == true){
        //            return
        //        }
        
        
        let charcter  = NSCharacterSet(charactersInString: "0123456789").invertedSet
        var filtered:NSString!
        let inputString:NSArray = value.componentsSeparatedByCharactersInSet(charcter)
        filtered = inputString.componentsJoinedByString("")
        
        
        
        return  value == filtered
    }
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(testStr)
        return result
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
    
    //OTP Verification Delegate Method
    func successResponseForOTPSentAPI(objResponse:Dictionary<String,AnyObject>)
    {
        objAnimView?.removeFromSuperview()
        let fiveDigitVerificationViewController = FiveDigitVerificationViewController(nibName:"FiveDigitVerificationViewController",bundle: nil)
        self.navigationController?.pushViewController(fiveDigitVerificationViewController, animated: true)
    }
    func errorResponseForOTPSentAPI(error:String){
        objAnimView?.removeFromSuperview()
        let fiveDigitVerificationViewController = FiveDigitVerificationViewController(nibName:"FiveDigitVerificationViewController",bundle: nil)
        self.navigationController?.pushViewController(fiveDigitVerificationViewController, animated: true)
        
        
    }
    
    
    //PostCode Verification Delegate Method
    func success(addressArray:Array<String>){
        objAnimView?.removeFromSuperview()
        self.getJSONForUI()
        //        arrAddress = addressArray
        //        print("\(arrAddress)")
        
        var dict = arrRegistration[8] as Dictionary<String,AnyObject>
        var metadataDict = dict["metaData"]as! Dictionary<String,AnyObject>
        let lableDict = metadataDict["textField1"]!.mutableCopy()
        lableDict.setValue(addressArray, forKey: "dropDownArray")
        metadataDict["textField1"] = lableDict
        dict["metaData"] = metadataDict
        arrRegistration[8] = dict
        arrAddress = addressArray
        print("\(arrAddress)")
        dictForTextFieldValue.removeValueForKey("errorPostcodeValid")
        self.createCells()
    }
    func error(error:String){
        objAnimView?.removeFromSuperview()
        print("\(error)")
        if(error == "That postcode doesn't look right"){
            var dict = arrRegistration[6] as Dictionary<String,AnyObject>
            var metadataDict = dict["metaData"]as! Dictionary<String,AnyObject>
            let lableDict = metadataDict["lable"]!.mutableCopy()
            lableDict.setValue("Yes", forKey: "isErrorShow")
            lableDict.setValue(error, forKey: "title")
            metadataDict["lable"] = lableDict
            dict["metaData"] = metadataDict
            dictForTextFieldValue["errorPostcodeValid"] = "That postcode doesn't look right"
            arrRegistration[6] = dict
            self.createCells()
        }
        else{
            let alert = UIAlertController(title: error, message: "", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    func successResponseForRegistrationAPI(objResponse:Dictionary<String,AnyObject>){
        objAnimView?.removeFromSuperview()
        print("\(objResponse)")
        
        
       
        if(objResponse["message"] as! String == "All field are match")
        {
            let alert = UIAlertController(title: "Looks like you are an existing user, change your Passcode", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Create Passcode", style: UIAlertActionStyle.Cancel, handler: { action -> Void in
                checkString = "ForgotPasscode"
                let objAPI = API()
                objAPI.storeValueInKeychainForKey("userInfo", value: objResponse["party"]!)
                checkString = "ForgotPasscode"
                let objCreatePINView = CreatePINViewController(nibName: "CreatePINViewController",bundle: nil)
                self.navigationController?.pushViewController(objCreatePINView, animated: true)
                
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if(objResponse["message"] as! String == "Three Field is match and Mobile number is different")
        {
            changePhoneNumber = true
            var dict = objResponse["party"] as! Dictionary<String,AnyObject>
            let objAPI = API()
            objAPI.storeValueInKeychainForKey("myMobile", value: dict["phone_number"] as! String)
            
            let alert = UIAlertController(title: "Looks like you have an earlier enrolled mobile number", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            for var i=0; i<arrRegistrationFields.count; i++ {
                //            var  dict : NSMutableDictionary = NSMutableDictionary()
                if arrRegistrationFields[i].isKindOfClass(TitleTableViewCell)
                {
                    let cell = arrRegistrationFields[i] as! TitleTableViewCell
                    
                }
                
                if arrRegistrationFields[i].isKindOfClass(TxtFieldTableViewCell)
                {
                    let cell = arrRegistrationFields[i] as! TxtFieldTableViewCell
                    
                    if cell.tf?.placeholder == "Mobile number"{
                        cell.tf?.becomeFirstResponder()
                        cell.tf?.text = ""
                    }
                }
            }
            
        }
        else if(objResponse["message"] as! String == "Three Field is not match and Mobile number is match")
        {
            var dict = objResponse["party"] as! Dictionary<String,AnyObject>
            firstName = dict["first_name"] as! String
            lastName = dict["second_name"] as! String
            dateOfBirth = dict["date_of_birth"] as! String
            
            let alert = UIAlertController(title: "Looks like you have earlier enrolled personal details", message: "Enter your firstname, lastname, date of birth as earlier", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
            
        else{
             checkString = "Register"
            let objAPI = API()
            objAPI.storeValueInKeychainForKey("userInfo", value: objResponse["party"]!)
            objAPI.otpSentDelegate = self
            objAPI.getOTPForNumber(dictForTextFieldValue["Mobile number"] as! String, country_code: "91")
            
            
        }
    }
    func errorResponseForRegistrationAPI(error:String){
        objAnimView?.removeFromSuperview()
        
    }
    
}




