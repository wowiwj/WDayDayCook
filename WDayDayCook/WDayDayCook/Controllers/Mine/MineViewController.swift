//
//  MineViewController.swift
//  WDayDayCook
//
//  Created by wangju on 16/8/21.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit

class MineViewController: UIViewController {
    
    private lazy var customNavigationItem: UINavigationItem = UINavigationItem(title: "")
    
    private lazy var customNavgationBar:UINavigationBar = {
        
        let bar = UINavigationBar(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64))
        bar.setItems([self.customNavigationItem], animated: false)
        
        bar.backgroundColor = UIColor.clearColor()
        bar.translucent = true
        bar.shadowImage = UIImage()
        bar.barStyle = UIBarStyle.BlackTranslucent
        bar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        return bar
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()

        // Do any additional setup after loading the view.
    }
    
    func makeUI()
    {
        view.addSubview(customNavgationBar)
        let setButton = UIButton()
        setButton.setImage(UIImage(named: "iPhone_personal_set_btn~iphone"), forState: .Normal)
        setButton.sizeToFit()
        setButton.addTarget(self, action: #selector(MineViewController.setBarButtonClicked), forControlEvents: .TouchUpInside)
        let setItem = UIBarButtonItem(customView: setButton)
        customNavigationItem.rightBarButtonItem = setItem
        
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
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
    
    // MARK: - 消息的监听
    @objc private func setBarButtonClicked()
    {
        print("666666")
    }

}
