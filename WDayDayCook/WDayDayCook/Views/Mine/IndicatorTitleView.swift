//
//  IndicatorView.swift
//  WDayDayCook
//
//  Created by wangju on 16/9/12.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import SnapKit

@objc protocol IndicatorTitleViewDelegate:NSObjectProtocol{

    optional func indicatorTitleView(indicatorTitleView view:UIView,didSelectButton button:IndicatorButton,atIndex index:Int)->Void


}

class IndicatorTitleView: UIView {
    
    var selectedIndex:Int = 0
    
    func setTitleSelectIndex(index:Int){
        
        if index < 0 {
            return
        }
        if index > buttons.count {
            return
        }
        buttonclicked(buttons[index])
    
    }
    
    weak var delegate:IndicatorTitleViewDelegate?
    
    
    private var buttons:[IndicatorButton] = []
    
    
    internal func setTitlesColor(color: UIColor?, forState state: UIControlState){
        for item in buttons {
            item.setTitleColor(color, forState: state)
            if state == .Selected  {
                item.setTitleColor(color, forState: .Disabled)
            }
        }
    }
    
    var titleLabelsFont:UIFont?{
        didSet{
            
            for item in buttons {
                item.titleLabel?.font = titleLabelsFont
            }
        }

    }

    
    @objc private func buttonclicked(target:UIButton)
    {
        buttons[selectedIndex].selected = false
        
        target.selected = true
        
        selectedIndex = buttons.indexOf(target as! IndicatorButton) ?? 0
  
        guard let delegate = delegate else{
            return
        
        }
        
        if delegate.respondsToSelector(#selector(IndicatorTitleViewDelegate.indicatorTitleView(indicatorTitleView:didSelectButton:atIndex:))) {
            delegate.indicatorTitleView!(indicatorTitleView: self, didSelectButton: target as! IndicatorButton, atIndex: selectedIndex)
        }
 

    }

    var titles:[String]?{
        didSet{
            
            guard let titles = titles else {
                return
            }
            // 添加前清除原来的按钮
            for item in subviews{
                item.removeFromSuperview()
            }
            
            // 清空数组
            buttons.removeAll()
            
            if titles.isEmpty {
                return
            }
            // 添加按钮
            for i in 0..<titles.count{
                let button = IndicatorButton()
                button.setTitle(titles[i], forState: UIControlState.Normal)
                buttons.append(button)
                addSubview(button)
                
                button.addTarget(self, action: #selector(IndicatorTitleView.buttonclicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            }
       
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let titles = titles else {
            return
        }
        if titles.isEmpty {
            return
        }
        
        var oldItem :UIButton?
        
        for item in buttons {
            item.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(self)
                make.bottom.equalTo(self)
            
                if item == buttons.first{
                    make.leading.equalTo(self)
                }else
                {
                    if let oldItem = oldItem {
                        make.left.equalTo(oldItem.snp_right)
                    }
                    make.width.equalTo(buttons.first!)
                }
                
                oldItem = item
                
                if item == buttons.last{
                    make.trailing.equalTo(self)
                }

            })
        }

    }

}
