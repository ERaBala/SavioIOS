//
//  SACreateSavingPlanViewController.swift
//  Savio
//
//  Created by Prashant on 01/06/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class SACreateSavingPlanViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var lblBoostedView: UIView?
    @IBOutlet weak var tblView: UITableView?
    @IBOutlet weak var scrlView: UIScrollView?
    @IBOutlet weak var pageControl: UIPageControl?
    @IBOutlet weak var btnWishList: UIButton?
    

    @IBOutlet weak var suggestedTop: NSLayoutConstraint!
    @IBOutlet weak var suggestedY: NSLayoutConstraint!
    @IBOutlet weak var suggestedHt: NSLayoutConstraint!
    var colors:[UIColor] = [UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor(), UIColor.yellowColor()]
    var tblArr : Array<Dictionary<String,AnyObject>> = [["image":"group-save-category-icon","header":"Group Save","detail":"Set up savings goal betweenfriends and family"],["image":"wedding-category-icon","header":"Wedding","detail":"Get great deals on everything from flowers to videos"],["image":"baby-category-icon","header":"Baby","detail":"Get everything ready for the new arrival"],["image":"holiday-category-icon","header":"Holiday","detail":"Save up or some sunshine!"],["image":"ride-category-icon","header":"Ride","detail":"There's always room for another bike."],["image":"home-category-icon","header":"Home","detail":"Time to make that project a reality."],["image":"gadget-category-icon","header":"Gadget","detail":"The one thing you really need, from smartphones to sewing machines."],["image":"generic-category-icon","header":"Generic plan","detail":"Don't want to be specific? No worries, we just can't give you any offers from our partners."]]
    let pageArr: Array<String> = ["Page5", "Page1", "Page2", "Page3", "Page4"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
//        self.navigationController?.navigationBar.translucent = false;
//        self.navigationController?.navigationBar.barStyle = UIBarStyle.BlackTranslucent
        //       self.navigationController!.navigationBar.titleTextAttributes = [UITextAttributeTextColor: UIColor(red: 55/255, green: 58/255, blue: 68/255, alpha: 1)]
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor() //UIColor(red: 55/255, green: 58/255, blue: 68/255, alpha: 1)
//        lblWarningLable?.layer.borderWidth = 1.5
//        lblWarningLable?.layer.borderColor = UIColor.whiteColor().CGColor
//        
//        lblBoostedView?.layer.borderWidth = 1.5
//        lblBoostedView?.layer.borderColor = UIColor.blackColor().CGColor
        
//        tblView!.registerNib(UINib(nibName: "SavingCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell1")
        
        tblView?.registerClass(SavingCategoryTableViewCell.self, forCellReuseIdentifier: "SavingCategoryTableViewCell")
        self.setUpView()
        
     let isShowFull = true
        if isShowFull == false {
//            suggestedY.constant = 20.0
            suggestedHt.constant = 50.0
            suggestedTop.constant = -50.0
            btnWishList?.hidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
        
    func setUpView(){
          btnWishList!.layer.shadowColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        btnWishList!.layer.shadowOffset = CGSizeMake(0, 2)
        btnWishList!.layer.shadowOpacity = 1
        btnWishList!.layer.cornerRadius = 5
        
     self.configureScrollView()
    }
    
    func configureScrollView() {
        // Enable paging.
        scrlView!.pagingEnabled = true
        // Set the following flag values.
        scrlView!.showsHorizontalScrollIndicator = false
        scrlView!.showsVerticalScrollIndicator = false
        scrlView!.scrollsToTop = false
        
        // Set the scrollview content size.
        scrlView!.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width * CGFloat(colors.count), 0)
        
        // Load the PageView view from the TestView.xib file and configure it properly.
        for i in 0 ..< colors.count {
            // Load the TestView view.
            let testView = NSBundle.mainBundle().loadNibNamed("SavingPageView", owner: self, options: nil)[0] as! UIView
            // Set its frame and the background color.
            testView.frame = CGRectMake(CGFloat(i) * UIScreen.mainScreen().bounds.size.width, -64, testView.frame.size.width, scrlView!.frame.size.height)
            let vw = testView.viewWithTag(2)! as UIView
            vw.layer.borderWidth = 1
            vw.layer.borderColor = UIColor.whiteColor().CGColor

            
            // Set the proper message to the test view's label.
//            let imgVw = testView.viewWithTag(1) as! UIImageView
//            imgVw.image = UIImage(named: pageArr[i])
            // Add the test view as a subview to the scrollview.
            scrlView!.addSubview(testView)
        }
    }
    
    //Function invoking for configure the page control for animated pages
    func configurePageControl() {
        // Set the total pages to the page control.
        pageControl!.numberOfPages = 5
        // Set the initial page.
        pageControl!.currentPage = 0
    }
    
    // MARK: UIScrollViewDelegate method implementation
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Calculate the new page index depending on the content offset.
        let currentPage = floor(scrollView.contentOffset.x / UIScreen.mainScreen().bounds.size.width);
        
        // Set the new page index to the page control.
        pageControl!.currentPage = Int(currentPage)
    }
    
    
    // MARK: IBAction method implementation
    @IBAction func changePage(sender: AnyObject) {
        // Calculate the frame that should scroll to based on the page control current page.
        var newFrame = scrlView!.frame
        newFrame.origin.x = newFrame.size.width * CGFloat(pageControl!.currentPage)
        scrlView!.scrollRectToVisible(newFrame, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int  {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return tblArr.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
//        let cell = tableView.dequeueReusableCellWithIdentifier("SavingCategoryTableViewCell") as? SavingCategoryTableViewCell
//        if cell == nil {
            let bundleArr : Array = NSBundle.mainBundle().loadNibNamed("SavingCategoryTableViewCell", owner: nil, options: nil) as Array
           let cell = bundleArr[0] as! SavingCategoryTableViewCell
//        }
        let cellDict = tblArr[indexPath.row]
        print(cellDict["header"])
        cell.lblHeader!.text = cellDict["header"] as? String;
        cell.lblDetail?.text = cellDict["detail"] as? String
        cell.imgView?.image = UIImage(named: cellDict["image"] as! String)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 79.0
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(tblArr[indexPath.row])
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
