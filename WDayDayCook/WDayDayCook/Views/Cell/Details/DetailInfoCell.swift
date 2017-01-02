//
//  DetailInfoCell.swift
//  WDayDayCook
//
//  Created by wangju on 16/7/30.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import JavaScriptCore

let showDetailVcNotificationKey = "showDetailVcNotification"
let showAllCommentNotificationKey = "showAllCommentNotification"
// 定义协议SwiftJavaScriptDelegate 该协议必须遵守JSExport协议
@objc protocol SwiftJavaScriptDelegate: JSExport {
    // js调用App方法时传递多个参数 并弹出对话框 注意js调用时的函数名
    // 第二个参数首字母大写 
    //showDetailVcId('linkRecipeDtl', id);
    func showDetailVc(_ title: String, id: Int)
    
    func showAllComment()
    
}

@objc class SwiftJavaScriptModel:NSObject,SwiftJavaScriptDelegate
{
    
    weak var controller: UIViewController?
    weak var jsContext: JSContext?
    
    func showDetailVc(_ title: String, id: Int) {
        
        print(title)
        print(id)
        
        if title == "linkRecipeDtl" {
            NotificationCenter.default.post(name: Notification.Name(rawValue: showDetailVcNotificationKey), object: id)
        }
        
    }
    
    func showAllComment() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: showAllCommentNotificationKey), object: nil)
        print("显示更多评论数据")
    }


}

class DetailInfoCell: UITableViewCell {

    var cellHeight:CGFloat = 0
    
    var loadFinished = false
    
    var loadFinishedAction:(()->Void)?
    
    var scrollEnabled:Bool = false{
   
        didSet{
            let oldHeight = cellHeight
            self.webView.scrollView.isScrollEnabled = scrollEnabled
            self.webView.sizeToFit()
            cellHeight = webView.scrollView.contentSize.height
            self.webView.scrollView.isScrollEnabled = false
            scrollEnabled = false
            if oldHeight == cellHeight {
                // 数据加载完，则不再加载
                return
            }
            
            if let action = loadFinishedAction {
                action()
            }
            
        
        }
    }
    
    var requestUrl:String?{
        
        willSet{
            if let _ = requestUrl {
                return
            }
        
        }
        
        didSet{
            
            guard let requestUrl = requestUrl else{
                return
            }
            
            let request = URLRequest(url: URL(string: requestUrl)!)
                
            webView.loadRequest(request)
            
        }
    }
    
    @IBOutlet weak var webView: UIWebView!{
        didSet{
            webView.delegate = self
            webView.scrollView.isScrollEnabled = false
            webView.stringByEvaluatingJavaScript(from: try! String(contentsOf: Bundle.main.url(forResource: "myJsf", withExtension: "js")!, encoding: String.Encoding.utf8))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension DetailInfoCell:UIWebViewDelegate
{
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.webView.sizeToFit()
        cellHeight = webView.scrollView.contentSize.height
    }
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
//        print(request.URL?.absoluteString)
//        print("_________________________")
        return true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.webView.sizeToFit()
        self.sizeToFit()
        cellHeight = webView.scrollView.contentSize.height
        
 
        loadFinished = true
        
        if let action = loadFinishedAction{
           
            action();
            
        }
        
        
        print(webView.request?.url?.absoluteString)
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: webViewLoadFinishedKey), object: nil)
        

        let context = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
        
        let model = SwiftJavaScriptModel()
        model.controller = UIApplication.shared.keyWindow?.rootViewController
        model.jsContext = context
        
        context.setObject(model, forKeyedSubscript: "WebViewJavascriptBridge" as (NSCopying & NSObjectProtocol)!)
        
        context.exceptionHandler = { (context, exception) in
            print("exception：", exception)
        }

    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(error)
    }

}

