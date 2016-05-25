//
//  CommonClass.swift
//
//
//  Created by Maheshwari on 17/05/16.
//  Copyright © 2016 Maheshwari. All rights reserved.
//

import UIKit
import SystemConfiguration
import Foundation

let baseURL = "http://54.191.188.214:8080/SavioAPI/V1"
let APIKey = "TYJHDBcrTqsh8l8Jffuv2BSXUIpKV40Z"
let custom_message = "Your Savio phone verification code is {{code}}"

protocol PostCodeVerificationDelegate {
    func success(addressArray:Array<String>)
    func error(error:String)
    
    func successResponseForRegistrationAPI(objResponse:Dictionary<String,AnyObject>)
    func errorResponseForRegistrationAPI(error:String)
}
protocol OTPSentDelegate{
    
    func successResponseForOTPSentAPI(objResponse:Dictionary<String,AnyObject>)
    func errorResponseForOTPSentAPI(error:String)
}

protocol OTPVerificationDelegate{
    
    func successResponseForOTPVerificationAPI(objResponse:Dictionary<String,AnyObject>)
    func errorResponseForOTPVerificationAPI(error:String)
}


class API: UIView {
    let session = NSURLSession.sharedSession()
    var delegate: PostCodeVerificationDelegate?
    var otpSentDelegate : OTPSentDelegate?
    var otpVerificationDelegate : OTPVerificationDelegate?
    
    //Checking Reachability function
    func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    func verifyPostCode(postcode:String){
        
        //Check if network is present
        if(self.isConnectedToNetwork())
        {
            
            let urlString = String(format:"https://api.getaddress.io/v2/uk/%@?api-key=McuJM5nIIEqqGRVCRUBztQ4159",postcode)
            
            let url = NSURL(string: urlString)
            let request = NSURLRequest(URL: url!)
            
            let dataTask = session.dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
                if let data = data
                {
                    let json: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves)
                    if let dict = json as? Dictionary<String,AnyObject>
                    {
                        if let addressArray = dict["Addresses"] as? Array<String>
                        {
                            //if dictionary contains address array return it for the further development
                            dispatch_async(dispatch_get_main_queue()){
                                self.delegate?.success(addressArray)
                            }
                        }
                        else{
                            //else return an error
                            dispatch_async(dispatch_get_main_queue()){
                                print(dict)
                                self.delegate?.error("The postcode doesn't look right")
                            }
                        }
                    }
                }
                
            }
            dataTask.resume()
        }
        else{
             delegate?.error("Network not available")
        }
    }
    
    
    func registerTheUserWithTitle(dictParam:Dictionary<String,AnyObject>)
    {
        
        if(self.isConnectedToNetwork())
        {
            let request = NSMutableURLRequest(URL: NSURL(string: String(format:"%@/Customers/Register",baseURL))!)
            request.HTTPMethod = "POST"
            
            request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(dictParam, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        
            let dataTask = session.dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
                if let data = data
                {
                    let json: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves)
                    print(json)
                    if let dict = json as? Dictionary<String,AnyObject>
                    {
                        print("\(dict)")
                        dispatch_async(dispatch_get_main_queue()){
                            self.delegate?.successResponseForRegistrationAPI(dict)
                        }
                    }
                    else{
                        print("error")
                        dispatch_async(dispatch_get_main_queue()){
                            self.delegate?.errorResponseForRegistrationAPI("Error")
                        }
                        
                    }
                }
                
            }
            dataTask.resume()
        }
        else{
            delegate?.error("No network found")
        }
        
    }
    
    
    
    func getOTPForNumber(phoneNumber:String,country_code:String) {
        
        if(self.isConnectedToNetwork())
        {
            let request = NSMutableURLRequest(URL: NSURL(string:"http://api.authy.com/protected/json/phones/verification/start")!)
            
            request.HTTPMethod = "POST"
            
            let params = ["api_key":APIKey,"via":"sms","phone_number":phoneNumber,"country_code":country_code] as Dictionary<String, String>
            
            request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            print(request)
            let dataTask = session.dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
                if let data = data
                {
                    let json: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves)
                    if let dict = json as? Dictionary<String,AnyObject>
                    {
                        print(dict)
                        if(dict["success"] as! Bool == true)
                        {dispatch_async(dispatch_get_main_queue()){
                            self.otpSentDelegate?.successResponseForOTPSentAPI(dict)
                            }
                        }
                        
                    }
                    else{
                        dispatch_async(dispatch_get_main_queue()){
                            self.otpSentDelegate?.errorResponseForOTPSentAPI((error?.localizedDescription)!)
                        }
                    }
                }
                else{
                    dispatch_async(dispatch_get_main_queue()){
                        self.otpSentDelegate?.errorResponseForOTPSentAPI((error?.localizedDescription)!)
                    }
                }
                
            }
            dataTask.resume()
            
        }
        else{
            self.otpSentDelegate?.errorResponseForOTPSentAPI("No network found")
        }
    }
    
    func verifyOTP(phoneNumber:String,country_code:String,OTP:String)
    {
        if(self.isConnectedToNetwork())
        {
            let dataTask = session.dataTaskWithURL(NSURL(string: String(format: "http://api.authy.com/protected/json/phones/verification/check?api_key=%@&via=sms&phone_number=%@&country_code=%@&verification_code=%@",APIKey,phoneNumber,country_code,OTP))!) { data, response, error in
                if let data = data
                {
                    let json: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableLeaves)
                    if let dict = json as? Dictionary<String,AnyObject>
                    {
                        print(dict)
                        if(dict["message"] as! String  == "Verification code is correct.")
                        {
                            dispatch_async(dispatch_get_main_queue()){
                                self.otpVerificationDelegate?.successResponseForOTPVerificationAPI(dict)
                            }
                        }
                        else if(dict["message"] as! String == "Verification code is incorrect."){
                            dispatch_async(dispatch_get_main_queue()){
                                self.otpVerificationDelegate?.errorResponseForOTPVerificationAPI("Verification code is incorrect.")
                            }
                        }
                        else{
                            dispatch_async(dispatch_get_main_queue()){
                                self.otpVerificationDelegate?.errorResponseForOTPVerificationAPI("Verification code is incorrect.")
                            }
                        }
                        
                    }
                    else{
                        dispatch_async(dispatch_get_main_queue()){
                            self.otpVerificationDelegate?.errorResponseForOTPVerificationAPI((error?.localizedDescription)!)
                        }
                    }
                }
                else{
                    dispatch_async(dispatch_get_main_queue()){
                        self.otpVerificationDelegate?.errorResponseForOTPVerificationAPI((error?.localizedDescription)!)
                    }
                }
                
            }
            dataTask.resume()
        }
        else{
            self.otpSentDelegate?.errorResponseForOTPSentAPI("No network found")
        }
    }
    
    //KeychainItemWrapper methods
    func storeValueInKeychainForKey(key:String,value:AnyObject){
        //Save the value of password into keychain
        KeychainItemWrapper.save(key, data: value)
    }
    
    func getValueFromKeychainOfKey(key:String)-> AnyObject{
        //get the value of password from keychain
        return KeychainItemWrapper.load(key) as AnyObject
        
    }
}
