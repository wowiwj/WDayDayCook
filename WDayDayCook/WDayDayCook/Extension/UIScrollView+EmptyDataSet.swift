//
//  UIScrollView+EmptyDataSet.swift
//  WDayDayCook
//
//  Created by wangju on 16/8/21.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import ObjectiveC


/*

@objc protocol EmptyDataSetDelegate:NSObjectProtocol{
    
    optional func emptyDataSetDidAppear(scrollView:UIScrollView)
    optional func emptyDataSetWillDisappear(scrollView:UIScrollView)
    optional func emptyDataSetDidDisappear(scrollView:UIScrollView)
    
}

@objc protocol EmptyDataSetDataSourceSource:NSObjectProtocol{
    
}


class WeakObjectContainer: NSObject{
    weak var weakObject:AnyObject?
    init(weakObject:AnyObject)
    {
        super.init()
        self.weakObject = weakObject
    }

}

//class EmptyDataSetView: UIView {
//    
//    lazy var contentView:UIView = {
//        
//        let contentView = UIView()
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.backgroundColor = UIColor.greenColor()
//        contentView.userInteractionEnabled = true
//        return contentView
//    }()
//    
//    lazy var titleLabel:UILabel? = {
//        
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.systemFontOfSize(27)
//        label.textColor = UIColor(white: 0.6, alpha: 1.0)
//        label.textAlignment = .Center
//        label.lineBreakMode = .ByWordWrapping
//        label.numberOfLines = 0
//        label.accessibilityIdentifier = "empty set title"
//        self.contentView.addSubview(label)
//        return label
//    
//    }()
//    
//    lazy var detailLabel:UILabel? = {
//        
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = UIColor.clearColor()
//        label.font = UIFont.systemFontOfSize(17)
//        label.textColor = UIColor(white: 0.6, alpha: 1.0)
//        label.textAlignment = .Center
//        label.lineBreakMode = .ByWordWrapping
//        label.numberOfLines = 0
//        label.accessibilityIdentifier = "empty set detail label"
//        self.contentView.addSubview(label)
//        return label
//        
//    }()
//    
//    lazy var button:UIButton? = {
//        
//        let button = UIButton(type: UIButtonType.Custom)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = UIColor.clearColor()
//        button.contentHorizontalAlignment = .Center
//        button.contentVerticalAlignment = .Center
//        button.accessibilityIdentifier = "empty set button"
//        
//        button.addTarget(self, action: #selector(EmptyDataSetView.didTapButton(_:)), forControlEvents: .TouchUpInside)
//        self.contentView.addSubview(button)
//        return button
//        
//    }()
//    
//    var imageView:UIImageView?
//    
//    var canShowImage:Bool
//    {
//        guard let _ = imageView?.image,_ = imageView?.superview else{
//            return false
//        }
//        return true
//    }
//    var canShowTitle:Bool
//    {
//        guard let _ = titleLabel?.superview else{
//            return false
//        }
//        return !(titleLabel!.attributedText?.string.isEmpty ?? false)
//    }
//    var canShowDetail:Bool
//    {
//        guard let _ = detailLabel?.superview else{
//            return false
//        }
//        return !(detailLabel!.attributedText?.string.isEmpty ?? false)
//    }
//    var canShowButton:Bool
//    {
//        
//        if button?.attributedTitleForState(.Normal)?.string.isEmpty == false
//        {
//            if let _ = button?.imageForState(.Normal),_ = button?.superview {
//                return true
//            }
//            
//        }
//        return false
//    }
//    
//    var customView:UIView?{
//        
//        set {
//            guard let _ = newValue else{
//                return
//            }
//            
//            if let _ = customView {
//                customView?.removeFromSuperview()
//                self.customView = nil
//            }
//            
//            self.customView = newValue
//            customView?.translatesAutoresizingMaskIntoConstraints = false
//            self.contentView.addSubview(customView!)
//        }
//        
//        get{
//            return contentView
//        }
//    }
//    
//    // MARK: - Action Methods
//    @objc func didTapButton(sender:AnyObject)
//    {
//    
//    
//    }
//    
//    private func prepareForReuse()
//    {
//        contentView.subviews.forEach {$0.removeFromSuperview()}
//        self.titleLabel = nil
//        self.detailLabel = nil
//        self.imageView = nil
//        self.button = nil
//        self.customView = nil
//        
//        removeAllConstraints()
//   
//    }
//    
//    private func removeAllConstraints()
//    {
//        self.removeConstraints(self.constraints)
//        contentView.removeConstraints(contentView.constraints)
//    }
//}


extension UITextView {
    
    struct AssociatedKeys {
        static var ContenerViewKey:UInt32 = 0
        static var EmptyDataSetDelegateKey:UInt32 = 0
        static var EmptyDataSetDataSourceSourceKey:UInt32 = 0
    }
    
//    var contenerView:EmptyDataSetView?{
//        get {
//            return objc_getAssociatedObject(self, &AssociatedKeys.ContenerViewKey) as? EmptyDataSetView
//
//        }
//        
//        set {
//            objc_setAssociatedObject(self, &AssociatedKeys.ContenerViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
    
    var emptyDataSetDelegate:EmptyDataSetDelegate?{
    
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.EmptyDataSetDelegateKey) as? EmptyDataSetDelegate
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.EmptyDataSetDelegateKey, WeakObjectContainer(weakObject: newValue!).weakObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var emptyDataSetDataSource:EmptyDataSetDataSourceSource?{
        
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.EmptyDataSetDataSourceSourceKey) as? EmptyDataSetDataSourceSource
        }
        set {
            if let _ = self.emptyDataSetDataSource {
                if wj_canDisplay() {
                    wj_invalidate()
                }
            }
            objc_setAssociatedObject(self, &AssociatedKeys.EmptyDataSetDataSourceSourceKey, WeakObjectContainer(weakObject: newValue!).weakObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            swizzleIfPossible(#selector(UITableView.reloadData))
            
            
            
        }
        
    }
    
    // MARK: - 内部私有方法
    
    private func wj_canDisplay() -> Bool {
        if let datasource = self.emptyDataSetDataSource {
            if datasource.conformsToProtocol(EmptyDataSetDataSourceSource)
            {
                return self.isKindOfClass(UITableView)
                    || self.isKindOfClass(UICollectionView)
                    || self.isKindOfClass(UIScrollView)
   
            }
        }

        return false
    }
    
    private func wj_invalidate(){
        wj_willDisappear()
        
//        if let contenerView = contenerView {
////            contenerView.prepareForReuse()
//            contenerView.removeFromSuperview()
//            self.contenerView = nil
//        }
        self.scrollEnabled = true
        wj_didDisappear()
    }
    
    private func wj_willDisappear(){
    
        
        if let emptyDataSetDelegate = emptyDataSetDelegate {
            if emptyDataSetDelegate.respondsToSelector(#selector(emptyDataSetDelegate.emptyDataSetWillDisappear(_:))) {
                emptyDataSetDelegate.emptyDataSetWillDisappear!(self)
            }
        }
    }
    
    private func wj_didDisappear(){
        
        
        if let emptyDataSetDelegate = emptyDataSetDelegate {
            if emptyDataSetDelegate.respondsToSelector(#selector(emptyDataSetDelegate.emptyDataSetDidDisappear(_:))) {
                emptyDataSetDelegate.emptyDataSetDidDisappear!(self)
            }
        }
    }
    // MARK: - Reload APIs

    @objc private func wj_reloadEmptyDataSet()
    {
        print("quw7tr5qwgtrjhwbgtiuw4thhhhhhhhh")
    
    }
    

    // MARK: - Method Swizzling
    
    struct MethodSwizzling {
        static var mpLookupTable:[String:[String:AnyObject]] = [String:[String:AnyObject]]()
        static let InfoPointerKey = "pointer"
        static let InfoOwnerKey = "owner"
        static let InfoSelectorKey = "selector"
    }

    

    private func swizzleIfPossible(selector:Selector)
    {
        
        print("6666666")
        if !self.respondsToSelector(selector){
            return
        }
        print("7777777")
        
        for info in MethodSwizzling.mpLookupTable.values {
            let aClass = info[MethodSwizzling.InfoOwnerKey]
            let selectorName = info[MethodSwizzling.InfoSelectorKey] as? String
            
            guard let classType = aClass as? AnyClass else{
                continue
            }
            if selectorName == NSStringFromSelector(selector) {
                if isKindOfClass(classType) {
                    return
                }
            }
            
            print(info)
            
        }
        print(MethodSwizzling.mpLookupTable)
    
        guard let baseClass = wj_baseClassToSwizzleForTarget(self),key = wj_implementationKey(baseClass, selector: selector) else {
            return
        }
        let impValue = MethodSwizzling.mpLookupTable[key]?[MethodSwizzling.InfoPointerKey]
        guard let _ = impValue else{
            return
        }
        
        
        _ = class_getInstanceMethod(baseClass, selector)
//        let wj_newImplementation = method_setImplementation(method,IMP(wj_original_implementation))
        
        // 好麻烦，放弃这种思路了
        
      
        
        
        
    
    }
    
    private func wj_original_implementation(cls: AnyClass!, _ name: Selector){
        guard let baseClass = wj_baseClassToSwizzleForTarget(self),key = wj_implementationKey(baseClass, selector: name) else {
            return
        }
        let impValue = MethodSwizzling.mpLookupTable[key]?[MethodSwizzling.InfoPointerKey]
        
        wj_reloadEmptyDataSet()
        guard let _ = impValue else{
            return
        }
        let imp = impValue!.pointerValue
         print(imp)
        
        
      
        

    
    }
    
    private func wj_baseClassToSwizzleForTarget(target:AnyObject) -> AnyClass?{
        if target.isKindOfClass(UITableView) {
            return UITableView.self
        }
        if target.isKindOfClass(UICollectionView) {
            return UICollectionView.self
        }
        if target.isKindOfClass(UIScrollView) {
            return UIScrollView.self
        }
        return nil
    }
    
    private func wj_implementationKey(aClass:AnyClass?,selector:Selector?)->String?
    {
        guard let _ = aClass,_ = selector else{
            return nil
        }
        
        let className = NSStringFromClass(aClass!)
        let selectorName = NSStringFromSelector(selector!)
        return "\(className)_\(selectorName)"
    }
    
    
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

*/
