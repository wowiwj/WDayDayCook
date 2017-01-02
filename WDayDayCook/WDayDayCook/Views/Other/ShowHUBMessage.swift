//
//  ShowHUBMessage.swift
//  WDayDayCook
//
//  Created by wangju on 16/9/14.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import SnapKit

class ShowHUBMessage: UIView {
    lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "iPhone_personal_blank~iphone")
        return imageView
    
    }()
    
    lazy var descriptionLabel:UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 13)
        return label
        
    }()
    
    lazy var infoButton:UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "iPad_send_bg~iphone"), for: UIControlState())
        button.setTitleColor(UIColor.orange, for: UIControlState())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return button
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(descriptionLabel)
        addSubview(infoButton)

        
        self.backgroundColor = UIColor.white
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
        print(self.frame.size)
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.width.equalTo(self).multipliedBy(0.5)
            make.center.equalTo(self)
            
        }
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(imageView.image?.size.width ?? 0)
            make.height.equalTo(imageView.image?.size.height ?? 0)
            make.centerX.equalTo(self)
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-10.autoAdjust())
        }
        
        
        infoButton.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10.autoAdjust())
            make.centerX.equalTo(self)
            make.width.equalTo(80.autoAdjust())
        }
        
        
    }
    
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
