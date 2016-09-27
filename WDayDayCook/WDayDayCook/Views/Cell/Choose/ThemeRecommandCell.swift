//
//  ThemeRecommandCell.swift
//  WDayDayCook
//
//  Created by wangju on 16/7/27.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import Kingfisher

class ThemeRecommandCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var theme: FoodRecmmand?{
        didSet{
            if let _ = theme
            {
                imageView.kf.setImage(with: URL(string: theme!.image_url), placeholder: UIImage(named: "default_1~iphone"), options: nil, progressBlock: nil, completionHandler: nil)
                descriptionLabel.text = theme!.foodDescription
                titleLabel.text = theme!.title
                descriptionLabel.isHidden = theme!.foodDescription.isEmpty
            
            }

        }
    }
    
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
