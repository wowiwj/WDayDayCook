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
    case getRecommendInfo(parameters:[String: AnyObject]?)
    case test()
    
    
    var path: String {
        
        switch self {
        case .ChooseViewAdList:
            return ServiceApi.getChooseViewAdList()
        case .NewFoodEachDay(let currentpage, let pageSize):
            return ServiceApi.getNewFoodEachDay(currentpage, pageSize: pageSize)
        case .getRecommendInfo:
            return ServiceApi.getRecommendInfo()
        default:
            return ServiceApi.getChooseViewAdList()
        }
    }
    
    var URLRequest: NSMutableURLRequest {
        
        print(path)
        
        let URL = NSURL(string: path)!
        
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.setValue("1", forHTTPHeaderField: "device")

        switch self {
        case .ChooseViewAdList(let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        default:
            return mutableURLRequest
        }
        
        
    }
    
}
