//
//  ArticleCell.swift
//  WDayDayCook
//
//  Created by wangju on 16/7/26.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleCell: UICollectionViewCell {
    
    

    @IBOutlet weak var bgView: UIImageView!
    @IBOutlet weak var foodImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var foodDescription: UILabel!
    @IBOutlet weak var clickCountButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var newFood: NewFood? {
        didSet{
            
            guard let _ = newFood else
            {
                return
            }
            titleLabel.text = newFood?.title
            foodDescription.text = newFood?.foodDescription
            clickCountButton.setTitle("\(newFood!.clickCount)", forState: .Normal)
            foodImageView.kf_setImageWithURL(NSURL(string: (newFood?.imageUrl)!))
        
        
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.lightGrayColor().CGColor
        bgView.layer.cornerRadius = 5
        bgView.layer.masksToBounds = true
        
        
    }

}
