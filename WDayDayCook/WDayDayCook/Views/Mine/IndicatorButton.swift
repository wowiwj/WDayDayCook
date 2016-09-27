//
//  IndicatorButton.swift
//  WDayDayCook
//
//  Created by wangju on 16/9/12.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import SnapKit

class IndicatorButton: UIButton {
    
    
    override var isSelected:Bool{
        
        didSet{
            let normalColor = titleColor(for: UIControlState())?.withAlphaComponent(0.5)
            let selectedColor = titleColor(for: UIControlState.selected)
            indicatorView.backgroundColor = isSelected ? selectedColor : normalColor
        
        }

    }
    
    let indicatorHeight:CGFloat = 1
    
    lazy var indicatorView:UIView = {
        let view = UIView()
        self.addSubview(view)
        let normalColor = self.titleColor(for: UIControlState())?.withAlphaComponent(0.5)
        view.backgroundColor = normalColor
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        indicatorView.snp_makeConstraints { (make) in
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.height.equalTo(indicatorHeight)
            make.bottom.equalTo(self)
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
