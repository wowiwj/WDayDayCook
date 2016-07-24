//
//  ChooseViewController.swift
//  WDayDayCook
//
//  Created by wangju on 16/7/24.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit

final class ChooseViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private lazy var titleView :UIImageView = {
        let titleView = UIImageView()
        titleView.image = UIImage(named: "navi_logo~iphone")
        titleView.sizeToFit()
        
        return titleView
    
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.yellowColor()
        
        navigationItem.titleView = titleView


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension ChooseViewController:UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = UITableViewCell()
        
        cell.textLabel?.text = "哈哈\(indexPath.row)"
        
        return cell
        
        
    }


}
