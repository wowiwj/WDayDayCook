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
    
 
    private lazy var placeholderImage: UIImage = {
    
        let image = UIImage(named: "default~iphone")!
        return image
    
    }()
    

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
    
    var recipe: FoodRecmmand? {
        didSet{
            
            guard let _ = recipe else
            {
                return
            }
            titleLabel.text = recipe!.title
            foodDescription.text = recipe!.foodDescription
            clickCountButton.setTitle("\(recipe!.click_count)", forState: .Normal)
            
            
            foodImageView.kf_setImageWithURL(NSURL(string: recipe!.image_url))
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
