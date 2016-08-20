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

private let reuseIdentifier = "Cell"
private let reusableHeaderViewID = "DiscoverHeaderView"

class DiscoverViewController: UICollectionViewController {
    
    private lazy var cycleView:SDCycleScrollView = {
    
        let placeholderImage = UIImage(named: "default_1~iphone")!
        let screenSize = UIScreen.mainScreen().bounds.size
        let headerW = screenSize.width
        let headerH = placeholderImage.size.width / headerW * placeholderImage.size.height - 50
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
            
            print(themeRecipes)
            
            
        
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
        
        
        
        MakeUI()
        
        loadDatda()
        
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        
        self.collectionView?.backgroundColor = UIColor.greenColor()
        
        print("哈哈")

        // Do any additional setup after loading the view.
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
                let result = JSON(response.result.value!)
                print(result)
                
                let recipeList = Mapper<ThemeRecipeList>().map(response.result.value)
                self.recipeList = recipeList
            }
            
            let result = JSON(response.result.value!)
            
            print(result)
        }
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 20
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
 
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    
        // Configure the cell
        
        cell.backgroundColor = UIColor.redColor()
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        var reusableHeaderView:UICollectionReusableView? = nil
        
        print(kind)
        if kind == "UICollectionElementKindSectionHeader" {
            reusableHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: reusableHeaderViewID, forIndexPath: indexPath)
            reusableHeaderView?.addSubview(cycleView)
            
            
        }
        
        return reusableHeaderView ?? UICollectionReusableView()
        
        
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


}
