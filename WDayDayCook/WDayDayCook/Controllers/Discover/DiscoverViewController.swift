//
//  DiscoverViewController.swift
//  WDayDayCook
//
//  Created by wangju on 16/8/20.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import SDCycleScrollView
import Alamofire
import SwiftyJSON
import ObjectMapper
import AlamofireObjectMapper
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


private let RecipeDiscussCellId = "RecipeDiscussCell"
private let reusableHeaderViewID = "DiscoverHeaderView"

class DiscoverViewController: UICollectionViewController {
    
    fileprivate lazy var cycleView:SDCycleScrollView = {
    
        let placeholderImage = UIImage(named: "default_1~iphone")!
        let screenSize = UIScreen.main.bounds.size
        let headerW = screenSize.width
        let headerH = headerW / placeholderImage.size.width * placeholderImage.size.height
        let size = CGSize(width: headerW, height: headerH)
        let cycleView = SDCycleScrollView(frame: CGRect(origin: CGPoint.zero, size: size), delegate: self, placeholderImage: placeholderImage)
        
        return cycleView!
    
    }()
    
    var recipeList:ThemeRecipeList?{
    
        didSet{
            guard let recipeList = recipeList else{
                return
            }
            self.themeRecipes = recipeList.themeRecipes.sorted { (theme1, theme2) -> Bool in
                return theme1.locationId < theme2.locationId
            }
            self.headerRecipes = recipeList.headerRecipes
        
        }
    }
    
    var themeRecipes:[ThemeRecipe]?{
        didSet{
            collectionView?.reloadData()
        }
    }
    
    var headerRecipes:[ThemeRecipe]?{
        didSet{
            guard let headerRecipes = headerRecipes else{
                return
            }
            cycleView.imageURLStringsGroup = headerRecipes.map{$0.image_url!}
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // MARK: - 代理测试
//        self.collectionView?.emptyDataSetDataSource = self
 
        MakeUI()
        
        

        
        collectionView?.addHeaderWithCallback({
            self.loadDatda()
        })
        
        collectionView?.headerBeginRefreshing()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false


    }
    
    func MakeUI()
    {
        func setLayout()
        {
            let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
            
            let screenSize = UIScreen.main.bounds.size
            
            let width = (screenSize.width - WDConfig.discoverDefaultMargin) * 0.5
            let height = width
            
            layout.itemSize = CGSize(width: width, height: height)
            layout.minimumLineSpacing = WDConfig.discoverDefaultMargin
            layout.minimumInteritemSpacing = WDConfig.discoverDefaultMargin
            
            layout.sectionInset = UIEdgeInsets(top: WDConfig.discoverDefaultMargin, left: 0, bottom: 0, right: 0)
            
            layout.headerReferenceSize = cycleView.frame.size
        }
        
        setLayout()
        
        collectionView?.register(UINib(nibName: RecipeDiscussCellId, bundle: nil), forCellWithReuseIdentifier: RecipeDiscussCellId)
        self.collectionView?.backgroundColor = UIColor.white
 
    }
    
    func loadDatda()
    {

        Alamofire.request(Router.moreThemeRecipe(parameters: nil)).responseObject { (response:DataResponse<ThemeRecipeList>) in
            self.collectionView!.headerEndRefreshing()
            
            if response.result.isFailure
            {
                print(response.result.error)
                return
            }else
            {
                let recipeList = response.result.value
                self.recipeList = recipeList
            }
            
            
        }
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themeRecipes?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeDiscussCellId, for: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let cell = cell as? RecipeDiscussCell else {
            return
        }
        if let themeRecipes = themeRecipes {
            cell.themeRecipe = themeRecipes[(indexPath as NSIndexPath).item]
        }
    
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableHeaderView:UICollectionReusableView? = nil
        
        if kind == "UICollectionElementKindSectionHeader" {
            reusableHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reusableHeaderViewID, for: indexPath)
            reusableHeaderView?.addSubview(cycleView)
        }
        
        return reusableHeaderView ?? UICollectionReusableView()
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let themeRecipes = themeRecipes else{
            return
        }
        let headerRecipe = themeRecipes[(indexPath as NSIndexPath).item]
        if let id = headerRecipe.recipe_id {
            performSegue(withIdentifier: "showDetail", sender: id)
        }
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}

extension DiscoverViewController: SDCycleScrollViewDelegate
{
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        guard let headerRecipes = headerRecipes else{
            return
        }
        
        let headerRecipe = headerRecipes[index]
        if let id = headerRecipe.recipe_id {
            performSegue(withIdentifier: "showDetail", sender: id)
        }
    }
}


