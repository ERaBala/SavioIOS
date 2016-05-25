//
//  SARegistrationViewController.swift
//  Savio
//
//  Created by Prashant on 18/05/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class SARegistrationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,TxtFieldTableViewCellDelegate,TitleTableViewCellDelegate,FindAddressCellDelegate,linkButtonTableViewCellDelegate,ButtonCellDelegate,PostCodeVerificationDelegate,DropDownTxtFieldTableViewCellDelegate,PickerTxtFieldTableViewCellDelegate,ImportantInformationViewDelegate,OTPSentDelegate{
    
    @IBOutlet weak var tblView: UITableView!
    var arrRegistration  = [Dictionary <String, AnyObject>]()
    var arrRegistrationFields = [UITableViewCell]()
    var dictForTextFieldValue : Dictionary<String, AnyObject> = [:]
    var strPostCode = String()
    var objAnimView : ImageViewAnimation?
    var arrAddress = [String]()



    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //tblView.registerClass(TitleTableViewCell.self, forCellReuseIdentifier: "CellID")
        
        self.tblView.estimatedRowHeight = 35
        self.tblView.rowHeight = UITableViewAutomaticDimension
        self.getJSONForUI()
        self.createCells()
        
        
        
       

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getJSONForUI(){
        let fileUrl: NSURL = NSBundle.mainBundle().URLForResource("Registration", withExtension: "json")!
        let jsonData: NSData = NSData(contentsOfURL: fileUrl)!
        //        let jsonError: NSError?
        //        let arr: NSArray = (try! NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)) as! NSArray
        let json = (try! NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments))
        self.arrRegistration = json as! Array
