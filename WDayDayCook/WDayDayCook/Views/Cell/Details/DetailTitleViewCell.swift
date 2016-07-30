//
//  DetailTitleViewCell.swift
//  WDayDayCook
//
//  Created by wangju on 16/7/30.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit

class DetailTitleViewCell: UITableViewCell {
    
    
    var cellheight:CGFloat = 0

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var makeTimeButton: UIButton!
    
    @IBOutlet weak var clickCountButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellheight = self.frame.size.height
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
