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


//let realmQueue = DispatchQueue(label: "com.wangju.WDDayDayCook", attributes: dispatch_queue_attr_make_with_qos_class(DispatchQueue.Attributes(), DispatchQoS.QoSClass.utility, 0))


// :MARK: - 广告数据的处理

/// 广告模型
class MainADItem: Object
{
    dynamic var createDate: TimeInterval = Date().timeIntervalSince1970
    dynamic var id :Int = 0
    dynamic var modifyDate: TimeInterval = Date().timeIntervalSince1970
    dynamic var path :String = ""
    dynamic var title :String = ""
    dynamic var type: Int = 0
    dynamic var url :String = ""  
}

func deleteAllADItem()
{
    deleteAllObject(MainADItem)
}

func addNewMainADItemInRealm(_ json :JSON)
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

func getADItemInRealm(_ realm : Realm) -> Results<MainADItem>
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
    dynamic var createDate: TimeInterval = Date().timeIntervalSince1970
    dynamic var modifyDate: TimeInterval = Date().timeIntervalSince1970
    
}

func addNewFoodItemInRealm(_ json :JSON)
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

func getNewFoodItemInRealm(_ realm : Realm) -> Results<NewFood>
{
    let items = realm.objects(NewFood)
    return items
    
}

class FoodRecmmand: Object
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
    dynamic var str_date: TimeInterval = Date().timeIntervalSince1970
}

func addFoodRecmmandItemInRealm(_ json :JSON)
{
    let jsonArr = json.arrayValue
    
    guard let realm = try? Realm() else
    {
        return
    }
    
    jsonArr.forEach { item in
        
        let model = FoodRecmmand()
        
        model.foodDescription = item["description"].stringValue
        model.favorite = item["favorite"].boolValue
        model.recipe_type = item["recipe_type"].stringValue
        model.click_count = item["click_count"].intValue
        model.favorite_count = item["favorite_count"].intValue
        model.rid = item["rid"].stringValue
        model.title = item["title"].stringValue
        model.recommend_type = item["recommend_type"].intValue
        model.recipe_id = item["recipe_id"].intValue
        model.group_id = item["group_id"].intValue
        model.share_count = item["share_count"].intValue
        model.str_date = item["str_date"].doubleValue
        model.image_url = item["image_url"].stringValue
        
        try! realm.write({
            realm.add(model)
        })
    }


}
func getFoodRecmmandListInRealm(_ realm : Realm) -> Results<FoodRecmmand>
{
    let items = realm.objects(FoodRecmmand)
    return items
}

func getRecmmandListInRealm(_ realm : Realm,recommendType:Int) -> Results<FoodRecmmand>
{
    let items = getFoodRecmmandListInRealm(realm)
    let predicate = NSPredicate(format:"recommend_type = %d",recommendType)
    return items.filter(predicate)
}

func getThemeListInRealm(_ realm : Realm) -> Results<FoodRecmmand>
{
    return getRecmmandListInRealm(realm, recommendType: 2)
}

func getRecipeListInRealm(_ realm : Realm) -> Results<FoodRecmmand>
{
    return getRecmmandListInRealm(realm, recommendType: 1)
}

func getRecipeDiscussListInRealm(_ realm : Realm) -> Results<FoodRecmmand>
{
    return getRecmmandListInRealm(realm, recommendType: 3)
}





// MARK: - 公用的方法

// 删除某一个对象的所有数据
func deleteAllObject(_ objectType: Object.Type)
{
    if let realm = try? Realm() {
        let items = realm.objects(objectType)
        
        try! realm.write({
            realm.delete(items)
        })
    }
}

// 获取某一个模型的数据

func getObjectItemsInRealm(_ objectType: Object.Type,realm : Realm) -> Results<Object>
{
    let items = realm.objects(objectType)
    return items
}




