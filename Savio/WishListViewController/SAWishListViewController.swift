//
//  SAWishListViewController.swift
//  Savio
//
//  Created by Prashant on 04/06/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class SAWishListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        //        if cell == nil {
        let bundleArr : Array = NSBundle.mainBundle().loadNibNamed("WishListTableViewCell", owner: nil, options: nil) as Array
        let cell = bundleArr[0] as! WishListTableViewCell
        //        }
//        let cellDict = tblArr[indexPath.row]
//        print(cellDict["header"])
//        cell.lblHeader!.text = cellDict["header"] as? String;
//        cell.lblDetail?.text = cellDict["detail"] as? String
//        cell.imgView?.image = UIImage(named: cellDict["image"] as! String)
        
        cell.btnSavingPlan?.addTarget(self, action: #selector(SAWishListViewController.navigateToSetUpSavingPlan(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 310.0
    }

    func navigateToSetUpSavingPlan(sender:UIButton) {
        print("Clicked on Wishlist button")
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
