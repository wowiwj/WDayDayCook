//
//  UITableView+EmptyDataSet.swift
//  WDayDayCook
//
//  Created by wangju on 16/8/22.
//  Copyright © 2016年 wangju. All rights reserved.
//


/*
import UIKit

class EmptyDataSetView: UIView {
    
    lazy var contentView:UIView = {
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor.greenColor()
        contentView.userInteractionEnabled = true
        return contentView
    }()
    
    lazy var titleLabel:UILabel? = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFontOfSize(27)
        label.textColor = UIColor(white: 0.6, alpha: 1.0)
        label.textAlignment = .Center
        label.lineBreakMode = .ByWordWrapping
        label.numberOfLines = 0
        label.accessibilityIdentifier = "empty set title"
        self.contentView.addSubview(label)
        return label
        
    }()
    
    lazy var detailLabel:UILabel? = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clearColor()
        label.font = UIFont.systemFontOfSize(17)
        label.textColor = UIColor(white: 0.6, alpha: 1.0)
        label.textAlignment = .Center
        label.lineBreakMode = .ByWordWrapping
        label.numberOfLines = 0
        label.accessibilityIdentifier = "empty set detail label"
        self.contentView.addSubview(label)
        return label
        
    }()
    
    lazy var button:UIButton? = {
        
        let button = UIButton(type: UIButtonType.Custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.clearColor()
        button.contentHorizontalAlignment = .Center
        button.contentVerticalAlignment = .Center
        button.accessibilityIdentifier = "empty set button"
        
        button.addTarget(self, action: #selector(EmptyDataSetView.didTapButton(_:)), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(button)
        return button
        
    }()
    
    var imageView:UIImageView?
    
    var canShowImage:Bool
    {
        guard let _ = imageView?.image,_ = imageView?.superview else{
            return false
        }
        return true
    }
    var canShowTitle:Bool
    {
        guard let _ = titleLabel?.superview else{
            return false
        }
        return !(titleLabel!.attributedText?.string.isEmpty ?? false)
    }
    var canShowDetail:Bool
    {
        guard let _ = detailLabel?.superview else{
            return false
        }
        return !(detailLabel!.attributedText?.string.isEmpty ?? false)
    }
    var canShowButton:Bool
    {
        
        if button?.attributedTitleForState(.Normal)?.string.isEmpty == false
        {
            if let _ = button?.imageForState(.Normal),_ = button?.superview {
                return true
            }
            
        }
        return false
    }
    
    var customView:UIView?{
        
        set {
            guard let _ = newValue else{
                return
            }
            
            if let _ = customView {
                customView?.removeFromSuperview()
                self.customView = nil
            }
            
            self.customView = newValue
            customView?.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(customView!)
        }
        
        get{
            return contentView
        }
    }
    
    // MARK: - Action Methods
    @objc func didTapButton(sender:AnyObject)
    {
        
        
    }
    
    private func prepareForReuse()
    {
        contentView.subviews.forEach {$0.removeFromSuperview()}
        self.titleLabel = nil
        self.detailLabel = nil
        self.imageView = nil
        self.button = nil
        self.customView = nil
        
        removeAllConstraints()
        
    }
    
    private func removeAllConstraints()
    {
        self.removeConstraints(self.constraints)
        contentView.removeConstraints(contentView.constraints)
    }
}

class MakeEmptyDataSet{
    var emptyDataSetView:EmptyDataSetView?
    func title(title:NSAttributedString)->MakeEmptyDataSet{
    
        return self
    }
    var title:NSAttributedString?{
        didSet{
        
        }
    }
    
    var description:NSAttributedString?{
        didSet{
            
        }
    }
    var image:UIImage?{
        didSet{
            
        }
    }
    var imageTintColor:UIColor?{
        didSet{
            
        }
    }
    var imageAnimation:CAAnimation?{
        didSet{
            
        }
    }
    
    func buttonTitle(title:String?,state:UIControlState)->MakeEmptyDataSet
    {
        
        return self
    }
    func buttonBackgroundImage(image:UIImage?,state:UIControlState)->MakeEmptyDataSet
    {
        
        return self
    }
    
    var backgroundColor:UIColor?{
        didSet{
            
        }
    }
 
}

extension  UITableView {
    struct AssociatedKeys {
        static var ContenerViewKey:UInt32 = 0
        static var CustomerViewKey:UInt32 = 0
        static var EmptyDataSetDelegateKey:UInt32 = 0
    }
    
    var contenerView:EmptyDataSetView?{
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ContenerViewKey) as? EmptyDataSetView
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.ContenerViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var customerView:EmptyDataSetView?{
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ContenerViewKey) as? EmptyDataSetView
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.ContenerViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addEmptyDataSetView(emptyDataSet:(set:MakeEmptyDataSet)->()) {
        
        if let customerView = customerView {
            customerView.removeAllConstraints()
            customerView.removeFromSuperview()
        }
        
  
        let set = MakeEmptyDataSet()
        set.emptyDataSetView = contenerView
        emptyDataSet(set: set)
 
    }
    
    
    func showEmptyDataSetView()
    {
    
    }
    
    
    
    
    

}
 
 */
