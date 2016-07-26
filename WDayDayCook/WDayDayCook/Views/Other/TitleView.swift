//
//  TitleView.swift
//  WDayDayCook
//
//  Created by wangju on 16/7/26.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit

class TitleView: UIView {

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(17)
        button.backgroundColor = UIColor.clearColor()
        return button
    }()
    
    var title: String?{
        didSet{
            button.setTitle(title, forState: .Normal)
            button.sizeToFit()
        }
    }
    
    var image: UIImage?{
        didSet{
            if let _ = image
            {
                button.setImage(image, forState: .Normal)
                button.sizeToFit()
            }
        
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(button)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubview(button)
        self.backgroundColor = UIColor.clearColor()
    }
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.center = self.center
  
    }
 

}
