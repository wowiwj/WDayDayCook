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
let ThemeListTableViewCellID = "ThemeListTableViewCell"
let RecipeDiscussListTableViewCellID = "RecipeDiscussListTableViewCell"

final class ChooseViewController: UIViewController {
    

    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            
            tableView.backgroundColor = UIColor.whiteColor()
            tableView.registerClass(MyCollectionCell.self, forCellReuseIdentifier: cellIdentifier)
            tableView.registerClass(ThemeListTableViewCell.self, forCellReuseIdentifier: ThemeListTableViewCellID)
            tableView.registerClass(RecipeDiscussListTableViewCell.self, forCellReuseIdentifier: RecipeDiscussListTableViewCellID)
            tableView.separatorStyle = .None
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
            tableView.estimatedRowHeight = 250
            
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
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
        
        }
    }
    
    /// 主题推荐
    private var themeList: Results<FoodRecmmand>?
    
    /// 热门推荐
    private var recipeList: Results<FoodRecmmand>?
    
    /// 话题推荐
    private var recipeDiscussList: Results<FoodRecmmand>?
    
    // tabble头部
    var cycleView: SDCycleScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = titleView
        
        let searchButton = UIBarButtonItem(image: UIImage(named: "icon-search~iphone"), style: .Plain, target: self, action: #selector(searchButtonClicked(_:)))
        navigationItem.rightBarButtonItem = searchButton
        
        realm = try! Realm()
        
        let placeholderImage = UIImage(named: "default_1~iphone")!
        
        let images = realm.objects(MainADItem).map { item -> String in
            return item.path
        }
        
        cycleView = SDCycleScrollView(frame: CGRect(origin: CGPointZero, size: placeholderImage.size), delegate: self, placeholderImage: placeholderImage)
        
        cycleView!.imageURLStringsGroup = images
        
        tableView.tableHeaderView = cycleView
        
        tableView.addHeaderWithCallback {
            
            let group = dispatch_group_create()
            
            let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
            dispatch_group_async(group, queue) {
                self.loadADData()
            }
            dispatch_group_async(group, queue) {
                self.loadNewFoodEachDay(0, pageSize: 10)
            }
            
            dispatch_group_notify(group, queue) {
                self.loadRecommandInfo()
                
            }
        }
        
        self.tableView.headerBeginRefreshing()
        
//        self.tableView.addEmptyDataSetView { (set) in
//            set.image = UIImage(named: "666")
//        }
//        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.hidden = false
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
        Alamofire.request(Router.RecommendInfo(parameters: nil)).responseJSON {[unowned self] response in
            
            
            self.tableView.headerEndRefreshing()
            
            func getFoodRecmmand()
            {
                self.themeList = getThemeListInRealm(self.realm)
                self.recipeList = getRecipeListInRealm(self.realm)
                self.recipeDiscussList = getRecipeDiscussListInRealm(self.realm)
                self.tableView.reloadData()
                
            }
    
            if response.result.isFailure
            {
                print(response.request)
                
                print(response.result.error)
                
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
    
    // MARK: - 控制器跳转
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        guard let identifier = segue.identifier else{
            return
        }
        
        if identifier == "showDetail" {
            let vc = segue.destinationViewController as! ShowDetailViewController
            let item = sender as! Int
            
            vc.id = item
        }
        
        
    }
    
    // MARK: - 动作监听
    @objc private func searchButtonClicked(button:UIButton)
    {
        
        
    }
    
    
}

// MARK: - UITableViewDelegate,UITableViewDataSource

extension ChooseViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if recipeDiscussList == nil {
            return 3
        }
        
        return recipeDiscussList!.count > 0 ? 4 : 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case CellStyle.themeList.rawValue:
            let cell =
                tableView.dequeueReusableCellWithIdentifier(ThemeListTableViewCellID)! as! ThemeListTableViewCell
            cell.delegate = self
            return cell
        case CellStyle.recipeDiscussList.rawValue:
            let cell =
                tableView.dequeueReusableCellWithIdentifier(RecipeDiscussListTableViewCellID)!
            return cell
        default:
            let cell =
                tableView.dequeueReusableCellWithIdentifier(cellIdentifier)! as! MyCollectionCell
            cell.delegate = self
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row {
        case CellStyle.newFood.rawValue:
            let newFoodcell = cell as! MyCollectionCell
            newFoodcell.newFoodItems = newFoodItems
        case CellStyle.themeList.rawValue:
            let cell = cell as! ThemeListTableViewCell
            cell.themeList = themeList
        case CellStyle.recipeList.rawValue:
            let cell = cell as! MyCollectionCell
            cell.recipeList = recipeList
        default:
            let cell = cell as! RecipeDiscussListTableViewCell
            cell.recipeDiscussList = recipeDiscussList
        }
        
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        //        let cell = cell as! MyCollectionCell
        //        cell.collectionView.frame = CGRectZero
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch indexPath.row {
        case CellStyle.themeList.rawValue:
            return CGFloat(themeList?.count ?? 0).autoAdjust() * WDConfig.themeListHeight + 30
        case CellStyle.recipeDiscussList.rawValue:
            return CGFloat(200).autoAdjust()
        default:
            return CGFloat(280).autoAdjust()
        }
        
    }
    
    
}

extension ChooseViewController : SDCycleScrollViewDelegate
{
    
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        let item = adData[index]
        performSegueWithIdentifier("showDetail", sender: Int(item.url))
        

    }
    
    
}
extension ChooseViewController :MyCollectionCellDelegete,ThemeListTableViewCellDelagate
{
    
    func didSeclectItem(item: Object) {
        if item is NewFood
        {
            performSegueWithIdentifier("showDetail", sender: (item as! NewFood).id)

        }
        
        if item is FoodRecmmand{
    
            performSegueWithIdentifier("showDetail", sender: (item as! FoodRecmmand).recipe_id)
        }
        
        if item is FoodRecmmand {
            
            
            
        }
     
    }


}

