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


class MyCollectionCell: BaseTitleViewCell {

    
    // MARK: - 接收的参数
    var newFoodItems: Results<NewFood>?{
        
        didSet{
            cellStyle = CellStyle.newFood

        }
    }
    
    var themeList: Results<FoodRecmmand>? {
        didSet{
            cellStyle = CellStyle.themeList
            collectionView.collectionViewLayout = themeListLayout
            print(themeList)
        }
    }
    
    /// 热门推荐
    var recipeList: Results<FoodRecmmand>? {
        
        didSet{
            cellStyle = CellStyle.recipeList
        }
    }
    
    /// 话题推荐
    var recipeDiscussList: Results<FoodRecmmand>? {
        
        didSet{
            cellStyle = CellStyle.recipeDiscussList

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
    let ThemeRecommandCellID = "ThemeRecommandCell"

    // MARK: - 布局设置
    
    // 每日新品和热门推荐以及话题推荐的layout
    lazy var flowLayout:UICollectionViewFlowLayout = {
    
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Horizontal
        return flowLayout
    }()
    
    // 主题推荐的layout
    lazy var themeListLayout:UICollectionViewFlowLayout = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
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
        collectionView.snp_makeConstraints { (make) in
            make.top.equalTo(titleView.snp_bottom)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        
        if let _ = themeList { // 接收的为主题推荐
            let width = collectionView.frame.size.width
            let height = collectionView.frame.size.height / (CGFloat(themeList?.count ?? 1))
            themeListLayout.itemSize = CGSizeMake(width, height)
        }else
        {
            // 设置布局的属性
            let height = collectionView.frame.size.height
            let size = CGSize(width: WDConfig.articleCellWidth, height: height)
            flowLayout.itemSize = size
        
        }

        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        
        collectionView.registerNib(UINib(nibName: ArticleCellID, bundle: nil), forCellWithReuseIdentifier: ArticleCellID)
        collectionView.registerNib(UINib(nibName: ThemeRecommandCellID, bundle: nil), forCellWithReuseIdentifier: ThemeRecommandCellID)
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
        case .themeList:
            return themeList?.count ?? 0
        case .recipeList:
            return recipeList?.count ?? 0
        default:
            return recipeDiscussList?.count ?? 0
        }
        

    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if self.cellStyle == CellStyle.themeList
        {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ThemeRecommandCellID, forIndexPath: indexPath)
            return cell
        
        }else
        {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ArticleCellID, forIndexPath: indexPath)
            return cell
        }

    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        print("------")
        
        guard let cellStyle = cellStyle else
        {
            return
        }
        
        if cellStyle == CellStyle.themeList
        {
            let themeCell = cell as! ThemeRecommandCell
            themeCell.theme = themeList![indexPath.row]
            return
        }
        
        let articleCell = cell as! ArticleCell
        
        switch cellStyle {
        case .newFood:
            articleCell.newFood = newFoodItems![indexPath.item]
//        case .themeList:
//            articleCell.newFood = themeList[indexPath.row]
        case .recipeList:
            articleCell.recipe = recipeList![indexPath.item]
        default:
            break
            
        }
        
        
    }
    
    


}

