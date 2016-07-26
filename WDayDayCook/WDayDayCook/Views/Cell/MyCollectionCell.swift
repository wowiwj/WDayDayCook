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



class MyCollectionCell: BaseTitleViewCell {

    var newFoodItems: Results<NewFood>?{
        
        didSet{
            
            collectionView.reloadData()
            
        }
    }
    
    let ArticleCellID = "ArticleCell"
    
    lazy var flowLayout:UICollectionViewFlowLayout = {
    
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Horizontal
        
        return flowLayout
    }()
    
    lazy var collectionView: UICollectionView = {
    
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.flowLayout)
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
        let height = collectionView.frame.size.height
        let size = CGSize(width: 160, height: height)
        
        flowLayout.itemSize = size
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.registerNib(UINib(nibName: ArticleCellID, bundle: nil), forCellWithReuseIdentifier: ArticleCellID)
        collectionView.backgroundColor = UIColor.whiteColor()
       
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
        return newFoodItems?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ArticleCellID, forIndexPath: indexPath)
        
        cell.backgroundColor = UIColor.greenColor()
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        print("------")
        
        if let _ = newFoodItems,articleCell = cell as? ArticleCell {
            articleCell.newFood = newFoodItems![indexPath.item]
        }
        
        
    }
    
    


}

