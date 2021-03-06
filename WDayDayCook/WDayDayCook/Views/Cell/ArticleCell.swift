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
    
 
    fileprivate lazy var placeholderImage: UIImage = {
    
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
            clickCountButton.setTitle("\(newFood!.clickCount)", for: UIControlState())
            foodImageView.kf.setImage(with: URL(string: (newFood?.imageUrl)!))
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
            clickCountButton.setTitle("\(recipe!.click_count)", for: UIControlState())
            
           
            foodImageView.kf.setImage(with: URL(string: recipe!.image_url))
        }
    }
    
    var recipeData:Recipe?{
        didSet{
            guard let recipeData = recipeData else{
                return
            }
        
            titleLabel.text = recipeData.title
            foodDescription.text = recipeData.description
            clickCountButton.setTitle("\(recipeData.clickCount ?? 0)", for: UIControlState())
            foodImageView.kf.setImage(with: URL(string: recipeData.imageUrl!))
        
        }
    
    }
    

    override func prepareForReuse() {
        super.prepareForReuse()
        foodImageView.image = nil
        titleLabel.text = nil
        foodDescription.text = nil
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        bgView.layer.borderWidth = 0.5
        bgView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        bgView.layer.cornerRadius = 5
        bgView.layer.masksToBounds = true

    }

}
