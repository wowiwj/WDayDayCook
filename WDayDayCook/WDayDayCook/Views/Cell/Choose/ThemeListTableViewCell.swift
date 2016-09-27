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
    func didSeclectItem(_ item:Object)
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
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        let width = UIScreen.main.bounds.size.width
        let height = WDConfig.themeListHeight.autoAdjust()
        
        flowLayout.itemSize = CGSize(width: width, height: height)
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
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.themeListLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.isScrollEnabled = false
        collectionView.register(UINib(nibName: self.ThemeRecommandCellID, bundle: nil), forCellWithReuseIdentifier: self.ThemeRecommandCellID)
        return collectionView
        
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        
        collectionView.register(UINib(nibName: ThemeListTableViewCellID, bundle: nil), forCellWithReuseIdentifier: ThemeListTableViewCellID)
        
        
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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ThemeListTableViewCell: UICollectionViewDataSource,UICollectionViewDelegate
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themeList?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeRecommandCellID, for: indexPath)
        return cell

        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
 
        let themeCell = cell as! ThemeRecommandCell
        themeCell.theme = themeList![(indexPath as NSIndexPath).row]
   
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print((indexPath as NSIndexPath).item)
        
        guard let delegate = delegate else
        {
            return
            
        }
        
        if let themeList = themeList
        {
            delegate.didSeclectItem(themeList[(indexPath as NSIndexPath).row])
            print()
            
        }
    }

    
}
