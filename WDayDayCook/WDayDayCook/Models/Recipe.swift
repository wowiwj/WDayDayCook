//
//  Recipe.swift
//  WDayDayCook
//
//  Created by wangju on 16/8/19.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import ObjectMapper

struct RecipeList: Mappable
{
    var code:String?
    var msg:String?
    var data :[Recipe]?
    init?(_ map: Map) {
        
    }
    mutating func mapping(map: Map) {
        data <- map["data"]
        code <- map["code"]
        msg <- map["msg"]
    }
}
struct Recipe: Mappable {
    
    var detailsUrl:String?
    var clickCount:Int?
    var id:Int?
    var categoryID:Int?
    var description:String?
    var releaseDate:String?
    var type:String?
    var screeningId:(CGFloat,CGFloat,CGFloat)?
    var maketime:String?
    var name:String?
    var shareCount:Int?
    var createDate:NSTimeInterval?
    var modifyDate:NSTimeInterval?
    var imageUrl:String?
    var title:String?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        detailsUrl <- map["detailsUrl"]
        clickCount <- map["clickCount"]
        id <- map["id"]
        categoryID <- map["categoryID"]
        description <- map["description"]
        releaseDate <- map["releaseDate"]
        type <- map["type"]
        maketime <- map["maketime"]
        name <- map["name"]
        shareCount <- map["shareCount"]
        createDate <- map["createDate"]
        modifyDate <- map["modifyDate"]
        imageUrl <- map["imageUrl"]
        title <- map["title"]
    }

}
