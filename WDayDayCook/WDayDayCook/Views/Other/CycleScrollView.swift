//
//  CicleScrollView.swift
//  WDayDayCook
//
//  Created by wangju on 16/7/25.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit

class CycleScrollView: UIView {
    
    var imagesURL = []
    let images = []
    
    var placeholder:UIImage?
    
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
        backgroundColor = UIColor.redColor()
    
    }
    
    
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
