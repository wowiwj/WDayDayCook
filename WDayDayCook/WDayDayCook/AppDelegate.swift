//
//  AppDelegate.swift
//  WDayDayCook
//
//  Created by wangju on 16/7/24.
//  Copyright © 2016年 wangju. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private func realmConfig() -> Realm.Configuration {
        let directory: NSURL = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier(WDConfig.appGroupID)!
        let realmFileURL = directory.URLByAppendingPathComponent("db.realm")
        
        print(realmFileURL)
        
        var config = Realm.Configuration()
        config.fileURL = realmFileURL
        config.schemaVersion = 3
        config.migrationBlock = { migration, oldSchemaVersion in
        }
        
        return config
    }


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let fistOpen = WDConfig.firstOpen
      
        if  fistOpen{
            showNewFeature()
        }
        customAppearance()
        
        Realm.Configuration.defaultConfiguration = realmConfig()
   
        // 设置播放器AppKey
        VenvyVideoSDK.setAppKey("N1oWm_rdb")
    
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    /// 显示新特征界面
    func showNewFeature()
    {
        window?.rootViewController = NewFeatureController()
    }
    
    /// 显示主界面
    func showMainStoryboard()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
        let vc = storyboard.instantiateInitialViewController()
        
        window?.rootViewController = vc
 
    }
    
    /// 全局样式
    func customAppearance()
    {
        // Tabbar
        UITabBar.appearance().backgroundImage = UIImage(named: "tabBar_bg~iphone")
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().translucent = false
        
        // Nav bar
        let navBar = UINavigationBar.appearance()
        
        //   navBar.backgroundColor = UIColor.whiteColor()
        navBar.tintColor = UIColor.darkGrayColor()
        // 导航条默认设置为不透明
        navBar.translucent = false
        
        // navBg~iphone navi_bar_bg~iphone navBg2~iphone
        navBar.setBackgroundImage(UIImage(named: "navi_bar_bg~iphone"), forBarMetrics: .Default)
        // 取消navbar 下面的细线
//        navBar.shadowImage = UIImage()
    
    }

}

