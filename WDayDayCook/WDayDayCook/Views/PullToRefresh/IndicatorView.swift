//
//  indecatorView.swift
//  WDayDayCook
//
//  Created by wangju on 16/7/24.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit

class indecatorView: UIImageView {

    private lazy var images:[UIImage] = {
    
        var array = [UIImage]()
        
        for i in 1...6{
            let image = UIImage(named: "load\(i)~iphone")
            array.append(image!)
        }
        
        return array
    
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        image = UIImage(named: "load1")
        
        animationImages = images
        
        animationDuration = 1
        animationRepeatCount = 0
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
