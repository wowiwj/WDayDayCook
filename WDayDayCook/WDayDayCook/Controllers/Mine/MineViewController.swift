//
//  MineViewController.swift
//  WDayDayCook
//
//  Created by wangju on 16/8/21.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import SnapKit

class MineViewController: UIViewController {
    
    @IBOutlet weak var topViewHeightCons: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!{
        didSet{

        }
    }
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
    
    // 显示标题 我的收藏 与 足迹的View
    private lazy var titleView:IndicatorTitleView = {
    
        let view = IndicatorTitleView()
        self.view.addSubview(view)
        view.titles = ["我的收藏","我的足迹"]
        view.setTitlesColor(UIColor.WD_MineTitleDefaultColor(), forState: UIControlState.Normal)
        view.setTitlesColor(UIColor.orangeColor(), forState: UIControlState.Selected)
        view.titleLabelsFont = UIFont.systemFontOfSize(15.autoAdjust())
        return view
    }()
    
    // 显示详细内容的View
    private lazy var contentView:UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.yellowColor()
        
        self.view.addSubview(view)
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        titleView.delegate = self
        titleView.setTitleSelectIndex(0)
        

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
        
        topViewHeightCons.constant = topViewHeightCons.constant.autoAdjust()
    
        
        titleView.snp_makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(WDConfig.mineTitleViewheight.autoAdjust())
            make.top.equalTo(topView.snp_bottom)
        }
    
        
        contentView.snp_makeConstraints { (make) in
            make.top.equalTo(titleView.snp_bottom)
            make.trailing.equalTo(self.view)
            make.leading.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        
        
        
        
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

extension MineViewController:IndicatorTitleViewDelegate{
    
    func indicatorTitleView(indicatorTitleView view: UIView, didSelectButton button: IndicatorButton, atIndex index: Int) {
        print("dggg \(index)")
    }


}
