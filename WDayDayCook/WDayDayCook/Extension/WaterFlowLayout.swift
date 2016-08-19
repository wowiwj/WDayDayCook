//
//  WaterFlowLayout.swift
//  WDayDayCook
//
//  Created by wangju on 16/8/19.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit

@objc protocol UICollectionViewWaterFlowLayoutDelegate: NSObjectProtocol{
    
    func waterFlowLayout(waterFlowLayout:WaterFlowlayout,heightForItemAtIndexpath indexpath:NSIndexPath,itemWidth:CGFloat)->CGFloat
    
    
    optional func columnCountInwaterFlowLayout(waterFlowLayout:WaterFlowlayout)->Int
    optional func columnMarginInwaterFlowLayout(waterFlowLayout:WaterFlowlayout)->CGFloat
    optional func rowMarginInwaterFlowLayout(waterFlowLayout:WaterFlowlayout)->CGFloat
    optional func edgeInsertInwaterFlowLayout(waterFlowLayout:WaterFlowlayout)->UIEdgeInsets
    
}

class WaterFlowlayout: UICollectionViewLayout {
    
    // MARK: 默认值属性
    
    // 默认行数
    private let DefaultColCount:Int = 3
    // 默认每一列的间距
    private let DefaultColMargin:CGFloat = 10
    // 默认每一行的间距
    private let DefaultRowMargin:CGFloat = 10
    // 默认边缘间距
    private let DefaultEdgeInsert:UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    
    // MARK: - 代理

    weak var delegate:UICollectionViewWaterFlowLayoutDelegate?
    
    
    // MARK: - 数据处理
    private var rowMargin:CGFloat{
        if let delegate = delegate where delegate.respondsToSelector(#selector(UICollectionViewWaterFlowLayoutDelegate.rowMarginInwaterFlowLayout(_:))) {
            return delegate.rowMarginInwaterFlowLayout!(self)
        }
        return DefaultRowMargin
        
    }
    
    private var colCount:Int{
        if let delegate = delegate where delegate.respondsToSelector(#selector(UICollectionViewWaterFlowLayoutDelegate.columnCountInwaterFlowLayout(_:))) {
            return delegate.columnCountInwaterFlowLayout!(self)
        }
        return DefaultColCount
        
    }
    
    private var colMargin:CGFloat{
        if let delegate = delegate where delegate.respondsToSelector(#selector(UICollectionViewWaterFlowLayoutDelegate.columnMarginInwaterFlowLayout(_:))) {
            return delegate.columnMarginInwaterFlowLayout!(self)
        }
        return DefaultColMargin
        
    }
    
    private var edgeInsert:UIEdgeInsets{
        if let delegate = delegate where delegate.respondsToSelector(#selector(UICollectionViewWaterFlowLayoutDelegate.edgeInsertInwaterFlowLayout(_:))) {
            return delegate.edgeInsertInwaterFlowLayout!(self)
        }
        return DefaultEdgeInsert
        
    }
    
    //  所有collectionView的布局属性
    private var attrsArr:Array = [UICollectionViewLayoutAttributes]()
    /** 存放所有列的最大Y值 */
    private var colHeights:Array = [CGFloat]()
    
    
    // MARK: - 瀑布流的核心计算
    
    // 初始化
    override func prepareLayout() {
        super.prepareLayout()
        
        
//        
        colHeights.removeAll()

        for _ in 0..<colCount {
            colHeights.append(edgeInsert.top)
        }
        
        attrsArr.removeAll()

        var attArr = [UICollectionViewLayoutAttributes]()
        
        let count = collectionView!.numberOfItemsInSection(0)

        
        for i in 0..<count {
            let indexPath = NSIndexPath(forItem: i, inSection: 0)
            
            let attr = layoutAttributesForItemAtIndexPath(indexPath)
            attArr.append(attr!)
        
        }
        attrsArr = attArr
  
    }
    
    // 决定cell的排布
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrsArr
    }
    
    // 返回indexPath的cell对应的布局属性
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        let attribute = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        
        guard let delegate = delegate else
        {
            return attribute
        }
        
        
        if let collectionView = collectionView {
            
            let w:CGFloat = (collectionView.frame.size.width - self.edgeInsert.left - self.edgeInsert.right - CGFloat(colCount - 1) * colMargin) / CGFloat(colCount)
            let h:CGFloat = delegate.waterFlowLayout(self, heightForItemAtIndexpath: indexPath, itemWidth: w)
            var destColumn:NSInteger = 0
            var minColHeight = colHeights[0]
            
            for i in 1..<colCount {
                let columnHeight = colHeights[i]
                
                if minColHeight > columnHeight {
                    minColHeight = columnHeight
                    destColumn = i
                }
                
            }
            
            let x = edgeInsert.left + (w + colMargin) * CGFloat(destColumn)
            var y = minColHeight
            
            if y != edgeInsert.top {
                y += rowMargin
            }
            
            attribute.frame = CGRect(x: x, y: y, width: w, height: h)
            
            self.colHeights[destColumn] = CGRectGetMaxY(attribute.frame)
        }
        return attribute
    }
    
    override func collectionViewContentSize() -> CGSize {
        
        var maxColHeight:CGFloat = colHeights[0]
        
        for i in 1..<colCount {
            let columnHeight = colHeights[i]
            if maxColHeight < columnHeight {
                maxColHeight = columnHeight
            }
        }
        
        
        return CGSize(width: 0, height: maxColHeight + edgeInsert.bottom)
    }
    

    
    
}



