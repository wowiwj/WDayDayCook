//
//  UIImageView+Extension.swift
//  WDayDayCook
//
//  Created by wangju on 16/9/15.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit

extension UIImageView {

    
    func startRotation()->UIImageView
    {
        
        let animation = CABasicAnimation(keyPath: "transform")
        animation.fromValue = NSValue(CATransform3D: CATransform3DIdentity)
        animation.toValue = NSValue(CATransform3D: CATransform3DMakeRotation(CGFloat(M_PI), 0, 0, 1))
        animation.duration = 0.5
        animation.cumulative = true
        animation.repeatCount = Float(Int.max)
        self.layer.addAnimation(animation, forKey: nil)
        return self
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
