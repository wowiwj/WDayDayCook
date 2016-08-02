//
//  ThemeListTableViewCell.swift
//  WDayDayCook
//
//  Created by wangju on 16/7/28.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import RealmSwift

protocol ThemeListTableViewCellDelagate {
    func didSeclectItem(item:Object)
}

class ThemeListTableViewCell: BaseTitleViewCell {

    
    var themeList: Results<FoodRecmmand>? {
        didSet{
            cellStyle = CellStyle.themeList
            collectionView.collectionViewLayout = themeListLayout
            //            print(themeList)
        }
    }

    var delegate: ThemeListTableViewCellDelagate?
    
    let ThemeRecommandCellID = "ThemeRecommandCell"
    
    // 主题推荐的layout
    lazy var themeListLayout:UICollectionViewFlowLayout = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        return flowLayout
    }()
    
    var cellStyle:CellStyle?{
        didSet{
            titleView.title = cellStyle?.cellTitle.title
            titleView.image = cellStyle?.cellTitle.image
            collectionView.reloadData()
        }
    }
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.themeListLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerNib(UINib(nibName: self.ThemeRecommandCellID, bundle: nil), forCellWithReuseIdentifier: self.ThemeRecommandCellID)
        return collectionView
        
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        
        collectionView.registerNib(UINib(nibName: ThemeListTableViewCellID, bundle: nil), forCellWithReuseIdentifier: ThemeListTableViewCellID)
        
        
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = collectionView.frame.size.width
        let height = self.collectionView.frame.size.height / 4
        
        if width <= 0 && height <= 0 {
            return
        }
        
        themeListLayout.itemSize = CGSize(width: width, height: height)
        
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ThemeListTableViewCell: UICollectionViewDataSource,UICollectionViewDelegate
{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themeList?.count >= 4 ? 4  : 0
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ThemeRecommandCellID, forIndexPath: indexPath)
        return cell

        
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
 
        let themeCell = cell as! ThemeRecommandCell
        themeCell.theme = themeList![indexPath.row]
   
    }
    
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        print(indexPath.item)
        
        guard let delegate = delegate else
        {
            return
            
        }
        
        if let themeList = themeList
        {
            delegate.didSeclectItem(themeList[indexPath.row])
            print()
            
        }
    }

    
}
