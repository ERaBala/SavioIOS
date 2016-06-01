//
//  SASavingPlanViewController.swift
//  Savio
//
//  Created by Maheshwari on 01/06/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class SASavingPlanViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    var tableViewCellArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView!.registerNib(UINib(nibName: "SavingPlanTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "SavingPlanTitleIdentifier")
         tblView!.registerNib(UINib(nibName: "SavingPlanCostTableViewCell", bundle: nil), forCellReuseIdentifier: "SavingPlanCostIdentifier")
         tblView!.registerNib(UINib(nibName: "SavingPlanDatePickerTableViewCell", bundle: nil), forCellReuseIdentifier: "SavingPlanDatePickerIdentifier")
         tblView!.registerNib(UINib(nibName: "SetDayTableViewCell", bundle: nil), forCellReuseIdentifier: "SavingPlanSetDateIdentifier")
         tblView!.registerNib(UINib(nibName: "CalculationTableViewCell", bundle: nil), forCellReuseIdentifier: "SavingPlanCalculationIdentifier")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell1")
        
        if cell == nil {
            if(indexPath.section == 0)
            {
                let bundleArr : Array = NSBundle.mainBundle().loadNibNamed("SavingPlanTitleTableViewCell", owner: nil, options: nil) as Array
                cell = bundleArr[0] as! SavingPlanTitleTableViewCell
            }
            else if(indexPath.section == 1){
                let bundleArr : Array = NSBundle.mainBundle().loadNibNamed("SavingPlanCostTableViewCell", owner: nil, options: nil) as Array
                cell = bundleArr[0] as! SavingPlanCostTableViewCell
            }
            else if(indexPath.section == 2){
                let bundleArr : Array = NSBundle.mainBundle().loadNibNamed("SavingPlanDatePickerTableViewCell", owner: nil, options: nil) as Array
                cell = bundleArr[0] as! SavingPlanDatePickerTableViewCell
            }
            else if(indexPath.section == 3){
                let bundleArr : Array = NSBundle.mainBundle().loadNibNamed("SetDayTableViewCell", owner: nil, options: nil) as Array
                cell = bundleArr[0] as! SetDayTableViewCell
            }
            else if(indexPath.section == 4){
                let bundleArr : Array = NSBundle.mainBundle().loadNibNamed("CalculationTableViewCell", owner: nil, options: nil) as Array
                cell = bundleArr[0] as! CalculationTableViewCell
            }
        }
        
        return cell!
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view : UIView = UIView()
       view.backgroundColor = UIColor.whiteColor()
        return view
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 3
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        if(indexPath.section == 0)
        {
            return 44
        }
        else if(indexPath.section == 1){
            return 90
        }
        else if(indexPath.section == 2){
            return 70
        }
        else if(indexPath.section == 3){
            return 65
        }
        else {
            return 44
        }

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
