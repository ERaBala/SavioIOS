//
//  SAOfferListViewController.swift
//  Savio
//
//  Created by Prashant on 06/06/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class SAOfferListViewController: UIViewController {
    var indx : Int = 0
    var rowHT : CGFloat = 310.0
    
    @IBOutlet weak var tblView : UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpView(){
        self.title = "Partner offers"
        
        //set Navigation left button
        let leftBtnName = UIButton()
        leftBtnName.setImage(UIImage(named: "nav-back.png"), forState: UIControlState.Normal)
        leftBtnName.frame = CGRectMake(0, 0, 30, 30)
        leftBtnName.addTarget(self, action: #selector(SAOfferListViewController.backButtonPress), forControlEvents: .TouchUpInside)
        
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = leftBtnName
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        //set Navigation right button nav-heart
        let btnName = UIButton()
        btnName.setBackgroundImage(UIImage(named: "nav-heart.png"), forState: UIControlState.Normal)
        btnName.frame = CGRectMake(0, 0, 30, 30)
        btnName.titleLabel!.font = UIFont(name: "GothamRounded-Book", size: 12)
        btnName.setTitle("0", forState: UIControlState.Normal)
        btnName.setTitleColor(UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1), forState: UIControlState.Normal)
        btnName.addTarget(self, action: #selector(SAOfferListViewController.heartBtnClicked), forControlEvents: .TouchUpInside)
        
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = btnName
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - Navigation Bar Button Action
    func backButtonPress()  {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func heartBtnClicked()  {
        print("Heart Btn Clicked..")
    }
    
    
    // MARK: - Tableview Delegate & Datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int  {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        //        let cell = tableView.dequeueReusableCellWithIdentifier("SavingCategoryTableViewCell") as? SavingCategoryTableViewCell
   
        let bundleArr : Array = NSBundle.mainBundle().loadNibNamed("SAOfferListTableViewCell", owner: nil, options: nil) as Array
        let cell = bundleArr[0] as! SAOfferListTableViewCell
   
        
        cell.btnAddOffer?.addTarget(self, action: #selector(SAOfferListViewController.clickedOnAddOffer(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.btnOfferDetail?.addTarget(self, action: #selector(SAOfferListViewController.clickedOnOfferDetail(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.btnOfferDetail?.tag = indexPath.row
        if indx == indexPath.row {
             let str = "This is Savio application and team size is 4, name: Prashant, Maheshwari, Manoj and Gagan"
            let ht = self.heightForView(str, font: UIFont(name: "GothamRounded-Book", size: 10)!, width: (cell.lblProductDetail?.frame.size.width)! )
            cell.lblHT.constant = ht
            cell.lblProductDetail?.text = str
        }
        else{
            cell.lblHT.constant = 0.0
            cell.lblProductDetail?.text = ""
        }

//        cell.lblHT.constant = 20.0
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == indx{
            return rowHT + 310.0
        }else{
        return 310.0
        }
    }
    
    func clickedOnAddOffer(sender:UIButton) {
        print(sender.tag)
    }
    
    func clickedOnOfferDetail(sender:UIButton) {
        print(sender.tag)
        indx = sender.tag
        tblView?.reloadData()
       
    }

    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        rowHT = label.frame.height
        return rowHT
    }

}
