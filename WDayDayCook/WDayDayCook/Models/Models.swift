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


// :MARK: - 广告数据的处理

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
    deleteAllObject(MainADItem)
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

// :MARK: - 每日新品数据的处理
/// 每日新品模型
class NewFood: Object {
    
    dynamic var detailsUrl: String = ""
    dynamic var clickCount: Int = 0
    dynamic var id: Int = 0
    dynamic var categoryID:Int = 0
    dynamic var foodDescription: String = ""
    dynamic var releaseDate: String = ""
    dynamic var type: String = ""
    dynamic var screeningId:String = ""
    dynamic var indexUrl:String = ""
    dynamic var maketime:String = ""
    dynamic var name: String = ""
    dynamic var shareCount: Int = 0
    dynamic var favorite: Bool = false
    dynamic var imageUrl: String = ""
    dynamic var title: String = ""
    dynamic var createDate: NSTimeInterval = NSDate().timeIntervalSince1970
    dynamic var modifyDate: NSTimeInterval = NSDate().timeIntervalSince1970
    
}

func addNewFoodtemInRealm(json :JSON)
{
    let jsonArr = json.arrayValue
    
    guard let realm = try? Realm() else
    {
        return
    }
    
    for item in jsonArr {
        
        let model = NewFood()
        model.detailsUrl = item["detailsUrl"].stringValue
        model.clickCount = item["clickCount"].intValue
        model.id = item["id"].intValue
        model.foodDescription = item["description"].stringValue
        model.releaseDate = item["releaseDate"].stringValue
        model.type = item["type"].stringValue
        model.screeningId = item["screeningId"].stringValue
        model.indexUrl = item["indexUrl"].stringValue
        model.maketime = item["maketime"].stringValue
        model.name = item["name"].stringValue
        model.shareCount = item["detailsUrl"].intValue
        model.favorite = item["detailsUrl"].boolValue
        model.imageUrl = item["imageUrl"].stringValue
        model.title = item["title"].stringValue
        model.createDate = item["createDate"].doubleValue
        model.modifyDate = item["modifyDate"].doubleValue

        try! realm.write({
            realm.add(model)
        })
    }
}

func getNewFoodItemInRealm(realm : Realm) -> Results<NewFood>
{
    let items = realm.objects(NewFood)
    return items
    
}

class ThemeRecmmand: Object
{
    dynamic var foodDescription: String = ""
    dynamic var favorite: Bool = false
    dynamic var recipe_type: String = ""
    dynamic var click_count :Int = 0
    dynamic var favorite_count: Int = 2
    dynamic var image_url: String = ""
    dynamic var rid: String = ""
    dynamic var title: String = ""
    dynamic var recommend_type: Int = 0
    dynamic var recipe_id: Int = 0
    dynamic var group_id: Int = -2
    dynamic var share_count: Int = 0
    dynamic var str_date: NSTimeInterval = NSDate().timeIntervalSince1970
}

func getThemeListInRealm(realm : Realm) -> Results<ThemeRecmmand>
{
    let items = realm.objects(ThemeRecmmand)
    return items
}





// MARK: - 共用的方法

// 删除某一个对象的所有数据
func deleteAllObject(objectType: Object.Type)
{
    if let realm = try? Realm() {
        let items = realm.objects(objectType)
        
        try! realm.write({
            realm.delete(items)
        })
    }
}

// 获取某一个模型的数据

func getObjectItemsInRealm(objectType: Object.Type,realm : Realm) -> Results<Object>
{
    let items = realm.objects(objectType)
    return items
}

func addNewObjectInRealm(json:JSON,type:Object.Type,action:(model :Object,json:JSON)->())
{
    
    let jsonArr = json.arrayValue
    
    guard let realm = try? Realm() else
    {
        return
    }
    for item in jsonArr {
        let model = type.init()
        
        action(model: model, json: item)
        
        try! realm.write({
            realm.add(model)
        })
    }
}


