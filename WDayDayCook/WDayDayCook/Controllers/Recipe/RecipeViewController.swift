//
//  RecipeViewController.swift
//  WDayDayCook
//
//  Created by wangju on 16/8/19.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper


let ArticleCellID = "ArticleCell"


class RecipeViewController: UIViewController {
    
    private lazy var waterlayout:WaterFlowlayout = {
    
        let layout = WaterFlowlayout()
        layout.delegate = self
        return layout
    
    }()
    
    // 当前页
    var currentpage = 0
    
    
    private lazy var listlayout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 320, height: 150)
        return layout
        
    }()
    
    var recipeList = [Recipe]()
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
//            collectionView.collectionViewLayout = layout()
            collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "123")
            collectionView.registerNib(UINib(nibName: ArticleCellID, bundle: nil), forCellWithReuseIdentifier: ArticleCellID)
            
            collectionView.collectionViewLayout = waterlayout
            collectionView.backgroundColor = UIColor.whiteColor()
        
        }
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        
        collectionView.addHeaderWithCallback { 
            self.loadNewData()
        }
        
        collectionView.headerBeginRefreshing()
        
        collectionView.addFooterWithCallback { 
            self.loadMoreData()
        }
    }
    

    // 初始化UI
    private func makeUI()
    {
        let button = UIButton()
        button.setImage(UIImage(named: "icon－list~iphone"), forState: .Normal)
        button.setImage(UIImage(named: "icon－缩略图~iphone"), forState: .Selected)
        button.sizeToFit()
        button.addTarget(self, action: #selector(layoutStyleButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)

        let layoutStyleItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = layoutStyleItem
        
        let searchButton = UIBarButtonItem(image: UIImage(named: "icon-search~iphone"), style: .Plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = searchButton
    }
    
    // MARK: - 网络请求
    func loadNewData()
    {
        currentpage = 0
        recipeList.removeAll()
        loadMoreData()
        
    }
    
    func loadMoreData(){
    
        Alamofire.request(Router.RecipeList(currentpage: currentpage, pageSize: 20)).responseJSON { [unowned self](response) in
            
            if response.result.isFailure
            {
                print(response.result.error)
                return
            }else
            {
                let result = JSON(response.result.value!)
                print(result)
                
                let recipeList = Mapper<RecipeList>().map(response.result.value)
                
                if recipeList?.code == "200"
                {
                    self.currentpage += 1
                    self.recipeList += recipeList!.data!
                    self.collectionView.reloadData()
                    
                }else
                {
                    print(recipeList?.msg)
                }
                self.collectionView.headerEndRefreshing()
                self.collectionView.footerEndRefreshing()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - 动作监听
    @objc private func layoutStyleButtonClicked(button:UIButton)
    {
        button.selected = !button.selected
    
        button.selected ?(collectionView.collectionViewLayout = listlayout) :(collectionView.collectionViewLayout = waterlayout)
        
        collectionView.reloadData()
    
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


}

extension RecipeViewController:UICollectionViewDelegate,UICollectionViewDataSource
{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ArticleCellID, forIndexPath: indexPath) as! ArticleCell

        cell.recipeData = recipeList[indexPath.item]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        

        
        if let id = recipeList[indexPath.item].id {
            performSegueWithIdentifier("showDetail", sender: id)
        }
        
        print(indexPath)
        
    }


}

extension RecipeViewController: UICollectionViewWaterFlowLayoutDelegate
{
    func waterFlowLayout(waterFlowLayout: WaterFlowlayout, heightForItemAtIndexpath indexpath: NSIndexPath, itemWidth: CGFloat) -> CGFloat {
        return CGFloat(arc4random_uniform(80) + 200)
    }
    
    func columnCountInwaterFlowLayout(waterFlowLayout: WaterFlowlayout) -> Int {
        return 2
    }

}



