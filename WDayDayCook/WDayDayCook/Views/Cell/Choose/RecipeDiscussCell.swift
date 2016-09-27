//
//  RecipeDiscussCell.swift
//  WDayDayCook
//
//  Created by wangju on 16/7/27.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import Kingfisher

class RecipeDiscussCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var title: UILabel!
    
    var recipeDiscuss: FoodRecmmand? {
        
        didSet{
            
            guard let _ = recipeDiscuss else {
                return
            }
            let url = URL(string: recipeDiscuss!.image_url)
            
            imageView.kf.setImage(with: url)
            
            //imageView.kf.setImageWithURL(URL(string: recipeDiscuss!.image_url))
            title.text = recipeDiscuss?.foodDescription
        }
    }
    
    var themeRecipe: ThemeRecipe?{
        didSet{
            if let themeRecipe = themeRecipe
            {
                imageView.kf.setImage(with: URL(string: themeRecipe.image_url!))
                title.text = themeRecipe.title
                
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
