//
//  RecipeListTableViewCell.swift
//  WDayDayCook
//
//  Created by wangju on 16/7/28.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import RealmSwift

class RecipeDiscussListTableViewCell: BaseTitleViewCell {

    
     let RecipeDiscussCellID = "RecipeDiscussCell"
    /// 话题推荐
    var recipeDiscussList: Results<FoodRecmmand>? {
        
        didSet{
            cellStyle = CellStyle.recipeDiscussList
            collectionView.collectionViewLayout = recipeDiscussLayout
            
        }
    }
    
    var cellStyle:CellStyle?{
        didSet{
            titleView.title = cellStyle?.cellTitle.title
            titleView.image = cellStyle?.cellTitle.image
            collectionView.reloadData()
        }
    }

    // 每日新品和热门推荐以及话题推荐的layout
    lazy var recipeDiscussLayout:UICollectionViewFlowLayout = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.recipeDiscussLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        return collectionView
        
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        
        collectionView.register(UINib(nibName: RecipeDiscussCellID, bundle: nil), forCellWithReuseIdentifier: RecipeDiscussCellID)

        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleView.snp.bottom)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let height = self.collectionView.frame.size.height
        let size = CGSize(width: WDConfig.articleCellWidth, height: height)
        recipeDiscussLayout.itemSize = size
        
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension RecipeDiscussListTableViewCell :UICollectionViewDelegate,UICollectionViewDataSource
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeDiscussList?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeDiscussCellID, for: indexPath)
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let articleCell = cell as! RecipeDiscussCell
        articleCell.recipeDiscuss = recipeDiscussList![(indexPath as NSIndexPath).row]
   
    }


}
