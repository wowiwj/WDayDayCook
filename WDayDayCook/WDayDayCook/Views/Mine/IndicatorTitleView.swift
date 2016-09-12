//
//  IndicatorView.swift
//  WDayDayCook
//
//  Created by wangju on 16/9/12.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import SnapKit

class IndicatorTitleView: UIView {
    
    private var buttons:[IndicatorButton] = []
    
    
    internal func setTitlesColor(color: UIColor?, forState state: UIControlState){
        for item in buttons {
            item.setTitleColor(color, forState: state)
        }
    }
    
    var titleLabelsFont:UIFont?{
        didSet{
            
            for item in buttons {
                item.titleLabel?.font = titleLabelsFont
            }
        }

    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _ = IndicatorButton()
        
//        btn.frame = CGRect(x: 1, y: 1, width: 100, height: 40)
//        btn.setTitle("测试", forState: UIControlState.Normal)
//        btn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
//        btn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Selected)
//        btn.addTarget(self, action: #selector(IndicatorTitleView.buttonclicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
//        addSubview(btn)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonclicked(target:UIButton)
    {
        target.selected = !target.selected
        
        
        for item in buttons {
//            print(item.indicatorView)
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
