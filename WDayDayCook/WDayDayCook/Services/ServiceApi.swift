//
//  ServiceApi.swift
//  WDayDayCook
//
//  Created by wangju on 16/7/24.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit

class ServiceApi: NSObject {

    static var host:String = "http://api.daydaycook.com.cn/daydaycook"
    
    //http://api.daydaycook.com.cn/daydaycook/server/ad/listAds.do?languageId=3&mainland=1&deviceId=D83DA445-62E2-46EF-A035-779FAE071FB2&uid=&regionCode=156
    // http://api.daydaycook.com.cn/daydaycook/server/ad/listAds.do?languageId=3&mainland=1&uid=&regionCode=156
    
    // listAds.do?languageId=3&mainland=1&deviceId=D83DA445-62E2-46EF-A035-779FAE071FB2&uid=&regionCode=156
    
    // 每日新品
    // http://api.daydaycook.com.cn/daydaycook/server/recipe/search.do?currentPage=0&pageSize=10&name=&categoryId=&parentId=&screeningId=&tagId=&username=(null)&password=(null)&languageId=3&mainland=1&uid=&regionCode=156
    
    // 推荐
    // http://api.daydaycook.com.cn/daydaycook/recommend/queryRecommendAll.do?username=(null)&password=(null)&languageId=3&mainland=1&deviceId=D83DA445-62E2-46EF-A035-779FAE071FB2&uid=&regionCode=156
    
    // http://api.daydaycook.com.cn/daydaycook/recommend/queryRecommendAll.do?username=(null)&password=(null)&languageId=3&mainland=1&deviceId=D83DA445-62E2-46EF-A035-779FAE071FB2&uid=&regionCode=156
    
    // http://api.daydaycook.com.cn/daydaycook/server/recipe/details.do?ver=2&id=38443&username=&password=&languageId=3&mainland=1&deviceId=D83DA445-62E2-46EF-A035-779FAE071FB2&uid=&regionCode=156
    
    // http://api.daydaycook.com.cn/daydaycook/server/recipe/details.do?ver=2&id=37697&username=&password=&languageId=3&mainland=1&deviceId=D83DA445-62E2-46EF-A035-779FAE071FB2&uid=&regionCode=156
    
    // http://api.daydaycook.com.cn/daydaycook//server/recipe/getRecipe.do?id=21691,27811&languageId=3&mainland=
    
    
    // http://api.daydaycook.com.cn/daydaycook/server/recipe/details.do?ver=2&id=38461&username=&password=&languageId=3&mainland=1&deviceId=D83DA445-62E2-46EF-A035-779FAE071FB2&uid=&regionCode=156
    
    // http://api.daydaycook.com.cn/daydaycook/server/recipe/detailVideo.do?id=38332&languageId=3&mainland=1&deviceId=D83DA445-62E2-46EF-A035-779FAE071FB2&uid=&regionCode=156
    
    // http://api.daydaycook.com.cn/daydaycook/server/recipe/search.do?currentPage=0&pageSize=20&name=&categoryId=&parentId=&screeningId=&tagId=&htagId=&username=2841235923C0DE23194B65BB20C25E74&password=&languageId=3&mainland=1&deviceId=D83DA445-62E2-46EF-A035-779FAE071FB2&notheme=3&uid=172096&regionCode=156&version=2.1.1
    
    // http://api.daydaycook.com.cn/daydaycook/server/recipe/search.do?currentPage=1&pageSize=20&name=&categoryId=&parentId=&screeningId=&tagId=&htagId=&username=2841235923C0DE23194B65BB20C25E74&password=&languageId=3&mainland=1&deviceId=D83DA445-62E2-46EF-A035-779FAE071FB2&notheme=3&uid=172096&regionCode=156&version=2.1.1
    
    // http://api.daydaycook.com.cn/daydaycook/server/recipe/search.do?currentPage=0&pageSize=20&name=&categoryId=&parentId=&screeningId=&tagId=&htagId=&username=2841235923C0DE23194B65BB20C25E74&password=&languageId=3&mainland=1&deviceId=D83DA445-62E2-46EF-A035-779FAE071FB2&notheme=3&uid=172096&regionCode=156&version=2.1.1
    
    //////////
    // http://api.daydaycook.com.cn/daydaycook/server/recipe/search.do?currentPage=0&pageSize=20&name=&categoryId=&parentId=&screeningId=&tagId=&htagId=&username=2841235923C0DE23194B65BB20C25E74&password=&languageId=3&mainland=1&deviceId=D83DA445-62E2-46EF-A035-779FAE071FB2&notheme=3&uid=172096&regionCode=156&version=2.1.1
    // http://api.daydaycook.com.cn/daydaycook/server/recipe/search.do?currentPage=1&pageSize=20&name=&categoryId=&parentId=&screeningId=&tagId=&htagId=&username=2841235923C0DE23194B65BB20C25E74&password=&languageId=3&mainland=1&deviceId=D83DA445-62E2-46EF-A035-779FAE071FB2&notheme=3&uid=172096&regionCode=156&version=2.1.1
    
    // 38443 38332
    
    class func getChooseViewAdList() -> String
    {
        return "\(host)/server/ad/listAds.do?languageId=\(WDConfig.languageId)&mainland=\(WDConfig.mainland)&uid=\(WDConfig.uid)&regionCode=\(WDConfig.regionCode)"
    }
    class func getNewFoodEachDay(currentpage :Int,pageSize:Int)->String
    {
        return "\(host)/server/recipe/search.do?currentPage=\(currentpage)&pageSize=\(pageSize)&name=&categoryId=&parentId=&screeningId=&tagId=&username=(null)&password=(null)&languageId=\(WDConfig.languageId)&mainland=\(WDConfig.mainland)&uid=\(WDConfig.uid)&regionCode=\(WDConfig.regionCode)"
    }
    
    class func test()-> String
    {
        return "http://api.daydaycook.com.cn/daydaycook/server/recipe/search.do?currentPage=0&pageSize=10&name=&categoryId=&parentId=&screeningId=&tagId=&username=(null)&password=(null)&languageId=3&mainland=1&deviceId=D83DA445-62E2-46EF-A035-779FAE071FB2&uid=&regionCode=156"
    }
    
    class func getRecommendInfo()->String
    {
        return "\(host)/recommend/queryRecommendAll.do?username=(null)&password=(null)&languageId=\(WDConfig.languageId)&mainland=\(WDConfig.mainland)&uid=\(WDConfig.uid)&regionCode=\(WDConfig.regionCode)"
 
    }
    
    class func getDetails(id:Int)->String
    {
        return "\(host)/server/recipe/details.do?ver=2&id=\(id)&username=&password=&languageId=\(WDConfig.languageId)&mainland=\(WDConfig.mainland)&uid=\(WDConfig.uid)&regionCode=\(WDConfig.regionCode)"
    }
    
    class func getVideosDetail(id:Int)->String
    {
        return "\(host)/server/recipe/detailVideo.do?id=\(id)&languageId=\(WDConfig.languageId)&mainland=\(WDConfig.mainland)&uid=\(WDConfig.uid)&regionCode=\(WDConfig.regionCode)"
    }

    class func getRecipeList(currentPage:Int,pageSize:Int)->String
    {
    
        return "\(host)/server/recipe/search.do?currentPage=\(currentPage)&pageSize=\(pageSize)&name=&categoryId=&parentId=&screeningId=&tagId=&htagId=&username=&password=&languageId=\(WDConfig.languageId)&mainland=\(WDConfig.mainland)&notheme=3&uid=\(WDConfig.uid)&regionCode=\(WDConfig.regionCode)"
    
    }
    
    
    
}
