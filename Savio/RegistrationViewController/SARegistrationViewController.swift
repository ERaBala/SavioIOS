//
//  SARegistrationViewController.swift
//  Savio
//
//  Created by Prashant on 18/05/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class SARegistrationViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tblView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //tblView.registerClass(TitleTableViewCell.self, forCellReuseIdentifier: "CellID")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

     func numberOfSectionsInTableView(tableView: UITableView) -> Int  {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 5;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cellID : String = "CellID"
        
        var cell: TitleTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellID) as! TitleTableViewCell?
       
        if cell == nil {
            let nibs: NSArray? = NSBundle.mainBundle().loadNibNamed("TitleTableViewCell", owner: self, options: nil)
            cell = nibs?.firstObject as? TitleTableViewCell
        }
        cell?.tfTitle?.text = "test"
        
        return cell!
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
