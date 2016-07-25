//
//  Models.swift
//  WDayDayCook
//
//  Created by wangju on 16/7/24.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON


let realmQueue = dispatch_queue_create("com.wangju.WDDayDayCook", dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_UTILITY, 0))

/// 广告模型
class MainADItem: Object
{
    dynamic var createDate: NSTimeInterval = NSDate().timeIntervalSince1970
    dynamic var id :Int = 0
    dynamic var modifyDate: NSTimeInterval = NSDate().timeIntervalSince1970
    dynamic var path :String = ""
    dynamic var title :String = ""
    dynamic var type: Int = 0
    dynamic var url :String = ""  
}

func deleteAllADItem()
{
    if let realm = try? Realm() {
        let items = realm.objects(MainADItem)
       
        try! realm.write({
            realm.delete(items)
        })
    }
}

func addNewMainADItemInRealm(json :JSON)
{
    let jsonArr = json.arrayValue
    
    guard let realm = try? Realm() else
    {
        return
    }
    
    for item in jsonArr {
        
        let model = MainADItem()
        model.url = item["url"].stringValue
        model.type = item["type"].intValue
        model.title = item["title"].stringValue
        model.path = item["path"].stringValue
        model.id = item["id"].intValue
        model.createDate = item["createDate"].doubleValue
        model.modifyDate = item["modifyDate"].doubleValue
      
        try! realm.write({
            realm.add(model)
        })
    }
}

func getADItemInRealm(realm : Realm) -> Results<MainADItem>
{
    let items = realm.objects(MainADItem)
    return items
    
}
