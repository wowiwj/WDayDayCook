//
//  ThemeRecipe.swift
//  WDayDayCook
//
//  Created by wangju on 16/8/20.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import ObjectMapper

struct ThemeRecipeList :Mappable {
    
    var themeRecipes:[ThemeRecipe] = [ThemeRecipe]()
    var theme1:[ThemeRecipe]?{
        didSet{
            guard let theme1 = theme1 else{
                return
            }
            themeRecipes += theme1
        }
    }
    var theme2:[ThemeRecipe]?{
        didSet{
            guard let theme2 = theme2 else{
                return
            }
            themeRecipes += theme2
        }
    }
    var theme3:[ThemeRecipe]?{
        didSet{
            guard let theme3 = theme3 else{
                return
            }
            themeRecipes += theme3
        }
    }
    var theme4:[ThemeRecipe]?{
        didSet{
            guard let theme4 = theme4 else{
                return
            }
            themeRecipes += theme4
        }
    }
    var theme5:[ThemeRecipe]?{
        didSet{
            guard let theme5 = theme5 else{
                return
            }
            themeRecipes += theme5
        }
    }
    var theme6:[ThemeRecipe]?{
        didSet{
            guard let theme6 = theme6 else{
                return
            }
            themeRecipes += theme6
        }
    }
    var theme7:[ThemeRecipe]?{
        didSet{
            guard let theme7 = theme7 else{
                return
            }
            themeRecipes += theme7
        }
    }
    var theme8:[ThemeRecipe]?{
        didSet{
            guard let theme8 = theme8 else{
                return
            }
            themeRecipes +=  theme8
        }
    }
    var headerRecipes:[ThemeRecipe]?
    
    init?(_ map: Map) {
        
        
//        for i in 1...8 {
//            let str = "\(i).0.value"
//            let object = Mapper<ThemeRecipeArray>().map(map.JSONDictionary[1])
//            
//            themeRecipes.append(object!)
//            
//        }
    }

    mutating func mapping(map: Map) {
        
        headerRecipes <- map["-1"]
        theme1 <- map["1"]
        theme2 <- map["2"]
        theme3 <- map["3"]
        theme4 <- map["4"]
        theme5 <- map["5"]
        theme6 <- map["6"]
        theme7 <- map["7"]
        theme8 <- map["8"]
 
    }
}

struct ThemeRecipeArray: Mappable {
    var obj :[ThemeRecipe]?
    
    var key = "1"
    
    init?(_ map: Map) {
        key = map.JSONDictionary.keys.first!
    }
    
    mutating func mapping(map: Map) {
        obj <- map[key]
    }

}

struct ThemeRecipe: Mappable {
    
    var description:String?
    var favorite:Bool?
    var locationName:String?
    var recipe_type:String?
    var click_count:Int?
    var favorite_count:Int?
    var image_url:String?
    var rid:Int?
    var title:String?
    var locationId:Int?
    var recommend_type:String?
    var recipe_id:String?
    var group_id:String?
    var share_count:String?
    var str_date:String?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        description <- map["description"]
        favorite <- map["favorite"]
        locationName <- map["locationName"]
        recipe_type <- map["recipe_type"]
        click_count <- map["click_count"]
        favorite_count <- map["favorite_count"]
        image_url <- map["image_url"]
        rid <- map["rid"]
        title <- map["title"]
        locationId <- map["locationId"]
        recommend_type <- map["recommend_type"]
        recipe_id <- map["recipe_id"]
        group_id <- map["group_id"]
        share_count <- map["share_count"]
        str_date <- map["str_date"]
    }

}
