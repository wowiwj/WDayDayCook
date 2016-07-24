//
//  ChooseViewController.swift
//  WDayDayCook
//
//  Created by wangju on 16/7/24.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



final class ChooseViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private lazy var titleView :UIImageView = {
        let titleView = UIImageView()
        titleView.image = UIImage(named: "navi_logo~iphone")
        titleView.sizeToFit()
        
        return titleView
    
    }()
    
    var data = ["111","222","333","444","555","huff","666","444","555","huff","666","444","555","huff","666"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.yellowColor()
        
        navigationItem.titleView = titleView
        tableView.rowHeight = 80
        
        loadADData()
        

//        tableView.addHeaderWithCallback { 
//            print("----")
//            
//
//            
//        }
//        tableView.addFooterWithCallback {
//            
////            print("----1111")
////            self.data.append("skjhgkjsgsgsg")
////            self.tableView.reloadData()
//            
//        }


        // Do any additional setup after loading the view.
    }

    @IBAction func end(sender: AnyObject) {
        self.data.append("skjhgkjsgsgsg")
        self.tableView.reloadData()
        tableView.footerEndRefreshing()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
//        tableView.headerBeginRefreshing()
    }
    
    // MARK: - LoadData
    
    /// 加载上方滚动广告
    func loadADData(){
       
        Alamofire.request(Router.ChooseViewAdList(parameters: nil)).responseJSON { responses in
            
            print(responses.result.value)
            
        
            
            if let resultValue = responses.result.value as? [String:AnyObject]
            {
                let json = JSON(resultValue)
                print(JSON(resultValue))
            
            }
//            print(responses.result.error)
            
   
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

extension ChooseViewController:UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = UITableViewCell()
        
        cell.textLabel?.text = "哈哈\(data[indexPath.row])"
        
        return cell
        
        
    }


}
