//
//  SAWelcomViewController.swift
//  Savio
//
//  Created by Prashant on 16/05/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit


class SAWelcomViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var signUpBtn: UIButton!
    
    //flag holds the
    var idx: Int = 0
    //pageArr is an array which holds animation pages
    let pageArr: Array<String> = ["Page5", "Page1", "Page2", "Page3", "Page4"]
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //Hide navigationbar
        self.navigationController?.navigationBarHidden = true

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //Function invoke to configure scrollview for animating pages
        configureScrollView()
        //function invoke for set up page control with scrollview
        configurePageControl()
        //setting signup button corner
        signUpBtn.layer.cornerRadius = 5.0
        idx = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This function invoke when user tapping on sign up to savio button
    @IBAction func clickOnSignUpButton(sender:UIButton){
        //create instance of SARegistrationViewController
        let objSARegistarionViewController = SARegistrationViewController(nibName:"SARegistrationViewController",bundle: nil)
        //Navigate to registration screen
        self.navigationController?.pushViewController(objSARegistarionViewController, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func configureScrollView() {
//        if flag {
//            return
//        }
        // Enable paging.
        scrollView.pagingEnabled = true
//        flag = true
        // Set the following flag values.
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        
        // Set the scrollview content size.
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * CGFloat(pageArr.count), scrollView.frame.size.height)
        print("\(scrollView.frame.size.width,scrollView.frame.size.height)")
        // Set self as the delegate of the scrollview.
//        scrollView.delegate = self
        
        // Load the PageView view from the TestView.xib file and configure it properly.
        for var i=0; i<pageArr.count; ++i {
            // Load the TestView view.
            let testView = NSBundle.mainBundle().loadNibNamed("PageView", owner: self, options: nil)[0] as! UIView
            
            // Set its frame and the background color.
//            testView.frame = CGRectMake(CGFloat(i) * scrollView.frame.size.width, scrollView.frame.origin.y, scrollView.frame.size.width, scrollView.frame.size.height)
            
            testView.frame = CGRectMake(CGFloat(i) * scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height)
            
            // Set the proper message to the test view's label.
            let vw = testView.viewWithTag(1) as! UIImageView
            vw.image = UIImage(named: pageArr[i])
            
            // Add the test view as a subview to the scrollview.
            scrollView.addSubview(testView)
        }
        self.change()
    }
    
    func configurePageControl() {
        // Set the total pages to the page control.
        pageControl.numberOfPages = pageArr.count
        
        // Set the initial page.
        pageControl.currentPage = 0
    }
    
    
    // MARK: UIScrollViewDelegate method implementation
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Calculate the new page index depending on the content offset.
        let currentPage = floor(scrollView.contentOffset.x / UIScreen.mainScreen().bounds.size.width);
        
        // Set the new page index to the page control.
        pageControl.currentPage = Int(currentPage)
    }
    
    
    // MARK: IBAction method implementation
    
    @IBAction func changePage(sender: AnyObject) {
        // Calculate the frame that should scroll to based on the page control current page.
        
    }
    
    //Function invoke for make
    func change(){
        var flag = true
        if(idx == 5){
            idx = 0
            flag = false
        }
        var newFrame = scrollView.frame
        pageControl.currentPage = idx
        newFrame.origin.x = newFrame.size.width * CGFloat(pageControl.currentPage)
        
        scrollView.scrollRectToVisible(newFrame, animated: flag)
        NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "change", userInfo: nil, repeats: false)
        idx++
    }
    
    @IBAction func clickOnImportantLink(sender:UIButton){
        let objimpInfo = NSBundle.mainBundle().loadNibNamed("ImportantInformationView", owner: self, options: nil)[0] as! UIView
        objimpInfo.frame = self.view.frame
        self.view.addSubview(objimpInfo)
    }
    
}

  