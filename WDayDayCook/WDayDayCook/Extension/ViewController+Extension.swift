//
//  ViewController+Extension.swift
//  WDayDayCook
//
//  Created by wangju on 16/8/21.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit

extension UINavigationController {
    public func pushToDetailViewController(id: Int, animated: Bool)
    {
        let sb = UIStoryboard(name: "ShowDetail", bundle: nil)
        let showDetailVc = sb.instantiateViewControllerWithIdentifier("showDetailController") as! ShowDetailViewController
        showDetailVc.id = id
        
        dispatch_async(dispatch_get_main_queue(), {
            self.pushViewController(showDetailVc, animated: animated)
        })

    }
    
}
