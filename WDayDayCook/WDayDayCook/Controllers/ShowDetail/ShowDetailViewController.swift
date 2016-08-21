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
import SnapKit

enum DetailCellStyle: Int {
    case Title
    case Detail
}

let DetailTitleViewCellID = "DetailTitleViewCell"
let DetailInfoCellID = "DetailInfoCell"


class ShowDetailViewController: UIViewController {
    
    var id :Int!
    
    
    // Header
    lazy var headerView: DetailHeaderView = {
        
        let headerView = DetailHeaderView()
        headerView.frame = CGRect(x: 0, y: 0, width: 0, height: 300)
         headerView.delegate = self
        return headerView
    }()
    
    @IBOutlet weak var tableView: UITableView!{
    
        didSet{
            tableView.tableHeaderView = headerView
            tableView.separatorStyle = .None
            
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.estimatedRowHeight = 600
//            tableView.rowHeight = UITableViewAutomaticDimension
//            tableView.rowHeight = 300
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)
            tableView.scrollIndicatorInsets = tableView.contentInset
            
            tableView.registerNib(UINib(nibName: DetailTitleViewCellID, bundle: nil), forCellReuseIdentifier: DetailTitleViewCellID)
            tableView.registerNib(UINib(nibName: DetailInfoCellID, bundle: nil), forCellReuseIdentifier: DetailInfoCellID)
            
        }
    }
    
    var webCell:DetailInfoCell?
    

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
    
    private lazy var scrollTopButton:UIButton = {
    
        let button = UIButton()
        button.setImage(UIImage(named: "upupupIcon~iphone"), forState: .Normal)
        button.hidden = true
        button.addTarget(self, action: #selector(scrollButtonClicked), forControlEvents: .TouchUpInside)
        return button
    
    }()
    
    var result:JSON?{
        didSet{
            if let result = result
            {
                print(result)
                self.headerView.imageUrl = result["data"]["imageUrl"].stringValue
                self.headerView.detailsUrl = result["data"]["detailsUrl"].stringValue
                self.headerView.id = result["data"]["id"].intValue
                self.headerView.videoButton.hidden = result["data"]["detailsUrl"].stringValue.isEmpty
                tableView.reloadData()
            }
        }
    }
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ShowDetailViewController.ShowDetailVC(_:)), name: showDetailVcNotificationKey, object: nil)
        
        loadData()
        

        // Do any additional setup after loading the view.
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    
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
        
        
        // 添加底部的tabbar
        
        let tabbar = DetailTabbar()

        self.view.addSubview(tabbar)
        tabbar.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.view)
            make.width.equalTo(self.view)
            make.height.equalTo(44)
        }
        
        view.addSubview(scrollTopButton)
        scrollTopButton.snp_makeConstraints { (make) in
            make.bottom.equalTo(tabbar.snp_top).offset(-20)
            make.trailing.equalTo(self.view).offset(-20)
        }

        
    }
    
    // MARK: -  请求数据
    func loadData()
    {
        Alamofire.request(Router.Details(id: self.id)).responseJSON { (resopnse) in
            
            if resopnse.result.isFailure
            {
                print("请求失败")
                return
            
            }
            
            let value = resopnse.result.value
            let result = JSON(value!)
            
            self.result = result
    
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
    
    @objc private func scrollButtonClicked()
    {
        
        tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)

        tableView.setContentOffset(CGPointZero, animated: true)

    }
    
    @objc private func ShowDetailVC(info:NSNotification){
        if let id = info.object {
            let item = id as! Int
            navigationController?.pushToDetailViewController(item, animated: true)
   
        }
    }

}


extension ShowDetailViewController :UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case DetailCellStyle.Title.rawValue:
            let cell = tableView.dequeueReusableCellWithIdentifier(DetailTitleViewCellID)
            return cell!
        case DetailCellStyle.Detail.rawValue:
            let cell = tableView.dequeueReusableCellWithIdentifier(DetailInfoCellID) as! DetailInfoCell
            if let result = result
            {
                cell.requestUrl = result["data"]["loadContent"].stringValue
                webCell = cell
                cell.loadFinishedAction = { [unowned self] in
                    self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .None)
                }
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let result = result else{
            return
        }
        
        
        switch indexPath.row {
        case DetailCellStyle.Title.rawValue:
            let cell = cell as! DetailTitleViewCell
            cell.nameLabel.text = result["data"]["name"].stringValue
            let maketime = " \(result["data"]["maketime"])"
            cell.makeTimeButton.setTitle(maketime, forState: .Normal)
            cell.makeTimeButton.hidden = (maketime == " ")
            if maketime == " " {
                cell.makeTimeButton.setImage(UIImage(), forState: .Normal)
                cell.makeTimeButton.layoutIfNeeded()
            }
            let clickCount = " \(result["data"]["clickCount"].stringValue)"
            cell.clickCountButton.setTitle(clickCount, forState: .Normal)
   
        default:
            return
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        switch indexPath.row {
        case DetailCellStyle.Title.rawValue:
            return WDConfig.cellTitleViewHeight
        case DetailCellStyle.Detail.rawValue:
            if let cell = webCell
            {
                print(cell.cellHeight)
                return cell.cellHeight
                
            }
        default:
            return 0
        }
        return 0
    }

    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        /// 下拉放大效果
        
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
        
//         加载更多
        
        let value1 = scrollView.contentOffset.y + UIScreen.mainScreen().bounds.height
        let value2 = scrollView.contentSize.height + tableView.contentInset.bottom

        
        if value1 == value2 {
            webCell?.scrollEnabled = true
        }
        
        scrollTopButton.hidden = offsetY < UIScreen.mainScreen().bounds.size.height
    }

}

extension ShowDetailViewController: DetailHeaderViewDelegate
{
    
    func videoButtonClicked(detailsUrl: String?,id:Int?) {
        
        if let url = detailsUrl,id = id {
            let moreUrl = ServiceApi.getVideosDetail(id)
            
            Alamofire.request(Router.VideosDetail(id: id)).responseJSON(completionHandler: { [unowned self] response in
                
                
                func playBaseVideo()
                {
                    let player = VVSDKPlayerViewController(url: url, videoType: 1, localVideoTitle: "")
                    player.setEnableBubble(false)
                    //            player.setIsLive(false)
                    self.presentViewController(player, animated: true, completion: nil)
                    return
                    
                }
                
                if response.result.isFailure
                {
                    playBaseVideo()
                }
                
                let value = response.result.value
                let json = JSON(value!)
                
                if json["code"].intValue == 200
                {
                    //                    playBaseVideo()
                    
                    let player = VVSDKPlayerViewController(url: moreUrl, videoType: 2, localVideoTitle: "")
                    player.setEnableBubble(false)
                    //            player.setIsLive(false)
                    self.presentViewController(player, animated: true, completion: nil)
                }else{
                    
                    playBaseVideo()
                    
                }

                print(json)

                })
            
        }
        print(detailsUrl)
    }
    
}
