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
import SDCycleScrollView





final class ChooseViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private lazy var titleView :UIImageView = {
        let titleView = UIImageView()
        titleView.image = UIImage(named: "navi_logo~iphone")
        titleView.sizeToFit()
        
        return titleView
    
    }()
    
    private var realm: Realm!
    
    
    // 广告数据
    private lazy var adData: Results<MainADItem> = {
        return getADItemInRealm(self.realm)
    }()
    
    // 每日新品数据
    private var newFoodItems: Results<NewFood>?{
    
        didSet{
            
            print("newFoodItems")
        
        }
    }
    
    // tabble头部
    var cycleView: SDCycleScrollView?
    
    //
    
    
    
    var data = ["111","222","333","444","555","huff","666","444","555","huff","666","444","555","huff","666"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.yellowColor()
        
        navigationItem.titleView = titleView
        tableView.rowHeight = 80
        
        loadADData()
        
        realm = try! Realm()
        
        let placeholderImage = UIImage(named: "default_1~iphone")!
        
        let images = realm.objects(MainADItem).map { item -> String in
            return item.path
        }
        
        cycleView = SDCycleScrollView(frame: CGRect(origin: CGPointZero, size: placeholderImage.size), delegate: self, placeholderImage: placeholderImage)
        
        cycleView!.imageURLStringsGroup = images
        
        tableView.tableHeaderView = cycleView

        // 加载每日新品
        loadNewFoodEachDay(0, pageSize: 10)
        // 加载推荐信息
        loadRecommandInfo()
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
            self.cycleView?.imageURLStringsGroup = self.realm.objects(MainADItem).map { item -> String in
                return item.path
            }

        }
    }
    // 加载每日新品
    func loadNewFoodEachDay(currentPage:Int,pageSize:Int)
    {
        Alamofire.request(Router.NewFoodEachDay(currentpage: currentPage, pageSize: pageSize)).responseJSON { [unowned self] response in
            
            
            if response.result.isFailure
            {
                WDAlert.alertSorry(message: "网络异常", inViewController: self)
                // 获取离线数据
                self.newFoodItems = getNewFoodItemInRealm(self.realm)
                return
            }
            
            let value = response.result.value
            let result = JSON(value!)
 
            deleteAllObject(NewFood)
            addNewFoodtemInRealm(result["data"])
            
            self.newFoodItems = getNewFoodItemInRealm(self.realm)
            
//            print(self.newFoodItems)
        }

    }
    
    /// 加载推荐信息数据
    func loadRecommandInfo()
    {
        Alamofire.request(Router.getRecommendInfo(parameters: nil)).responseJSON { response in
            if response.result.isFailure
            {
                WDAlert.alertSorry(message: "网络异常", inViewController: self)
                // 获取离线数据
                self.newFoodItems = getNewFoodItemInRealm(self.realm)
                return
            }
            
            let value = response.result.value
            let result = JSON(value!)
            
            print(result)
            
           
            
        }
    }

}

// MARK: - UITableViewDelegate,UITableViewDataSource

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

extension ChooseViewController : SDCycleScrollViewDelegate
{
    
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        print(index)
    }


}
