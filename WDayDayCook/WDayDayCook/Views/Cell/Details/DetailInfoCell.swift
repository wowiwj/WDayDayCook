//
//  DetailInfoCell.swift
//  WDayDayCook
//
//  Created by wangju on 16/7/30.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit

class DetailInfoCell: UITableViewCell {

    var cellHeight:CGFloat = 0
    
    var loadFinished = false
    
    var loadFinishedAction:(()->Void)?
    
    var scrollEnabled:Bool = false{
   
        didSet{
            let oldHeight = cellHeight
            self.webView.scrollView.scrollEnabled = scrollEnabled
            self.webView.sizeToFit()
            cellHeight = webView.scrollView.contentSize.height
            self.webView.scrollView.scrollEnabled = false
            scrollEnabled = false
            if oldHeight == cellHeight {
                return
            }
            
            if let action = loadFinishedAction {
                action()
            }
            
        
        }
    }
    
    var requestUrl:String?{
        didSet{
            
            if loadFinished {
                return
            }
        
            if let requestUrl = requestUrl
            {
                let request = NSURLRequest(URL: NSURL(string: requestUrl)!)
                
                webView.loadRequest(request)
            }
        }

    }
    
    @IBOutlet weak var webView: UIWebView!
    override func awakeFromNib() {
        super.awakeFromNib()
        webView.delegate = self
        webView.scrollView.scrollEnabled = false
       
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension DetailInfoCell:UIWebViewDelegate
{
    func webViewDidStartLoad(webView: UIWebView) {
        self.webView.sizeToFit()
        cellHeight = webView.scrollView.contentSize.height
        print(cellHeight)
    }
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
//        if self.loadFinished {
//            return false
//        }
        
        print("---------------------------")
        
        return true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.webView.sizeToFit()
        self.sizeToFit()
        cellHeight = webView.scrollView.contentSize.height
        loadFinished = true
        
        if let action = loadFinishedAction {
            action()
        }
        
        print("9999999")

        print(cellHeight)
    }
    
    
    
    


}

extension DetailInfoCell: UIScrollViewDelegate
{
//    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
//        print("11111")
//    }


}
