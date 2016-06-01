//
//  ShareViewController.swift
//  SavioWishList
//
//  Created by Maheshwari on 01/06/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        let customNavBar = UINavigationBar.init(frame: (self.navigationController?.navigationBar.bounds)!)
        self.navigationController?.navigationBar.removeFromSuperview()
    
        let navItem = UINavigationItem.init(title: "Wish List")
//        let fixedSpace = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: self, action: nil)
//        fixedSpace.width = 30;
        
        let rightButton = UIBarButtonItem.init(title: "Save", style: UIBarButtonItemStyle.Done, target: self, action: #selector(ShareViewController.saveButton));
        rightButton.tintColor = UIColor.blackColor()
        navItem.rightBarButtonItems = [rightButton]
        
        let leftButton = UIBarButtonItem.init(title: "Cancel", style: UIBarButtonItemStyle.Done, target: self, action: #selector(ShareViewController.cancelButton));
        leftButton.tintColor = UIColor.blackColor()
        navItem.leftBarButtonItem = leftButton
        self.navigationController?.view.addSubview(customNavBar)
        customNavBar.setItems([navItem], animated: true)
        */
        
        self.title = "Wish List"


    }
    
    func saveButton()
    {
        self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
    }
    
    func cancelButton()
    {
        self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
    }
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        /*
         
 */
        self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
    }

    override func configurationItems() -> [AnyObject]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
