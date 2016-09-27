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
    

    case chooseViewAdList(parameters:[String: AnyObject]?)
    case newFoodEachDay(currentpage :Int,pageSize:Int)
    case recommendInfo(parameters:[String: AnyObject]?)
    case details(id: Int)
    case videosDetail(id:Int)
    case recipeList(currentpage :Int,pageSize:Int)
    case moreThemeRecipe(parameters:[String: AnyObject]?)
    case test()
    
    
    var path: String {
        
        switch self {
        case .chooseViewAdList:
            return ServiceApi.getChooseViewAdList()
        case .newFoodEachDay(let currentpage, let pageSize):
            return ServiceApi.getNewFoodEachDay(currentpage, pageSize: pageSize)
        case .recommendInfo:
            return ServiceApi.getRecommendInfo()
        case .details(let id):
            return ServiceApi.getDetails(id)
        case .videosDetail(let id):
            return ServiceApi.getVideosDetail(id)
        case .recipeList(let currentpage, let pageSize):
            return ServiceApi.getRecipeList(currentpage, pageSize: pageSize)
        case .moreThemeRecipe:
            return ServiceApi.getMoreThemeRecipe()
        default:
            return ServiceApi.getChooseViewAdList()
        }
    }
    
    var method:HTTPMethod {
        switch self {
        case .chooseViewAdList:
            return .get
        case .newFoodEachDay:
            return .get
        case .recommendInfo:
            return .get
        case .details:
            return .post
        case .recipeList:
            return .post
        default:
            return HTTPMethod.get
        }
    
    }
    
    func asURLRequest() throws -> URLRequest {
        print(path)
        
        let URL = Foundation.URL(string: path)!
        
        let mutableURLRequest = NSMutableURLRequest(url: URL)
        mutableURLRequest.setValue("1", forHTTPHeaderField: "device")
        mutableURLRequest.httpMethod = method.rawValue
        
        return mutableURLRequest as URLRequest;
        
//        switch self {
//        case .chooseViewAdList(let parameters):
//            return try URLEncoding.default.encode(mutableURLRequest, with: nil)
//        default:
//            return mutableURLRequest
//        }
        
    }
    
//    var URLRequest: NSMutableURLRequest {
//        
//        print(path)
//        
//        let URL = Foundation.URL(string: path)!
//        
//        let mutableURLRequest = NSMutableURLRequest(url: URL)
//        mutableURLRequest.setValue("1", forHTTPHeaderField: "device")
//        mutableURLRequest.httpMethod = method.rawValue
//
//        switch self {
//        case .chooseViewAdList(let parameters):
//            return Alamofire.ParameterEncoding.json.encode(mutableURLRequest, parameters: parameters).0
//        default:
//            return mutableURLRequest
//        }
//        
//        
//    }
    
}
