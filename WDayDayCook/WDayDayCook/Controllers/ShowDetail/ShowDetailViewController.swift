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
    case title
    case detail
}

let DetailTitleViewCellID = "DetailTitleViewCell"
let DetailInfoCellID = "DetailInfoCell"
let webViewLoadFinishedKey = "webViewLoadFinishedNotificationKey"


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
            tableView.separatorStyle = .none
            
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.estimatedRowHeight = 600
//            tableView.rowHeight = UITableViewAutomaticDimension
//            tableView.rowHeight = 300
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)
            tableView.scrollIndicatorInsets = tableView.contentInset
            
            tableView.register(UINib(nibName: DetailTitleViewCellID, bundle: nil), forCellReuseIdentifier: DetailTitleViewCellID)
            tableView.register(UINib(nibName: DetailInfoCellID, bundle: nil), forCellReuseIdentifier: DetailInfoCellID)
            
        }
    }
    
    var webCell:DetailInfoCell?
    

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
    
    fileprivate lazy var scrollTopButton:UIButton = {
    
        let button = UIButton()
        button.setImage(UIImage(named: "upupupIcon~iphone"), for: UIControlState())
        button.isHidden = true
        button.addTarget(self, action: #selector(scrollButtonClicked), for: .touchUpInside)
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
                self.headerView.videoButton.isHidden = result["data"]["detailsUrl"].stringValue.isEmpty
                tableView.reloadData()
            }
        }
    }
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ShowDetailViewController.showDetailVC(_:)), name: NSNotification.Name(rawValue: showDetailVcNotificationKey), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ShowDetailViewController.showMoreComments(_:)), name: NSNotification.Name(rawValue: showAllCommentNotificationKey), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ShowDetailViewController.webViewLoadFinished), name: NSNotification.Name(rawValue: webViewLoadFinishedKey), object: nil)
        
        loadData()
        
        WDHUD.showLoading(inView: self.view)
        view.isUserInteractionEnabled = false
        

        // Do any additional setup after loading the view.
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    
    }
    
    
    func makeUI()
    {
        view.addSubview(customNavgationBar)
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "back_icon~iphone"), for: UIControlState())
        backButton.sizeToFit()
        backButton.setImage(UIImage(named: "back_icon_on~iphone"), for: .highlighted)
        backButton.addTarget(self, action: #selector(backBarButtonClicked), for: .touchUpInside)
        let backItem = UIBarButtonItem(customView: backButton)
        customNavigationItem.leftBarButtonItem = backItem
        
        automaticallyAdjustsScrollViewInsets = false
        
        
        // 添加底部的tabbar
        
        let tabbar = DetailTabbar()

        self.view.addSubview(tabbar)
        tabbar.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view)
            make.width.equalTo(self.view)
            make.height.equalTo(44)
        }
        
        view.addSubview(scrollTopButton)
        scrollTopButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(tabbar.snp.top).offset(-20)
            make.trailing.equalTo(self.view).offset(-20)
        }

        
    }
    
    // MARK: -  请求数据
    func loadData()
    {
        Alamofire.request(Router.details(id: self.id)).responseJSON { (resopnse) in
//            WDHUD.hideLoading(inView: self.tableView)
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

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    
    // MARK: - 消息的监听
    @objc fileprivate func backBarButtonClicked()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func scrollButtonClicked()
    {
        
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)

        tableView.setContentOffset(CGPoint.zero, animated: true)

    }
    
    @objc fileprivate func showDetailVC(_ info:Notification){
        if let id = info.object {
            let item = id as! Int
            navigationController?.pushToDetailViewController(item, animated: true)
   
        }
    }
    @objc fileprivate func showMoreComments(_ info:Notification){
        WDAlert.alert(title: "显示更多评论", message: "点击了显示更多评论按钮", dismissTitle: "取消", inViewController: self, withDismissAction: nil)
    }
    
    @objc fileprivate func webViewLoadFinished()
    {
        
        print("webViewLoadFinished")
        WDHUD.hideLoading(inView: self.view)
        view.isUserInteractionEnabled = true
    
    
    }

}


extension ShowDetailViewController :UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch (indexPath as NSIndexPath).row {
        case DetailCellStyle.title.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailTitleViewCellID)
            return cell!
        case DetailCellStyle.detail.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailInfoCellID) as! DetailInfoCell
            if let result = result
            {
                cell.requestUrl = result["data"]["loadContent"].stringValue
                webCell = cell
                cell.loadFinishedAction = { [unowned self] in
                    self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
                }
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let result = result else{
            return
        }
        
        
        switch (indexPath as NSIndexPath).row {
        case DetailCellStyle.title.rawValue:
            let cell = cell as! DetailTitleViewCell
            cell.nameLabel.text = result["data"]["name"].stringValue
            let maketime = " \(result["data"]["maketime"])"
            cell.makeTimeButton.setTitle(maketime, for: UIControlState())
            cell.makeTimeButton.isHidden = (maketime == " ")
            if maketime == " " {
                cell.makeTimeButton.setImage(UIImage(), for: UIControlState())
                cell.makeTimeButton.layoutIfNeeded()
            }
            let clickCount = " \(result["data"]["clickCount"].stringValue)"
            cell.clickCountButton.setTitle(clickCount, for: UIControlState())
   
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch (indexPath as NSIndexPath).row {
        case DetailCellStyle.title.rawValue:
            return WDConfig.cellTitleViewHeight
        case DetailCellStyle.detail.rawValue:
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

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        /// 下拉放大效果
        
        let minY: CGFloat = 0
        let offsetY = scrollView.contentOffset.y

        var frame = self.headerView.imageView.frame
        if offsetY < 0 {
            
            let deltaY = minY - offsetY
            frame.size.height = max(minY, self.headerView.bounds.height + deltaY)
            frame.size.width = max(minY, self.headerView.bounds.width + deltaY)
            frame.origin.x = -deltaY * 0.5
            frame.origin.y = frame.minX - deltaY * 0.5
            self.headerView.imageView.frame = frame
        }
        
//         加载更多
        
        let value1 = scrollView.contentOffset.y + UIScreen.main.bounds.height
        let value2 = scrollView.contentSize.height + tableView.contentInset.bottom

        
        if value1 == value2 {
            webCell?.scrollEnabled = true
        }
        
        scrollTopButton.isHidden = offsetY < UIScreen.main.bounds.size.height
    }

}

extension ShowDetailViewController: DetailHeaderViewDelegate
{
    
    func videoButtonClicked(_ detailsUrl: String?,id:Int?) {
        
        if let url = detailsUrl,let id = id {
            let moreUrl = ServiceApi.getVideosDetail(id)
            
            Alamofire.request(Router.videosDetail(id: id)).responseJSON(completionHandler: { [unowned self] response in
                
                
                func playBaseVideo()
                {
                    let player = VVSDKPlayerViewController(url: url, videoType: 1, localVideoTitle: "")
                    player?.setEnableBubble(false)
                    //            player.setIsLive(false)
                    self.present(player!, animated: true, completion: nil)
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
                    player?.setEnableBubble(false)
                    //            player.setIsLive(false)
                    self.present(player!, animated: true, completion: nil)
                }else{
                    
                    playBaseVideo()
                    
                }

                print(json)

                })
            
        }
        print(detailsUrl)
    }
    
}
