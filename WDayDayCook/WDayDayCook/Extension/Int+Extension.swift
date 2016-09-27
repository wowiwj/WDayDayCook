//
//  Int+Extension.swift
//  WDayDayCook
//
//  Created by wangju on 16/9/12.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit

extension Int{
    
    func CGFloatValue()->CGFloat {
        return CGFloat(self)
    }
    
    /// 根据当前屏幕宽度的尺寸自动调节大小
    func autoAdjust(_ currentWidth:Int = 320)->CGFloat {
        return CGFloat(self) * UIScreen.main.bounds.size.width / currentWidth.CGFloatValue()
    }
    
    

}
