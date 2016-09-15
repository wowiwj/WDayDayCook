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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("ffff")
    }
    
    

}

final class WDHUD: NSObject {
    
    // 单例对象
    static let shareInstance  = WDHUD()
   
    
    // 保存显示视图的字典
    lazy var containerViewDict = [String:UIView]()
    
    
    typealias ViewSetting = ((containerView:UIView)->Void)
    
    // 保存显示视图的设置的字典
    lazy var settingViewDict = [String:ViewSetting]()
    
    
 
    private func setContainerView(toView view:UIView,parentView:ViewSetting)
    {
//        parentView(containerView: getConentView(inView: view))
        // 保存当前的设置信息
        
        let str = getViewPointerString(view)
        settingViewDict[str] = parentView
        
        
//        print(settingViewDict)
    }
    
    private func getViewPointerString(view:UIView)->String{
    
        return NSValue(nonretainedObject: view).pointerValue.debugDescription
    }
    
    private func getConentView(inView view:UIView)->WDContainerView
    {
        let pointStr = getViewPointerString(view)
        
        guard let containerView = containerViewDict[pointStr] as? WDContainerView else{
        
            let containerView = WDContainerView()
            containerViewDict[pointStr] = containerView
            containerView.frame = view.bounds
            return containerView
        }
        return containerView
    
    }
    
    /// 添加自定义View
    
    class func setContainerView(parentView:ViewSetting){
        guard let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else{
            return
        }
        
        self.shareInstance.setContainerView(toView: appDelegate.window!, parentView: parentView)
    }

    
    class func setContainerView(toView view:UIView,parentView:ViewSetting){
    
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
        containerView.hidden = true
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
            containerView.hidden = false
            containerView.frame = view.bounds
            print(view.bounds)
            containerView.isShowing = true

            
            let pointStr = self.shareInstance.getViewPointerString(view)
            
            if let viewSetting = self.shareInstance.settingViewDict[pointStr]{
                viewSetting(containerView: containerView)
            
            }
            print(view.backgroundColor)
        }
    
    }
  

}


import SnapKit

extension WDHUD {
    class func showLoading(inView view:UIView)
    {
        dispatch_async(dispatch_get_main_queue()) {
            
            setContainerView(toView: view, parentView: { (containerView) in
                
                let image = UIImage(named: "loadingIcon~iphone")
        
                let view = UIView()
                view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
                var frame = CGRect(origin: CGPointZero, size: image!.size)
                let fit = 20.CGFloatValue()
                frame.size.height += fit
                view.frame = frame
                view.layer.cornerRadius = 5
                view.clipsToBounds = true
                
                containerView.addSubview(view)
                view.center = containerView.center
                containerView.userInteractionEnabled = false
                containerView.backgroundColor = UIColor.clearColor()
                
                let imageView = UIImageView(image: image)
                imageView.frame = CGRect(origin: CGPointZero, size: image!.size)
                imageView.startRotation()
                view.addSubview(imageView)
                
                
                let loadLabel = UILabel()
                loadLabel.textAlignment = .Center
                loadLabel.font = UIFont.systemFontOfSize(12)
                loadLabel.textColor = UIColor.whiteColor()
                loadLabel.text = "加载中..."
                let labelX = 0.CGFloatValue()
                let labelY = CGRectGetMaxY(imageView.frame)
                let labelH = view.frame.size.height - imageView.frame.size.height
                let labelW = imageView.frame.size.width
                
                loadLabel.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
                view.addSubview(loadLabel)
           
                
            })
            
            showInView(view)
        }
        
        
        
    }
    
    class func hideLoading(inView view:UIView)
    {
        hideInView(view)
    
    }



}
