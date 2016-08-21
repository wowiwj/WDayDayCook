//
//  MyCollectionCellTableViewCell.swift
//  WDayDayCook
//
//  Created by wangju on 16/7/26.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift



enum CellStyle:Int {
    case newFood
    case recipeList
    case themeList
    case recipeDiscussList
    
    var cellTitle :(title:String,image:UIImage){
        switch self {
        case .newFood:
            return ("每日新品",UIImage(named: "icon- 每日新品~iphone")!)
        case .recipeList:
            return ("热门推荐",UIImage(named: "icon－热门推荐~iphone")!)
        case .themeList:
            return ("主题推荐",UIImage(named: "icon－主题~iphone")!)
        case .recipeDiscussList:
            return ("话题推荐",UIImage(named: "icon－话题~iphone")!)
        }
    }
    
}

protocol MyCollectionCellDelegete {
    func didSeclectItem(item:Object)
}


class MyCollectionCell: BaseTitleViewCell {

    var delegate: MyCollectionCellDelegete?
    
    // MARK: - 接收的参数
    var newFoodItems: Results<NewFood>?{
        
        didSet{
            cellStyle = CellStyle.newFood

        }
    }
    /// 热门推荐
    var recipeList: Results<FoodRecmmand>? {
        
        didSet{
            cellStyle = CellStyle.recipeList
        }
    }
    var cellStyle:CellStyle?{
        didSet{
            titleView.title = cellStyle?.cellTitle.title
            titleView.image = cellStyle?.cellTitle.image
            collectionView.reloadData()
        }
    }
 
    
    let ArticleCellID = "ArticleCell"
  

    // MARK: - 布局设置
    
    // 每日新品和热门推荐以及话题推荐的layout
    lazy var flowLayout:UICollectionViewFlowLayout = {
    
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Horizontal
        return flowLayout
    }()
 
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.whiteColor()
        return collectionView

    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let height = self.collectionView.frame.size.height
        let size = CGSize(width: WDConfig.articleCellWidth.autoAdjust(), height: height)
        flowLayout.itemSize = size
 
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        
        collectionView.registerNib(UINib(nibName: ArticleCellID, bundle: nil), forCellWithReuseIdentifier: ArticleCellID)
        
        
        collectionView.snp_makeConstraints { (make) in
            make.top.equalTo(titleView.snp_bottom)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension MyCollectionCell: UICollectionViewDataSource,UICollectionViewDelegate
{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let cellStyle = cellStyle else
        {
            return 0
        }
        switch cellStyle {
        case .newFood:
            return newFoodItems?.count ?? 0
        case .recipeList:
            return recipeList?.count ?? 0
        default:
            return 0
        }
        

    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
 
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ArticleCellID, forIndexPath: indexPath)
        return cell
     

    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        guard let cellStyle = cellStyle else
        {
            return
        }
   
        switch cellStyle {
        case .newFood:
            let articleCell = cell as! ArticleCell
            articleCell.newFood = newFoodItems![indexPath.item]
        case .recipeList:
            let articleCell = cell as! ArticleCell
            articleCell.recipe = recipeList![indexPath.item]
        default:
            break
            
        }
    }
    
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        print(indexPath.item)
        
        guard let delegate = delegate else
        {
            return
        
        }
        
        
        
        if let recipeList = recipeList
        {
            delegate.didSeclectItem(recipeList[indexPath.row])
            print()
            return
        
        }
        
        if let newFoodItems = newFoodItems {
            delegate.didSeclectItem(newFoodItems[indexPath.row])
//            print(newFoodItems[indexPath.row])
            return
        }
        
        
        
    }

}