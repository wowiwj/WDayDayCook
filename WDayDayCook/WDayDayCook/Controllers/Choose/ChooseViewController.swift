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

let cellIdentifier = "MyCollectionCell"

final class ChooseViewController: UIViewController {

    
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            
            tableView.backgroundColor = UIColor.purpleColor()
            tableView.registerClass(MyCollectionCell.self, forCellReuseIdentifier: cellIdentifier)
            tableView.separatorStyle = .None

        }
    }
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
            
            tableView.reloadData()
            
            print("newFoodItems")
        
        }
    }
    
    /// 主题推荐
    private var themeList: Results<FoodRecmmand>? {
        
        didSet{
            print("---themeList---")
            print(themeList)
        }
    }
    
    /// 热门推荐
    private var recipeList: Results<FoodRecmmand>? {
        
        didSet{
            print("---recipeList---")
            print(recipeList)
        }
    }
    
    /// 话题推荐
    private var recipeDiscussList: Results<FoodRecmmand>? {
        
        didSet{
            print("---recipeList---")
            print(recipeDiscussList)
        }
    }
    
    // tabble头部
    var cycleView: SDCycleScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.yellowColor()
        
        navigationItem.titleView = titleView
        loadADData()
        
        realm = try! Realm()
        
        let placeholderImage = UIImage(named: "default_1~iphone")!
        
        let images = realm.objects(MainADItem).map { item -> String in
            return item.path
        }
        
        cycleView = SDCycleScrollView(frame: CGRect(origin: CGPointZero, size: placeholderImage.size), delegate: self, placeholderImage: placeholderImage)
        
        cycleView!.imageURLStringsGroup = images
        
        tableView.tableHeaderView = cycleView
        
//        tableView.addHeaderWithCallback { 
        
//        }
        

        // 加载每日新品
        loadNewFoodEachDay(0, pageSize: 10)
        // 加载推荐信息
        loadRecommandInfo()

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
                WDAlert.alertSorry(message: "网络异常", inViewController: self)
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
            addNewFoodItemInRealm(result["data"])
            
            self.newFoodItems = getNewFoodItemInRealm(self.realm)
        }

    }
    
    /// 加载推荐信息数据
    func loadRecommandInfo()
    {
        Alamofire.request(Router.getRecommendInfo(parameters: nil)).responseJSON {[unowned self] response in
            func getFoodRecmmand()
            {
                self.themeList = getThemeListInRealm(self.realm)
                self.recipeList = getRecipeListInRealm(self.realm)
                self.recipeDiscussList = getRecipeDiscussListInRealm(self.realm)
            }

            if response.result.isFailure
            {
                WDAlert.alertSorry(message: "网络异常", inViewController: self)
                getFoodRecmmand()
                return
            }
            
            let value = response.result.value
            let result = JSON(value!)
            
            func updateFoodRecmmand()
            {
                // 删除之前存的旧数据
                deleteAllObject(FoodRecmmand)
                // 添加新数据到数据库
                addFoodRecmmandItemInRealm(result["themeList"])
                addFoodRecmmandItemInRealm(result["recipeList"])
                addFoodRecmmandItemInRealm(result["recipeDiscussList"])
            }
            
            updateFoodRecmmand()
            getFoodRecmmand()
        }
    }

}

// MARK: - UITableViewDelegate,UITableViewDataSource

extension ChooseViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell =
            tableView.dequeueReusableCellWithIdentifier(cellIdentifier)!
  
        return cell
   
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let cell = cell as! MyCollectionCell

        switch indexPath.row {
        case CellStyle.newFood.rawValue:
            cell.newFoodItems = newFoodItems
        case CellStyle.themeList.rawValue:
            cell.themeList = themeList
        case CellStyle.recipeList.rawValue:
            cell.recipeList = recipeList
        default:
            cell.recipeDiscussList = recipeDiscussList
        }

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch indexPath.row {
        case CellStyle.themeList.rawValue:
            return 600
        default:
            return 250
        }

    }


}

extension ChooseViewController : SDCycleScrollViewDelegate
{
    
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        print(index)
    }


}
