//
//  TitleView.swift
//  WDayDayCook
//
//  Created by wangju on 16/7/26.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit

class TitleView: UIView {

    fileprivate lazy var button: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.black, for: UIControlState())
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    var title: String?{
        didSet{
            button.setTitle(title, for: UIControlState())
            button.sizeToFit()
        }
    }
    
    var image: UIImage?{
        didSet{
            if let _ = image
            {
                button.setImage(image, for: UIControlState())
                button.sizeToFit()
            }
        
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(button)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubview(button)
        self.backgroundColor = UIColor.clear
    }
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.center = self.center
  
    }
 

}
