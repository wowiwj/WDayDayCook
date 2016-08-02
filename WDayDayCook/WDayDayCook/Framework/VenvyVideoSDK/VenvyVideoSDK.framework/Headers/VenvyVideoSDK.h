//
//  VenvyVideoSDK.h
//  VenvyVideoSDK
//
//  Created by Zard1096 on 15/6/2.
//  Copyright (c) 2015年 VenvyVideo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface VenvyVideoSDK : NSObject

/**
 *  设置AppKey(只能设置一次,不可重复设置)
 */
+ (void)setAppKey:(NSString *)appKey;

@end
