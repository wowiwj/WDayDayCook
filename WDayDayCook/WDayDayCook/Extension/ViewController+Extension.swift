//
//  ViewController+Extension.swift
//  WDayDayCook
//
//  Created by wangju on 16/8/21.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit

extension UINavigationController {
    public func pushToDetailViewController(_ id: Int, animated: Bool)
    {
        let sb = UIStoryboard(name: "ShowDetail", bundle: nil)
        let showDetailVc = sb.instantiateViewController(withIdentifier: "showDetailController") as! ShowDetailViewController
        showDetailVc.id = id
        
        DispatchQueue.main.async(execute: {
            self.pushViewController(showDetailVc, animated: animated)
        })

    }
    
}
