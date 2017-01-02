//
//  UIImageView+Extension.swift
//  WDayDayCook
//
//  Created by wangju on 16/9/15.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit

extension UIImageView {

    
    public func startRotation()
    {
        
        let animation = CABasicAnimation(keyPath: "transform")
        animation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        animation.toValue = NSValue(caTransform3D: CATransform3DMakeRotation(CGFloat(M_PI), 0, 0, 1))
        animation.duration = 0.5
        animation.isCumulative = true
        animation.repeatCount = Float(Int.max)
        self.layer.add(animation, forKey: nil)
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
