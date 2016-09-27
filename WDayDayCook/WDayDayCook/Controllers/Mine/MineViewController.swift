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
    fileprivate lazy var customNavigationItem: UINavigationItem = UINavigationItem(title: "")
    
    fileprivate lazy var customNavgationBar:UINavigationBar = {
        
        let bar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 64))
        bar.setItems([self.customNavigationItem], animated: false)
        
        bar.backgroundColor = UIColor.clear
        bar.isTranslucent = true
        bar.shadowImage = UIImage()
        bar.barStyle = UIBarStyle.blackTranslucent
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        return bar
        
    }()
    
    // 显示标题 我的收藏 与 足迹的View
    fileprivate lazy var titleView:IndicatorTitleView = {
    
        let view = IndicatorTitleView()
        self.view.addSubview(view)
        view.titles = ["我的收藏","我的足迹"]
        view.setTitlesColor(UIColor.WD_MineTitleDefaultColor(), forState: UIControlState())
        view.setTitlesColor(UIColor.orange, forState: UIControlState.selected)
        view.titleLabelsFont = UIFont.systemFont(ofSize: 15.autoAdjust())
        return view
    }()
    
    // 显示详细内容的View
    fileprivate lazy var contentView:UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.yellow
        
        self.view.addSubview(view)
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        titleView.delegate = self
        addChildViewControllers()
        titleView.setTitleSelectIndex(0)
        
//        WDHUD.showLoading(inView: self.view)
        

        // Do any additional setup after loading the view.
    }
    
    func makeUI()
    {
        view.addSubview(customNavgationBar)
        let setButton = UIButton()
        setButton.setImage(UIImage(named: "iPhone_personal_set_btn~iphone"), for: UIControlState())
        setButton.sizeToFit()
        setButton.addTarget(self, action: #selector(MineViewController.setBarButtonClicked), for: .touchUpInside)
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
    
    func addChildViewControllers(){
        
        let waterFlowlayout = UICollectionViewFlowLayout()
        
        let mineCollectionVc = MineCollectionontroller(collectionViewLayout: waterFlowlayout)
        addChildViewController(mineCollectionVc)
        
        let footPrintsVc = MineFootPrintsViewController(collectionViewLayout: waterFlowlayout)
        addChildViewController(footPrintsVc)

    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.setNeedsStatusBarAppearanceUpdate()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.setNeedsStatusBarAppearanceUpdate()
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
    @objc fileprivate func setBarButtonClicked()
    {
   
//        let selectedVc = childViewControllers[self.titleView.selectedIndex]
//        
//        if self.titleView.selectedIndex == 0 {
//            (selectedVc as! MineCollectionontroller).showHUB()
//        }
//        
//        if self.titleView.selectedIndex == 1 {
//            (selectedVc as! MineFootPrintsViewController).showHUB()
//        }
        
        let settingVc = SettngViewController()
        
        settingVc.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(settingVc, animated: true)
      
        
        
        
    }


    @IBAction func loginButtonClicked(_ sender: UIButton) {
     
        
        let selectedVc = childViewControllers[self.titleView.selectedIndex]
        
        if self.titleView.selectedIndex == 0 {
            (selectedVc as! MineCollectionontroller).hideHUB()
        }
        
        if self.titleView.selectedIndex == 1 {
            (selectedVc as! MineFootPrintsViewController).hideHUB()
        }
        
    }
}

extension MineViewController:IndicatorTitleViewDelegate{
    
    func indicatorTitleView(indicatorTitleView view: UIView, didSelectButton button: IndicatorButton, atIndex index: Int) {
    
        let selectedVc = childViewControllers[index]
        
        print(selectedVc)
        selectedVc.view.frame = contentView.bounds
        contentView.addSubview(selectedVc.view)
  
    }


}
