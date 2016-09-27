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
    
    fileprivate lazy var waterlayout:WaterFlowlayout = {
    
        let layout = WaterFlowlayout()
        layout.delegate = self
        return layout
    
    }()
    
    // 当前页
    var currentpage = 0
    
    
    fileprivate lazy var listlayout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 320, height: 150)
        return layout
        
    }()
    
    fileprivate lazy var scrollTopButton:UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage(named: "upupupIcon~iphone"), for: UIControlState())
        button.isHidden = true
        button.sizeToFit()
        button.addTarget(self, action: #selector(scrollButtonClicked), for: .touchUpInside)
        return button
        
    }()
    
    var recipeList = [Recipe]()
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.register(UINib(nibName: ArticleCellID, bundle: nil), forCellWithReuseIdentifier: ArticleCellID)
            
            collectionView.collectionViewLayout = waterlayout
            collectionView.backgroundColor = UIColor.clear
        
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
    fileprivate func makeUI()
    {
        let button = UIButton()
        button.setImage(UIImage(named: "icon－list~iphone"), for: UIControlState())
        button.setImage(UIImage(named: "icon－缩略图~iphone"), for: .selected)
        button.sizeToFit()
        button.addTarget(self, action: #selector(layoutStyleButtonClicked(_:)), for: UIControlEvents.touchUpInside)

        let layoutStyleItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = layoutStyleItem
        
        let searchButton = UIBarButtonItem(image: UIImage(named: "icon-search~iphone"), style: .plain, target: self, action: #selector(RecipeViewController.searchButtonClicked(_:)))
        navigationItem.rightBarButtonItem = searchButton
        view.addSubview(scrollTopButton)
       
        scrollTopButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(collectionView.snp.bottom).offset(-20)
            make.trailing.equalTo(collectionView).offset(-20)
        }
        
    }
    
    // MARK: - 网络请求
    func loadNewData()
    {
        currentpage = 0
        recipeList.removeAll()
        loadMoreData()
        
    }
    
    func loadMoreData(){
        
        
        Alamofire.request(Router.recipeList(currentpage: currentpage, pageSize: 20)).responseObject { (response:DataResponse<RecipeList>) in
            
            self.collectionView.headerEndRefreshing()
            self.collectionView.footerEndRefreshing()
            if response.result.isFailure
            {
                print(response.result.error)
                return
            }else
            {
                let recipeList = response.result.value
                
                
                if recipeList?.code == "200"
                {
                    self.currentpage += 1
                    self.recipeList += recipeList!.data!
                    self.collectionView.reloadData()
                    
                }else
                {
                    print(recipeList?.msg)
                }
                
            }
    
        }
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - 动作监听
    @objc fileprivate func layoutStyleButtonClicked(_ button:UIButton)
    {
        button.isSelected = !button.isSelected
    
        button.isSelected ?(collectionView.collectionViewLayout = listlayout) :(collectionView.collectionViewLayout = waterlayout)
        
        collectionView.reloadData()
    
    }
    @objc fileprivate func scrollButtonClicked()
    {
        
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: UICollectionViewScrollPosition.top, animated: true)
        
    }
    
    @objc fileprivate func searchButtonClicked(_ button:UIButton)
    {

    
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
}

extension RecipeViewController:UICollectionViewDelegate,UICollectionViewDataSource
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCellID, for: indexPath) as! ArticleCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ArticleCell else{
            return
        }
        cell.recipeData = recipeList[(indexPath as NSIndexPath).item]
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ArticleCell else{
            return
        }
        cell.foodImageView.image = nil
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let id = recipeList[(indexPath as NSIndexPath).item].id {
            performSegue(withIdentifier: "showDetail", sender: id)
        }
        
    }


}

extension RecipeViewController: UICollectionViewWaterFlowLayoutDelegate
{
    func waterFlowLayout(_ waterFlowLayout: WaterFlowlayout, heightForItemAtIndexpath indexpath: IndexPath, itemWidth: CGFloat) -> CGFloat {
        let defaultValue: CGFloat = 0
        let arr = recipeList.map{ $0.screeningId ?? (defaultValue,defaultValue,defaultValue) }
        
        let (_,value2,_) = arr[(indexpath as NSIndexPath).item]
//        if UIScreen.mainScreen().bounds.size.width > 320 {
//            value2 *= UIScreen.mainScreen().bounds.size.width / 320
//        }
        
        return CGFloat(value2).autoAdjust()
    }
    
    func columnCountInwaterFlowLayout(_ waterFlowLayout: WaterFlowlayout) -> Int {
        return 2
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        scrollTopButton.isHidden = offsetY < UIScreen.main.bounds.size.height
    }


}



