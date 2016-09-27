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
            
            tableView.backgroundColor = UIColor.white
            tableView.register(MyCollectionCell.self, forCellReuseIdentifier: cellIdentifier)
            tableView.register(ThemeListTableViewCell.self, forCellReuseIdentifier: ThemeListTableViewCellID)
            tableView.register(RecipeDiscussListTableViewCell.self, forCellReuseIdentifier: RecipeDiscussListTableViewCellID)
            tableView.separatorStyle = .none
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
            tableView.estimatedRowHeight = 250
            
        }
    }
    fileprivate lazy var titleView :UIImageView = {
        let titleView = UIImageView()
        titleView.image = UIImage(named: "navi_logo~iphone")
        titleView.sizeToFit()
        
        return titleView
        
    }()
    
    fileprivate var realm: Realm!
    
    
    // 广告数据
    fileprivate lazy var adData: Results<MainADItem> = {
        return getADItemInRealm(self.realm)
    }()
    
    // 每日新品数据
    fileprivate var newFoodItems: Results<NewFood>?{
        didSet{
            tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: UITableViewRowAnimation.automatic)
        
        }
    }
    
    /// 主题推荐
    fileprivate var themeList: Results<FoodRecmmand>?
    
    /// 热门推荐
    fileprivate var recipeList: Results<FoodRecmmand>?
    
    /// 话题推荐
    fileprivate var recipeDiscussList: Results<FoodRecmmand>?
    
    // tabble头部
    var cycleView: SDCycleScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = titleView
        
        let searchButton = UIBarButtonItem(image: UIImage(named: "icon-search~iphone"), style: .plain, target: self, action: #selector(searchButtonClicked(_:)))
        navigationItem.rightBarButtonItem = searchButton
        
        realm = try! Realm()
        
        let placeholderImage = UIImage(named: "default_1~iphone")!
        
        let images = realm.objects(MainADItem.self).map { item -> String in
            return item.path
        }
        
        cycleView = SDCycleScrollView(frame: CGRect(origin: CGPoint.zero, size: placeholderImage.size), delegate: self, placeholderImage: placeholderImage)
        
        //cycleView!.imageURLStringsGroup = images
        
        tableView.tableHeaderView = cycleView
        
        tableView.addHeaderWithCallback {
            
            let group = DispatchGroup()
            
            let queue = DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default)
            queue.async(group: group) {
                self.loadADData()
            }
            queue.async(group: group) {
                self.loadNewFoodEachDay(0, pageSize: 10)
            }
            
            group.notify(queue: queue) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.hidden = false
    }
    
    // MARK: - LoadData
    /// 加载上方滚动广告
    func loadADData(){
        Alamofire.request(Router.chooseViewAdList(parameters: nil)).responseJSON { [unowned self] responses in

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
            self.cycleView?.imageURLStringsGroup = self.realm.objects(MainADItem.self).map { item -> String in
                return item.path
            }
            
        }
    }
    // 加载每日新品
    func loadNewFoodEachDay(_ currentPage:Int,pageSize:Int)
    {
        Alamofire.request(Router.newFoodEachDay(currentpage: currentPage, pageSize: pageSize)).responseJSON { [unowned self] response in
            
            
            if response.result.isFailure
            {
                WDAlert.alertSorry(message: "网络异常", inViewController: self)
                // 获取离线数据
                self.newFoodItems = getNewFoodItemInRealm(self.realm)
                return
            }
            
            let value = response.result.value
            let result = JSON(value!)
            
            deleteAllObject(NewFood.self)
            addNewFoodItemInRealm(result["data"])
            
            self.newFoodItems = getNewFoodItemInRealm(self.realm)
        }
        
    }
    
    /// 加载推荐信息数据
    func loadRecommandInfo()
    {
        Alamofire.request(Router.recommendInfo(parameters: nil)).responseJSON {[unowned self] response in
            
            
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
                deleteAllObject(FoodRecmmand.self)
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier else{
            return
        }
        
        if identifier == "showDetail" {
            let vc = segue.destination as! ShowDetailViewController
            let item = sender as! Int
            
            vc.id = item
        }
        
        
    }
    
    // MARK: - 动作监听
    @objc fileprivate func searchButtonClicked(_ button:UIButton)
    {
        
        
    }
    
    
}

// MARK: - UITableViewDelegate,UITableViewDataSource

extension ChooseViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if recipeDiscussList == nil {
            return 3
        }
        
        return recipeDiscussList!.count > 0 ? 4 : 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch (indexPath as NSIndexPath).row {
        case CellStyle.themeList.rawValue:
            let cell =
                tableView.dequeueReusableCell(withIdentifier: ThemeListTableViewCellID)! as! ThemeListTableViewCell
            cell.delegate = self
            return cell
        case CellStyle.recipeDiscussList.rawValue:
            let cell =
                tableView.dequeueReusableCell(withIdentifier: RecipeDiscussListTableViewCellID)!
            return cell
        default:
            let cell =
                tableView.dequeueReusableCell(withIdentifier: cellIdentifier)! as! MyCollectionCell
            cell.delegate = self
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        switch (indexPath as NSIndexPath).row {
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
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //        let cell = cell as! MyCollectionCell
        //        cell.collectionView.frame = CGRectZero
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch (indexPath as NSIndexPath).row {
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
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        let item = adData[index]
        performSegue(withIdentifier: "showDetail", sender: Int(item.url))
        

    }
    
    
}
extension ChooseViewController :MyCollectionCellDelegete,ThemeListTableViewCellDelagate
{
    
    func didSeclectItem(_ item: Object) {
        if item is NewFood
        {
            performSegue(withIdentifier: "showDetail", sender: (item as! NewFood).id)

        }
        
        if item is FoodRecmmand{
    
            performSegue(withIdentifier: "showDetail", sender: (item as! FoodRecmmand).recipe_id)
        }
        
        if item is FoodRecmmand {
            
            
            
        }
     
    }


}

