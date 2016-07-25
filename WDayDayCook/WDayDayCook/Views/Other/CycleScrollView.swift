//
//  CicleScrollView.swift
//  WDayDayCook
//
//  Created by wangju on 16/7/25.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit

enum imageStyle {
    case current
    case front
    case behind
}

class scrollImage: UIImage
{
    var scrollStyle :imageStyle?
    


}


class CycleScrollView: UIView {
    
    var imagesURL = []{
        didSet{
            
            print(imagesURL)
        
        }
    
    }
    let images = []
    
    var placeholder:UIImage?{
        didSet{
        
        
        }
    }
    
    
    // 自己的属性
    private var scrollView:UIScrollView?
    
    

    
    
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
        
        scrollView = UIScrollView()
        addSubview(scrollView!)
        scrollView?.pagingEnabled = true
        
        scrollView?.delegate = self
        
        scrollView?.setContentOffset(CGPoint(x: 100, y: 0), animated: false)
        
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView?.frame = self.bounds
        scrollView?.backgroundColor = UIColor.yellowColor()
        
        scrollView?.contentSize = CGSize(width: self.bounds.width * 3, height: self.bounds.height)
        
        print("---")
     
        
    }
    
    
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

extension CycleScrollView: UIScrollViewDelegate
{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("----")
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        print("@@@@@")
        
        let index = scrollView.contentOffset.x / scrollView.frame.size.width
        
        print(index)
        
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.size.width, y: 0), animated: false)
        
        
        
    }
    


}



