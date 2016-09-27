//
//  CustomNavigationController.swift
//  WDayDayCook
//
//  Created by wangju on 16/9/20.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Nav bar
        let navBar = self.navigationBar
        
        //   navBar.backgroundColor = UIColor.whiteColor()
        navBar.tintColor = UIColor.darkGray
        // 导航条默认设置为不透明
        navBar.isTranslucent = false
        
        // navBg~iphone navi_bar_bg~iphone navBg2~iphone
        navBar.setBackgroundImage(UIImage(named: "navi_bar_bg~iphone"), for: .default)
        // 取消navbar 下面的细线
        //        navBar.shadowImage = UIImage()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
