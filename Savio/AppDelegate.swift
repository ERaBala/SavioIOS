//
//  AppDelegate.swift
//  Savio
//
//  Created by Prashant on 16/05/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var objSANav: UINavigationController?
    var objSAWelcomViewController: SAWelcomViewController?
    var objEnterYourPinViewController: SAEnterYourPINViewController?
    var objRegisterViewController: SARegistrationViewController?
    var objCreateViewController: CreatePINViewController?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        //Check if keychain has encrypted pin value
        let objApi = API()
//        objApi.deleteKeychainValue("myPasscode")
//        objApi.deleteKeychainValue("myUserInfo")
//        objApi.deleteKeychainValue("userInfo")
        print(objApi.getValueFromKeychainOfKey("myPasscode") as! String)
        if((objApi.getValueFromKeychainOfKey("myPasscode") as! String) == "")
        {
            //If no then Go to SAWelcomViewController
            objSAWelcomViewController = SAWelcomViewController()
            //Set SAWelcomViewController as rootViewController of UINavigationViewController
            objSANav = UINavigationController(rootViewController: objSAWelcomViewController!)
            window?.rootViewController = objSANav
            
            
        }
        else{
            
            let userInfoDict = objApi.getValueFromKeychainOfKey("userInfo") as! Dictionary<String,AnyObject>
            print(userInfoDict)
            let udidDict = userInfoDict["deviceRegistration"] as! Array<Dictionary<String,AnyObject>>
            print(udidDict)
            print(UIDevice.currentDevice().identifierForVendor!.UUIDString)
            
            let udidArray = udidDict[0] 
            
            if(udidArray["DEVICE_ID"] as! String  == UIDevice.currentDevice().identifierForVendor!.UUIDString)
            {
                //else Go to SAEnterYourPINViewController
                objEnterYourPinViewController = SAEnterYourPINViewController()
                //Set SAEnterYourPINViewController as rootViewController of UINavigationViewController
                objSANav = UINavigationController(rootViewController: objEnterYourPinViewController!)
                window?.rootViewController = objSANav
                
            }
            else{
                //else Go to SARegistrationViewController
                objRegisterViewController = SARegistrationViewController()
                //Set SARegistrationViewController as rootViewController of UINavigationViewController
                objSANav = UINavigationController(rootViewController: objRegisterViewController!)
                window?.rootViewController = objSANav
                
            }
            
            
        }
        objSANav?.navigationBarHidden = true
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

