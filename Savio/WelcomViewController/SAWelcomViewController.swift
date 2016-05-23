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
    
    var flag: Bool = false

    let sampleBGColors: Array<UIColor> = [UIColor.redColor(), UIColor.yellowColor(), UIColor.greenColor(), UIColor.magentaColor(), UIColor.orangeColor()]
    let samleDictArr: Array<String> = ["Page5", "Page1", "Page2", "Page3", "Page4"]
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        configureScrollView()
        configurePageControl()
        signUpBtn.layer.cornerRadius = 5.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickOnSignUpButton(sender:UIButton){
        let objSARegistarionViewController = SARegistrationViewController(nibName:"SARegistrationViewController",bundle: nil)
        self.navigationController?.pushViewController(objSARegistarionViewController, animated: true)
//        self.presentViewController(saRegistarionViewController, animated: true, completion: nil)
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
        
        if flag {
            return
        }
        // Enable paging.
        scrollView.pagingEnabled = true
        
        flag = true
        
        // Set the following flag values.
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        
        // Set the scrollview content size.
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * CGFloat(samleDictArr.count), scrollView.frame.size.height)
        print("\(scrollView.frame.size.width,scrollView.frame.size.height)")
        // Set self as the delegate of the scrollview.
//        scrollView.delegate = self
        
        // Load the PageView view from the TestView.xib file and configure it properly.
        for var i=0; i<samleDictArr.count; ++i {
            // Load the TestView view.
            let testView = NSBundle.mainBundle().loadNibNamed("PageView", owner: self, options: nil)[0] as! UIView
            
            // Set its frame and the background color.
//            testView.frame = CGRectMake(CGFloat(i) * scrollView.frame.size.width, scrollView.frame.origin.y, scrollView.frame.size.width, scrollView.frame.size.height)
            
            testView.frame = CGRectMake(CGFloat(i) * scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height)
//            testView.backgroundColor = sampleBGColors[i]
            
            // Set the proper message to the test view's label.
            let vw = testView.viewWithTag(1) as! UIImageView
            vw.image = UIImage(named: samleDictArr[i])
            
            // Add the test view as a subview to the scrollview.
            scrollView.addSubview(testView)
        }
    }
    
    
    func configurePageControl() {
        // Set the total pages to the page control.
        pageControl.numberOfPages = samleDictArr.count
        
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
//        var newFrame = scrollView.frame
//        newFrame.origin.x = newFrame.size.width * CGFloat(pageControl.currentPage)
//        scrollView.scrollRectToVisible(newFrame, animated: true)
        
    }
    
    @IBAction func clickOnImportantLink(sender:UIButton){
        
        let objimpInfo = NSBundle.mainBundle().loadNibNamed("ImportantInformationView", owner: self, options: nil)[0] as! UIView
        objimpInfo.frame = self.view.frame
        self.view.addSubview(objimpInfo)
    }
    
}

  