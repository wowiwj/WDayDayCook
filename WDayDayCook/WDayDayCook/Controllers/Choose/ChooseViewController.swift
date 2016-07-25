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
import RealmSwift



final class ChooseViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private lazy var titleView :UIImageView = {
        let titleView = UIImageView()
        titleView.image = UIImage(named: "navi_logo~iphone")
        titleView.sizeToFit()
        
        return titleView
    
    }()
    
    private var realm: Realm!
    
    private lazy var adData: Results<MainADItem> = {
        return getADItemInRealm(self.realm)
    }()
    
    
    
    var data = ["111","222","333","444","555","huff","666","444","555","huff","666","444","555","huff","666"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.yellowColor()
        
        navigationItem.titleView = titleView
        tableView.rowHeight = 80
        
        loadADData()
        
        realm = try! Realm()
        
        print(adData)
        
        let placeholderImage = UIImage(named: "default_1~iphone")
        
        let images = realm.objects(MainADItem).map { item -> String in
            return item.path
        }
        
        let cycleView = CycleScrollView(placeholder: placeholderImage!, imagesURL: images)
        
        tableView.tableHeaderView = cycleView
        
        
        

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
        Alamofire.request(Router.ChooseViewAdList(parameters: nil)).responseJSON { [unowned self] responses in
 
            if responses.result.isFailure
            {
                let alert = UIAlertController(title: "网路异常", message: "请检查网络设置", preferredStyle: .Alert)
                let cancer = UIAlertAction(title: "确定", style: .Cancel, handler: nil)
                alert.addAction(cancer)
                self.presentViewController(alert, animated: true, completion: nil)
                // 加载失败，使用旧数据
                return
            }
       
            let json = responses.result.value
            let result = JSON(json!)
            deleteAllADItem()
            addNewMainADItemInRealm(result["data"])
            // 加载成功，使用新数据
            self.adData = getADItemInRealm(self.realm)

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
