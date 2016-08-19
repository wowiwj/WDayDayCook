//
//  Router.swift
//  WDayDayCook
//
//  Created by wangju on 16/7/24.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import Alamofire

enum Router: URLRequestConvertible {

    case ChooseViewAdList(parameters:[String: AnyObject]?)
    case NewFoodEachDay(currentpage :Int,pageSize:Int)
    case RecommendInfo(parameters:[String: AnyObject]?)
    case Details(id: Int)
    case VideosDetail(id:Int)
    case RecipeList(currentpage :Int,pageSize:Int)
    case test()
    
    
    var path: String {
        
        switch self {
        case .ChooseViewAdList:
            return ServiceApi.getChooseViewAdList()
        case .NewFoodEachDay(let currentpage, let pageSize):
            return ServiceApi.getNewFoodEachDay(currentpage, pageSize: pageSize)
        case .RecommendInfo:
            return ServiceApi.getRecommendInfo()
        case .Details(let id):
            return ServiceApi.getDetails(id)
        case .VideosDetail(let id):
            return ServiceApi.getVideosDetail(id)
        case .RecipeList(let currentpage, let pageSize):
            return ServiceApi.getRecipeList(currentpage, pageSize: pageSize)
        default:
            return ServiceApi.getChooseViewAdList()
        }
    }
    
    var method:Alamofire.Method {
        switch self {
        case .ChooseViewAdList:
            return .GET
        case .NewFoodEachDay:
            return .GET
        case .RecommendInfo:
            return .GET
        case .Details:
            return .POST
        case .RecipeList:
            return .POST
        default:
            return .GET
        }
    
    }
    
    var URLRequest: NSMutableURLRequest {
        
        print(path)
        
        let URL = NSURL(string: path)!
        
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.setValue("1", forHTTPHeaderField: "device")
        mutableURLRequest.HTTPMethod = method.rawValue

        switch self {
        case .ChooseViewAdList(let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        default:
            return mutableURLRequest
        }
        
        
    }
    
}
