//
//  CGFloat+Extension.swift
//  WDayDayCook
//
//  Created by wangju on 16/8/21.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit

extension CGFloat{

    /// 根据当前屏幕宽度的尺寸自动调节大小
    func autoAdjust(currentWidth:CGFloat = 320)->CGFloat {
        return self * UIScreen.mainScreen().bounds.size.width / currentWidth
    }
}
