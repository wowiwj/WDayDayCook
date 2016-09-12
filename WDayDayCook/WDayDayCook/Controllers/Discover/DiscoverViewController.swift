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

private let RecipeDiscussCellId = "RecipeDiscussCell"
private let reusableHeaderViewID = "DiscoverHeaderView"

class DiscoverViewController: UICollectionViewController {
    
    private lazy var cycleView:SDCycleScrollView = {
    
        let placeholderImage = UIImage(named: "default_1~iphone")!
        let screenSize = UIScreen.mainScreen().bounds.size
        let headerW = screenSize.width
        let headerH = headerW / placeholderImage.size.width * placeholderImage.size.height
        let size = CGSize(width: headerW, height: headerH)
        let cycleView = SDCycleScrollView(frame: CGRect(origin: CGPointZero, size: size), delegate: self, placeholderImage: placeholderImage)
        
        return cycleView
    
    }()
    
    var recipeList:ThemeRecipeList?{
    
        didSet{
            guard let recipeList = recipeList else{
                return
            }
            self.themeRecipes = recipeList.themeRecipes.sort { (theme1, theme2) -> Bool in
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
        
        loadDatda()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false


    }
    
    func MakeUI()
    {
        func setLayout()
        {
            let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
            
            let screenSize = UIScreen.mainScreen().bounds.size
            
            let width = (screenSize.width - WDConfig.discoverDefaultMargin) * 0.5
            let height = width
            
            layout.itemSize = CGSizeMake(width, height)
            layout.minimumLineSpacing = WDConfig.discoverDefaultMargin
            layout.minimumInteritemSpacing = WDConfig.discoverDefaultMargin
            
            layout.sectionInset = UIEdgeInsets(top: WDConfig.discoverDefaultMargin, left: 0, bottom: 0, right: 0)
            
            layout.headerReferenceSize = cycleView.frame.size
        }
        
        setLayout()
        
        collectionView?.registerNib(UINib(nibName: RecipeDiscussCellId, bundle: nil), forCellWithReuseIdentifier: RecipeDiscussCellId)
        self.collectionView?.backgroundColor = UIColor.whiteColor()
 
    }
    
    func loadDatda()
    {
        Alamofire.request(Router.MoreThemeRecipe(parameters: nil)).responseJSON {[unowned self] (response) in
            
            
            self.collectionView!.headerEndRefreshing()
            if response.result.isFailure
            {
                print(response.result.error)
                return
            }else
            {
                let recipeList = Mapper<ThemeRecipeList>().map(response.result.value)
                self.recipeList = recipeList
            }

        }
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themeRecipes?.count ?? 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
 
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(RecipeDiscussCellId, forIndexPath: indexPath)
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        guard let cell = cell as? RecipeDiscussCell else {
            return
        }
        if let themeRecipes = themeRecipes {
            cell.themeRecipe = themeRecipes[indexPath.item]
        }
    
    }
    
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        var reusableHeaderView:UICollectionReusableView? = nil
        
        if kind == "UICollectionElementKindSectionHeader" {
            reusableHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: reusableHeaderViewID, forIndexPath: indexPath)
            reusableHeaderView?.addSubview(cycleView)
        }
        
        return reusableHeaderView ?? UICollectionReusableView()
        
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard let themeRecipes = themeRecipes else{
            return
        }
        let headerRecipe = themeRecipes[indexPath.item]
        if let id = headerRecipe.recipe_id {
            performSegueWithIdentifier("showDetail", sender: id)
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
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        guard let headerRecipes = headerRecipes else{
            return
        }
        
        let headerRecipe = headerRecipes[index]
        if let id = headerRecipe.recipe_id {
            performSegueWithIdentifier("showDetail", sender: id)
        }
    }
}


