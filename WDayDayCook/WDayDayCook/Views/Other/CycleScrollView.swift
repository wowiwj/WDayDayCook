//
//  CicleScrollView.swift
//  WDayDayCook
//
//  Created by wangju on 16/7/25.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit

class CycleScrollView: UIView {
    
    var imagesURL = []{
        didSet{
            collectionView?.reloadData()
            print(imagesURL)
        
        }
    
    }
    let images = []
    
    var placeholder:UIImage?{
        didSet{
        
        
        }
    }
    
    
    // 自己的属性
    private var collectionView:UICollectionView?
    private var layout:CycleViewLayout!
    
    convenience init(placeholder: UIImage,imagesURL:[String]) {
        let size = placeholder.size
        self.init(frame: CGRect(origin: CGPointZero, size: size))
        self.imagesURL = imagesURL
        
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    
    private func makeUI()
    {
        
        layout = CycleViewLayout()
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        addSubview(collectionView!)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        backgroundColor = UIColor.redColor()
        
        collectionView?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "1111")
        collectionView?.pagingEnabled = true
        
        
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print("---")
        collectionView!.frame = self.bounds
        collectionView!.backgroundColor = UIColor.greenColor()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        if let cv = collectionView {
            layout.itemSize = cv.bounds.size ?? CGSizeZero
        }
        
        
        layout.scrollDirection = .Horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        
    }
    
    
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

extension CycleScrollView :UICollectionViewDelegate,UICollectionViewDataSource
{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(images.count)
        
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier("1111", forIndexPath: indexPath)
        
        if indexPath.item % 2 == 0 {
            cell.backgroundColor = UIColor.blueColor()
        }else
        {
            cell.backgroundColor = UIColor.redColor()
        
        }
        
        
        
        
            return cell
    }
    
       
  


}

class CycleViewLayout: UICollectionViewFlowLayout
{
    override func prepareLayout() {
        super.prepareLayout()
    }
    
    
    


}


