//
//  TermsAndConditionView.swift
//  PostalCodeVerification-Demo
//
//  Created by Maheshwari on 19/05/16.
//  Copyright © 2016 Maheshwari. All rights reserved.
//

import UIKit

class ImportantInformationView: UIView,UIWebViewDelegate {

    
    @IBOutlet weak var acceptTermsWebView: UIWebView!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var termsAndConditionTextView: UITextView!
    @IBOutlet weak var gotItButton: UIButton!
    var isChecked : Bool! = false
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code

        //set the shadow color for accept button
        gotItButton.layer.shadowColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        
        //set the content offset for textview so it,will begin at point(0,0)
        termsAndConditionTextView.contentOffset = CGPointMake(0, 0)
        
        //set the bordercolor and borderwidth to check button
        checkButton.layer.borderColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        checkButton.layer.borderWidth = 1
        
        //Get the path of html file
        let htmlPath = NSBundle.mainBundle().pathForResource("Link", ofType: "html")
        //create url from html file path
        let url = NSURL.fileURLWithPath(htmlPath!)
        //create url request to load webview
        let request = NSURLRequest.init(URL: url)
        self.acceptTermsWebView.loadRequest(request)
        self.acceptTermsWebView.scrollView.scrollEnabled = false;
        self.acceptTermsWebView.scrollView.bounces = false;
        
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let dataProtectionPolicy = NSBundle.mainBundle().loadNibNamed("DataProtectionPolicy", owner: self, options: nil)[0] as! DataProtectionPolicy
        dataProtectionPolicy.frame =  CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
        
        //Check if user clicked on which part
        //This will be handled after text will come from CMS for time being we are loading the view as it is
        if(request.URL?.lastPathComponent == "terms")
        {
          
            self.addSubview(dataProtectionPolicy)

        }
        else if(request.URL?.lastPathComponent == "data"){
            self.addSubview(dataProtectionPolicy)
        }
        
        return true
    }

    
    @IBAction func gotItButtonPressed(sender: AnyObject) {
        
    }
    @IBAction func checkButtonPressed(sender: AnyObject) {
        
        if(isChecked == true)
        {
            isChecked = false
            checkButton.setBackgroundImage(UIImage(named:"check-box.png"), forState: UIControlState.Normal)
            
        }
        else{
            isChecked = true
            checkButton.setBackgroundImage(UIImage(named:"check-box-checked.png"), forState: UIControlState.Normal)
        }
        
    }

    @IBAction func cancelButtonPressed(sender: AnyObject) {
    }
}
