//
//  VVSDKPlayerViewController.h
//  VenvyVideoSDK
//
//  Created by Zard1096 on 15/8/3.
//  Copyright (c) 2015年 VenvyVideo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 提供一个简易全屏播放器,你几乎不需要配置
 * 注意:使用此播放器必须开启横竖屏!必须开启横竖屏!必须开启横竖屏!(重要说3遍!!!,开启方法见文档).不想开启横竖屏请自行使用view级播放器解决,并且demo中的view级播放器也会出错,请自行修改旋转方法
 */

@interface VVSDKPlayerViewController : UIViewController

- (id) init;

/**
 *  初始化
 *
 *  @param frame               视图位置与大小,请保证长300以上,宽至少200以上(不强求,但小于不保证显示质量).
 *  @param canSwitchFullScreen 是否能切换全屏(设置后不能更改)
 *  @param isFullScreen        是否全屏(如果前一项设置为否,则不能修改)
 *  @param url                 Url地址
 *  @param videoType           设置url地址类型
 *  @param localVideoTitle     如果为原地址或直播,请传入播放器上方显示Title,不然显示为空.网络来源也能传入Title进行修改
 *
 *  @return 初始化对象实例
 *
 *  注:videoType 合并videoType中的直播,添加直播属性isLive
 *  0:八大视频网站地址(默认)
 *  1:可直接访问视频原地址(网络)/直播地址
 *  2(测试):需要我请求一次得到json格式集合(直接能播放的视频源)/直播地址集合
 *      使用方法:如为本地组装url请传 file://path (注:url是json的本地路径或者网络接口,并非json本身)
 *      主要用于本地多种清晰度
 *      具体格式详见setDictionaryFormatWithDurationKey:的注释
 *  -1:存于手机中的本地视频
 *  -1,2(本地组装url)目前无法进行统计和视频交互
 *  注:本地文件无法获取唯一ID,加载不了交互,会报VPSDKIVAViewLoadErrorUrl错误,视频能正常播放
 */
- (id) initWithUrl:(NSString *)url VideoType:(NSInteger)videoType LocalVideoTitle:(NSString *)localVideoTitle;

/**
 *  初始化需要设置的参数,请在present之前全部设置完成.
 */
- (void) setUrl:(NSString *)url;
- (void) setVideoType:(NSInteger)videoType;
- (void) setLocalVideoTitle:(NSString *)localVideoTitle;
- (void) setIsLive:(BOOL)isLive;

/**
 *  设置是否加载云泡 默认为NO
 */
- (void) setEnableBubble:(BOOL)enable;

/**
 *  设置是否加载风车 默认为YES
 */
- (void)setEnableWindmill:(BOOL)enable;

@end
