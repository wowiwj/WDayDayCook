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
    case test()
    
    
    var path: String {
        
        switch self {
        case .ChooseViewAdList:
            return ServiceApi.getChooseViewAdList()
        case .test():
            return ServiceApi.test()
        default:
            return ServiceApi.getChooseViewAdList()
        }
    }
    
    var URLRequest: NSMutableURLRequest {
        
        print(path)
        
        let URL = NSURL(string: path)!
        
        let mutableURLRequest = NSMutableURLRequest(URL: URL)

        switch self {
        case .ChooseViewAdList(let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        case .test():
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: nil).0
        default:
            return mutableURLRequest
        }
        
        
    }
    
}
