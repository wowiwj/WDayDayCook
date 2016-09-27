//
//  DetailTabbar.swift
//  WDayDayCook
//
//  Created by wangju on 16/8/12.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import SnapKit

class DetailTabbar: UIView {
    lazy var commentButton:UIButton = {
    
        let button = UIButton()
        button.setImage(UIImage(named: "Details_tabcommentIcon~iphone"), for: UIControlState())
        return button
    }()
    
    lazy var favButton:UIButton = {
        
        let button = UIButton()
        
        button.setImage(UIImage(named: "Details_tabfavIcon~iphone"), for: UIControlState())
        return button
    }()
    
    lazy var fontButton:UIButton = {
        
        let button = UIButton()
        
        button.setImage(UIImage(named: "Details_selectFont~iphone"), for: UIControlState())
        return button
    }()
    
    lazy var shareButton:UIButton = {
        
        let button = UIButton()
        
        button.setImage(UIImage(named: "Details_tabshare~iphone"), for: UIControlState())
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(commentButton)
        addSubview(favButton)
        addSubview(fontButton)
        addSubview(shareButton)
        
        self.backgroundColor = UIColor.white
        
        commentButton.snp_makeConstraints { (make) in
            make.leading.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
        }
        favButton.snp_makeConstraints { (make) in
            make.leading.equalTo(commentButton.snp_trailing)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.equalTo(commentButton)
        }
        fontButton.snp_makeConstraints { (make) in
            make.leading.equalTo(favButton.snp_trailing)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.equalTo(commentButton)
        }
        shareButton.snp_makeConstraints { (make) in
            make.leading.equalTo(fontButton.snp_trailing)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.trailing.equalTo(self)
            make.width.equalTo(commentButton)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    

}
