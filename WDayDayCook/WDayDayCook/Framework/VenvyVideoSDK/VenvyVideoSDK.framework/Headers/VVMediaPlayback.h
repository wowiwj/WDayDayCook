//
//  VVMediaPlayback.h
//  VenvyVideoSDK
//
//  Created by Zard1096 on 15/8/18.
//  Copyright (c) 2015年 VenvyVideo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  通知
 */
@interface VVMediaPlayback : NSObject

//  都能使用

/**
 *  在自己应用内部打开链接传递的通知,协议头为tomyapp:// 对应http:// ,topmyapps:// 对应https://
 *  notification中userInfo,Key: LinkUrl,Value: 即为你所需的url,SDK会替换回http
 *  提示:在编辑云窗时,添加的link对应是:http://xxxxx ,改为 tomyapp://xxxxx
 */
extern NSString *const VVSDKMyAppLinkDidOpenNotification;


// 提供给无控制界面播放器使用(测试)

/**
 *  加载完成,可以播放notification中的userInfo,
 *  Key: ShowTitle,Value: 对应八大网站视频,本地、直播为空
 *  Key: SendFormatArray,Value: 清晰度数组,以从低到高排序
 *  Key: Format,Value: 当前清晰度
 */
extern NSString *const VVSDKPlayerIsPreparedToPlayNotification;

/**
 *  播放是否阻塞(包括切换清晰度),notification中的userInfo,Key: LoadState,Value: MPMovieLoadState
 *  MPMovieLoadStatePlaythroughOK缓冲结束,MPMovieLoadStateStalled开始缓冲
 */
extern NSString *const VVSDKPlayerLoadStateDidChangeNotification;

/**
 *  播放完成通知
 */
extern NSString *const VVSDKPlayerPlaybackDidFinishNotification;

/**
 *  跳转进度,notification中的userInfo,Key: SeekState,Value: VVSDKPlayerSeekState
 *  VVSDKPlayerSeekStart开始跳转,VVSDKPlayerSeekComplete跳转结束
 */
extern NSString *const VVSDKPlayerSeekStateNotification;

/**
 *  错误通知,notification中的userInfo,Key: ErrorState,Value: VVSDKPlayerErrorState
 */
extern NSString *const VVSDKPlayerErrorNotification;

/**
 *  云链被点击,notification中的userInfo,Key: VenvyTagState,Value VVSDKPlayerVenvyTagState
 */
extern NSString *const VVSDKPlayerVenvyTagNotification;

@end


typedef NS_ENUM(NSInteger, VVSDKPlayerSeekState) {
    VVSDKPlayerSeekStart,                   //开始Seek
    VVSDKPlayerSeekComplete                 //Seek结束
};

typedef NS_ENUM(NSInteger, VVSDKPlayerErrorState) {
    VVSDKPlayerErrorUrl,                    //错误的地址
    VVSDKPlayerErrorUrlFormat,              //错误的地址格式
    VVSDKPlayerErrorServer,                 //连接服务器出错
    VVSDKPlayerErrorSlowConnecting,         //网络连接超时
    VVSDKPlayerErrorInvalidAppKey,          //无效Appkey
    VVSDKPlayerErrorInvalidBundleID,        //Appkey与bundleID不匹配
    VVSDKPlayerErrorForLiveVideo,           //这是直播视屏
    VVSDKPlayerErrorForNoNet,               //无网络连接
    VVSDKPlayerHintForCeluar,               //使用蜂窝网络提示
    VVSDKPlayerHintForChangePlayer,         //切换到软解播放器
    VVSDKPlayerHintForServerLoadComplete    //与服务器通信完成
};

typedef NS_ENUM(NSInteger, VVSDKPlayerVenvyTagState) {
    VVSDKVenvyTagPausePlayer,           //云链被点击,打开云窗,右边遮住小半屏,可能需要暂停(最好隐藏控制栏)
    VVSDKVenvyTagPlayPlayer,            //云窗关闭,如果之前控制暂停可以继续播放
    
    //如果不由SDK控制外链打开将没有以下状态
    VVSDKVenvyDgPausePlayer,            //云窗的外链被点击,打开外链,默认暂停(最好暂停和隐藏控制栏)
    VVSDKVenvyDgPlayPlayer              //云窗的外链关闭,默认播放(可以根据之前播放状态继续播放或者保持暂停)
};

typedef NS_ENUM(NSInteger, VVSDKPlayerControlStyle) {
    VVSDKPlayerControlStyleNone = 1,        //No Control,没有控制界面,会发通知
    VVSDKPlayerControlStyleDefault = 0      //Default style,默认样式,不会发通知
};

typedef NS_ENUM(NSInteger, VVSDKPlayerScreenSize) {
    VVSDKPlayerScreenSizeNormal,            //原始比例
    VVSDKPlayerScreenSize16_9,              //16:9
    VVSDKPlayerScreenSize4_3                //4:3
};
