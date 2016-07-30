//
//  ShowDetailViewController.swift
//  WDayDayCook
//
//  Created by wangju on 16/7/29.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class ShowDetailViewController: UIViewController {
    
    var id :Int!
    
    
    // Header
    lazy var headerView: DetailHeaderView = {
        
        let headerView = DetailHeaderView()
        headerView.frame = CGRect(x: 0, y: 0, width: 0, height: 300)
        
        return headerView
    }()
    
    @IBOutlet weak var tableView: UITableView!{
    
        didSet{
            tableView.tableHeaderView = headerView
            tableView.separatorStyle = .None
            
            tableView.delegate = self
            tableView.dataSource = self

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
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        
        print(id)
        loadData()
        

        // Do any additional setup after loading the view.
    }
    
    
    func makeUI()
    {
        view.addSubview(customNavgationBar)
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "back_icon~iphone"), forState: .Normal)
        backButton.sizeToFit()
        backButton.setImage(UIImage(named: "back_icon_on~iphone"), forState: .Highlighted)
        backButton.addTarget(self, action: #selector(backBarButtonClicked), forControlEvents: .TouchUpInside)
        let backItem = UIBarButtonItem(customView: backButton)
        customNavigationItem.leftBarButtonItem = backItem
        
        automaticallyAdjustsScrollViewInsets = false
 
        
    }
    
    // MARK: -  请求数据
    func loadData()
    {
        Alamofire.request(Router.Details(id: self.id)).responseJSON { (resopnse) in
            
            if resopnse.result.isFailure
            {
                print("请求失败")
            
            }
            
            let value = resopnse.result.value
            let result = JSON(value!)
            
            self.headerView.imageUrl = result["data"]["imageUrl"].stringValue
           print(result)
            
            
            
            
        }
        
        
        
    
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
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    
    // MARK: - 消息的监听
    @objc private func backBarButtonClicked()
    {
        
        self.navigationController?.popViewControllerAnimated(true)
    
    }

}


extension ShowDetailViewController :UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "666"
        cell.backgroundColor = UIColor.redColor()
        
        return cell
    }

    
    /// 下拉放大效果
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let minY: CGFloat = 0
        let offsetY = scrollView.contentOffset.y
        
        var frame = self.headerView.imageView.frame
        if offsetY < 0 {
            
            let deltaY = minY - offsetY
            frame.size.height = max(minY, CGRectGetHeight(self.headerView.bounds) + deltaY)
            frame.size.width = max(minY, CGRectGetWidth(self.headerView.bounds) + deltaY)
            frame.origin.x = -deltaY * 0.5
            frame.origin.y = CGRectGetMinX(frame) - deltaY * 0.5
            self.headerView.imageView.frame = frame
        }

    }

}
