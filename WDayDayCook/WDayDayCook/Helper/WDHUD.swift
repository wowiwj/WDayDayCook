//
//  WDHUD.swift
//  WDayDayCook
//
//  Created by wangju on 16/9/14.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit


/// 填充视图
class WDContainerView:UIView {
    
    var isShowing = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

final class WDHUD: NSObject {
    
    // 单例对象
    static let shareInstance  = WDHUD()
   
    
    // 保存显示视图的字典
    lazy var containerViewDict = [String:UIView]()
    
    
    
    private func setContainerView(toView view:UIView,parentView:(containerView:UIView)->())
    {
        parentView(containerView: getConentView(inView: view))

    }
    
    private func getConentView(inView view:UIView)->WDContainerView
    {
        guard let containerView = containerViewDict[view.description] as? WDContainerView else{
        
            let containerView = WDContainerView()
            containerViewDict[view.description] = containerView
            view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
            print(containerView)
            return containerView
        }
        return containerView
    
    }
    
    /// 添加自定义View
    
    class func setContainerView(parentView:(containerView:UIView)->()){
        guard let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else{
            return
        }
        
        self.shareInstance.setContainerView(toView: appDelegate.window!, parentView: parentView)
    }

    
    class func setContainerView(toView view:UIView,parentView:(containerView:UIView)->()){
    
        self.shareInstance.setContainerView(toView: view, parentView: parentView)
    }

    /// 默认在window显示view
    class func showView(){
        
        dispatch_async(dispatch_get_main_queue()) { 
            
            guard let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else{
                return
            }
            showInView(appDelegate.window)
        }
    }
    /// 默认在window影藏view
    class func hideView(){
        
        dispatch_async(dispatch_get_main_queue()) {
            
            guard let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else{
                return
            }
            hideInView(appDelegate.window)
        }
        
        
    }
    
    /// 在特定的窗口显影藏HUD
    class func hideInView(view:UIView?){
        guard let view = view else{
            return
        }
        
        let containerView =  self.shareInstance.getConentView(inView: view)
        if !containerView.isShowing {
            return
        }
        containerView.isShowing = false
        containerView.removeFromSuperview()
    }
    
    /// 在特定的窗口显示HUD
    class func showInView(view:UIView?)
    {
        guard let view = view else{
            return
        }
        
        let containerView =  self.shareInstance.getConentView(inView: view)
        if containerView.isShowing {
            return
        }
        
        print("添加")
        
        // 此处可能存在多个containerView，一个collectionView无法满足要求
        dispatch_async(dispatch_get_main_queue()) {
    
            view.addSubview(containerView)
            containerView.frame = view.bounds
            containerView.isShowing = true
        }
    
    
    }
  

}