//        print("\(self.arrRegistration)")

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
                    else if dictForTextFieldValue["errorTitle"]!.isEqualToString("Wow, that’s such a long name we can’t save it"){
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
                if (dictForTextFieldValue["errorEmailValid"] != nil && cell.tf?.placeholder == "Mobile Number") {
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
                let arrDropDown = tfTitleDict["dropDownArray"] as! Array<String>
//                let arrDropDown = arrAddress

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
        for var i=0; i<arrRegistration.count; i++ {
            let dict = arrRegistration[i] as Dictionary<String,AnyObject>
                if dict["classType"]!.isEqualToString("ErrorTableViewCell"){
        return 30.0
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
    
    func selectedDate(txtFldCell:PickerTextfildTableViewCell){
        
        dictForTextFieldValue.updateValue((txtFldCell.tfDatePicker?.text)!, forKey: (txtFldCell.tfDatePicker?.placeholder)!)
    }
//    func cancleToSelectDate(txtFldCell:PickerTextfildTableViewCell){
//        dictForTextFieldValue.updateValue((txtFldCell.tfDatePicker?.text)!, forKey: (txtFldCell.tfDatePicker?.placeholder)!)
//
//    }
//    

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
    
        strPostCode = (findAddrCell.tfPostCode?.text)!
        dictForTextFieldValue.updateValue((findAddrCell.tfPostCode?.text)!, forKey: (findAddrCell.tfPostCode?.placeholder)!)

        let strCode = strPostCode
        print("\(strPostCode)")
        if strCode.characters.count == 0 {
            var dict = arrRegistration[5] as Dictionary<String,AnyObject>
            var metadataDict = dict["metaData"]as! Dictionary<String,AnyObject>
            let lableDict = metadataDict["lable"]!.mutableCopy()
            lableDict.setValue("Yes", forKey: "isErrorShow")
            lableDict.setValue("Don’t forget your postcode", forKey: "title")
            dictForTextFieldValue["errorPostcode"] = "Don’t forget your postcode"

            metadataDict["lable"] = lableDict
            dict["metaData"] = metadataDict
            arrRegistration[5] = dict
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
        dictForTextFieldValue.updateValue((dropDownTextCell.tf?.text)!, forKey: (dropDownTextCell.tf?.placeholder)!)

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
            let objimpInfo = NSBundle.mainBundle().loadNibNamed("ImportantInformationView", owner: self, options: nil)[0] as! UIView
            objimpInfo.frame = self.view.frame
            self.view.addSubview(objimpInfo)
        }
    }
    
    
    func buttonClicked(sender:UIButton){

        if checkTextFiledValidation() == false{
            //call term and condition screen
            
            let objImpInfo = NSBundle.mainBundle().loadNibNamed("ImportantInformationView", owner: self, options: nil)[0] as! ImportantInformationView
            objImpInfo.delegate = self
//            objImpInfo.lblHeading.text = "Term And Condition"
            objImpInfo.frame = self.view.frame
            self.view.addSubview(objImpInfo)
        }

    
    }
    
    //
    
    func acceptPolicy(obj:ImportantInformationView){
        var dict = Dictionary<String, AnyObject>()

        for var i=0; i<arrRegistrationFields.count; i++ {
            //            var  dict : NSMutableDictionary = NSMutableDictionary()
            if arrRegistrationFields[i].isKindOfClass(TitleTableViewCell){
                let cell = arrRegistrationFields[i] as! TitleTableViewCell
                dict["title"] = cell.tfTitle?.text
                dict["first_name"] = cell.tfTitle?.text
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
            }
            
            if arrRegistrationFields[i].isKindOfClass(PickerTextfildTableViewCell){
                let cell = arrRegistrationFields[i] as! PickerTextfildTableViewCell
                dict["date_of_birth"] = cell.tfDatePicker?.text
            }
            
            dict["device_ID"] = NSUUID().UUIDString
            
            dict["pin"] = ""
            
            dict["confirm_pin"] = ""
        }
        
        print("DictPara:\(dict)")
        
        

        objAnimView = (NSBundle.mainBundle().loadNibNamed("ImageViewAnimation", owner: self, options: nil)[0] as! ImageViewAnimation)
        objAnimView!.frame = self.view.frame
        objAnimView?.animate()
        self.view.addSubview(objAnimView!)
        
        let objAPI = API()
        objAPI.delegate = self
        objAPI.registerTheUserWithTitle(dict)
        objAPI.storeValueInKeychainForKey("userInfo", value: dict)
        
//        objAPI.registerTheUserWithTitle(dictForTextFieldValue["title"] as! String, first_name: dictForTextFieldValue["name"] as! String, second_name: dictForTextFieldValue["Surname"] as! String, date_of_birth: dictForTextFieldValue["Date of birth"] as! String, email: dictForTextFieldValue["Email"] as! String, phone_number: dictForTextFieldValue[Mobile number] as! String, address_1: dictForTextFieldValue["title"] as! String, address_2: dictForTextFieldValue["title"] as! String, address_3: dictForTextFieldValue["title"] as! String, town: dictForTextFieldValue["title"] as! String, country: dictForTextFieldValue["title"] as! String, post_code: dictForTextFieldValue["title"] as! String, house_number: dictForTextFieldValue["title"] as! String)
        
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
                    
                    dict = arrRegistration[8]as Dictionary<String,AnyObject>
                    idx = 8
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
                    
                    dict = arrRegistration[12]as Dictionary<String,AnyObject>
                    idx = 12
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
                    
                    dict = arrRegistration[14]as Dictionary<String,AnyObject>
                    idx = 14
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
                        
                        if(self.phoneNumberValidation(str!)==false){
                        errorFLag = true
                        errorMsg = "That mobile number doesn’t look right"
                        dictForTextFieldValue["errorMobileValidation"] = errorMsg
                        //                        dictForTextFieldValue["errorTxt"] = errorMsg
                        
                        
                    }
                    else{
                        dictForTextFieldValue.removeValueForKey("errorMobileValidation")
                    }
                    
                    dict = arrRegistration[17]as Dictionary<String,AnyObject>
                    idx = 17
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
                    
                    if(self.isValidEmail(str!)==false){
                        errorFLag = true
                        errorMsg = "That email address doesn’t look right"
                        //                        dictForTextFieldValue["errorTxt"] = errorMsg
                        dictForTextFieldValue["errorEmailValid"] = errorMsg
                    }
                    else{
                        dictForTextFieldValue.removeValueForKey("errorEmailValid")
                    }
                    dict = arrRegistration[19]as Dictionary<String,AnyObject>
                    idx = 19
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
                }
                else{
                    dictForTextFieldValue.removeValueForKey("errorPostcode")
                }
                dict = arrRegistration[5]as Dictionary<String,AnyObject>
                idx = 5
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
        
        var dict = arrRegistration[7] as Dictionary<String,AnyObject>
        var metadataDict = dict["metaData"]as! Dictionary<String,AnyObject>
        let lableDict = metadataDict["textField1"]!.mutableCopy()
         lableDict.setValue(addressArray, forKey: "dropDownArray")
        metadataDict["textField1"] = lableDict
        dict["metaData"] = metadataDict
        arrRegistration[7] = dict
        print("\(dict)")
        dictForTextFieldValue.removeValueForKey("errorPostcodeValid")
        self.createCells()
    }
    func error(error:String){
        objAnimView?.removeFromSuperview()
        print("\(error)")
        if(error == "The postcode doesn't look right"){
        var dict = arrRegistration[5] as Dictionary<String,AnyObject>
        var metadataDict = dict["metaData"]as! Dictionary<String,AnyObject>
        let lableDict = metadataDict["lable"]!.mutableCopy()
        lableDict.setValue("Yes", forKey: "isErrorShow")
        lableDict.setValue(error, forKey: "title")
        metadataDict["lable"] = lableDict
        dict["metaData"] = metadataDict
        dictForTextFieldValue["errorPostcodeValid"] = "That postcode doesn't look right"
        arrRegistration[5] = dict
        self.createCells()
        }
    }
    
    func successResponseForRegistrationAPI(objResponse:Dictionary<String,AnyObject>){
        objAnimView?.removeFromSuperview()
        print("\(objResponse)")
        
        let objAPI = API()
        objAPI.otpSentDelegate = self
        objAPI.getOTPForNumber(dictForTextFieldValue["Mobile number"] as! String, country_code: "91")
      
        

    }
    func errorResponseForRegistrationAPI(error:String){
        objAnimView?.removeFromSuperview()

    }
    
}
