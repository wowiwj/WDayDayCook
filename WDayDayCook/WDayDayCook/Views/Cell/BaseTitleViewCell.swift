//
//  BaseTitleViewCell.swift
//  WDayDayCook
//
//  Created by wangju on 16/7/26.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import SnapKit


class BaseTitleViewCell: UITableViewCell {

    lazy var titleView :TitleView = TitleView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(titleView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleView.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(WDConfig.baseTitleHeight.autoAdjust())
        })
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
