//
//  VVSDKPlayerView.h
//  VenvyVideoSDK
//
//  Created by Zard1096 on 15/7/30.
//  Copyright (c) 2015年 VenvyVideo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VVMediaPlayback.h"

/**
 * 只是播放view,提供给需要更多自定义的用户,限制少,当然你需要做的也多(稍有不稳定,如有问题请反馈给我:zard1096@videopls.com)
 * 非全屏不显示云链
 */

@interface VVSDKPlayerView : UIView

#pragma 初始化及参数设置
/**
 *  初始化(推荐)
 *  具体参数见下一条初始化，剩余参数请于调用startLoadingView之前全部设置完成
 */
- (id)initWithFrame:(CGRect)frame
CanSwitchFullScreen:(BOOL)canSwitchFullScreen
       IsFullScreen:(BOOL)isFullScreen;

/**
 *  初始化(推荐)
 *
 *  @param frame                视图位置与大小,请保证长300以上,宽至少200以上(不强求,但小于不保证显示质量).
 *  @param canSwitchFullScreen  是否能切换全屏(设置后不能更改)
 *  @param isFullScreen         是否全屏(如果前一项设置为否,则不能修改)
 *  @param url                  Url地址
 *  @param videoType            设置url地址类型
 *  @param localVideoTitle      初始化设置视频标题,方便后台管理,也会显示在播放器上(可选,推荐)
 *
 *  @return 初始化对象实例
 *
 *  注:videoType 合并videoType中的直播,添加直播属性isLive
 *  0:八大视频网站地址(默认)
 *  1:可直接访问视频原地址(网络)/直播地址
 *  2(测试):需要我请求一次得到json格式集合(直接能播放的视频源)/直播地址集合
 *      使用方法:如为本地组装url请传 file://path (注:url是json的本地路径或者网络接口,并非json本身)
 *      主要用于多种清晰度
 *  -1:存于手机中的本地视频
 *  -2(测试):本地json(需传 file://path )和视频,多段本地视频的播放(暂时支持系统标准mp4,mov,m4a. flv等非系统支持容器格式不稳定,可能产生跳转卡住)
 *  -2,2等需要多段拼接必须确保拼接视频的视频参数一致,详见:(https://trac.ffmpeg.org/wiki/Concatenate#samecodec)
 *
 *  -1,2(本地组装url),-2目前无法进行统计和视频交互
 *  注:本地文件无法获取唯一ID,加载不了交互,会报VPSDKIVAViewLoadErrorUrl错误,视频能正常播放
 *
 *  注*:setDictionaryFormatWithDurationKey:...此方法已过期,videoType == 2请传递标准解析Json格式,网址为:http://videojj.com/docs/#parse-video-intro
 *
 */
- (id)initWithFrame:(CGRect)frame
CanSwitchFullScreen:(BOOL)canSwitchFullScreen
       IsFullScreen:(BOOL)isFullScreen
                Url:(NSString *)url
          VideoType:(NSInteger)videoType
    LocalVideoTitle:(NSString *)localVideoTitle;

/**
 *  初始化时设置是否为直播属性
 */
- (void)setIsLive:(BOOL)isLive;

/**
 *  初始化需要设置的参数,请在调用startLoadingView之前全部设置完成.
 *  canSwitchFullScreen默认为No,默认canSwitchFullScreen?isFullScreen=NO : isFullScreen=YES,设置switchToFullScreen后请重新设置isFullScreen,canSwitchFullScreen==NO建议保持isFullScreen=YES.
 *  url,videoType,localVideoTitle可在stop后重新设置.
 *  其余参数包括block方法请释放后重新生成PlayerView再设置.
 */
- (void)setCanSwitchFullScreen:(BOOL)canSwitchFullScreen;
- (void)setIsFullScreen:(BOOL)isFullScreen;
- (void)setUrl:(NSString *)url;
- (void)setVideoType:(NSInteger)videoType;
- (void)setLocalVideoTitle:(NSString *)localVideoTitle;


/**
 *  设置自定义UIView
 *  无界面播放器的界面将设置在这里
 *  更新全屏请自行控制是hidden或者拉伸并且设置frame(位置为在播放器中的位置)
 *  其中customUIView只是界面层,不能有任何的手势和hitTest:的方法,或者hitTest:方法需要过滤该view
 *  customGestureView是一个手势控制层,customUIView的手势控制在这个页面中
 *  如果customUIView中有手势则不会添加gestureView并且会将云链层放在其上方(有可能会遮挡到控制栏,防止云链层点击时间被覆盖)
 *  不要在VVSDKPlayerView上覆盖其他可能会影响手势操作的view
 *  详细设置可参照Demo,或者参考文档
 */
- (void)setCustomUIView:(UIView *)customUIView;
- (void)setCustomGestureView:(UIView *)customGestureView;

/**
 *  设置控制器样式,合并NoControlPlayerView,请在调用startLoadingView之前完成设置完成,无法重新设置
 *  controlStyle = VVSDKPlayerControlStyleNone
 *  setCanSwitchFullScreen:,setSwitchToFullScreen:,setTurnOffFullScreen:,setBackButtonTappedToDo:的设置都无效
 *  合并完成，移除NoControlPlayerView
 */
- (void)setPlaybackControlStyle:(VVSDKPlayerControlStyle)playerControlStyle;

/**
 *  type = 2,必须传递.层级用‘,’表示,数组用‘|’表示.数组暂时只支持一层,请不要用多层数组,不然会造成错误.如:
 *  无分段:
 *  {"status":"0","msg":{"duration":100,"urls":[{"url":"http://xxx","definition":"SD"},{"url":"http://xxx","definition":"HD"}]}}
 *  其中durationKey需传: @"msg,duration",urlKey需传: @"msg,urls|url",definitionKey需传: @"msg,urls|definition"
 *
 *  [player setDictionaryFormatWithDurationKey:@"msg,duration" urlKey:@"msg,urls|url" definitionKey:@"msg,urls|definition" urlKeyIsDefinition:NO isMultiSegment:NO definitionSplit:nil];
 *
 *  相同清晰度会取mp4,mov等可以软解的,如果definition中没有会从url中判断,都没有会取第一个,优先会取清晰度中带m3u8,mp4的
 *
 *  有分段:(分段请保证durationKey取的是每个分段的时长,并且请保证分段是按从开始到结束顺序排列的,并且一个清晰度的分段是在一个数组中)
 *  {"duration":201,"urls":{"SD":[{"url":"http://xxx","duration":100},{"url":"http://xxx","duration":101}],"HD":[{"url":"http://xxx","duration":90},{"url":"http://xxx","duration":111}]}}
 *
 *  [player setDictionaryFormatWithDurationKey:@"urls,VVDefinitionKey|duration" urlKey:@"urls,VVDefinitionKey|url" definitionKey:@"urls" urlKeyIsDefinition:YES isMultiSegment:YES definitionSplit:nil];
 *
 *  @param durationKey        取得整个视频长度
 *  @param urlKey             获得urlKey的值,如果urlKeyIsDefinition为YES,则传入中间用VVDefinitionKey来代替
 *  @param definitionKey      获取清晰度对应的值,如果是url键值传之前的值,清晰度请尽量以SD,HD,SuperHD,720P,1080P来命名,不然不能保证顺序准确
 *  @param urlKeyIsDefinition 清晰度是否为url键值
 *  @param isMultiSegment     是否有分段(分段请保证格式是一样的).  分段开始测试,如有问题请反馈
 *  @param definitionSplit    清晰度定义是否为长宽,如为本身定义设为@""或者nil.比如:480x360,则传@"x".(请保证前后一定为数字).
 *                            最小值360(包括)以下SD,480(包括)以下HD,720(不包括)以下SuperHD,1080(不包括)以下为720P,大于为1080P
 *
 *
 *
 *  注*:此方法已过期,传递解析Json请按网址(http://videojj.com/docs/#parse-video-intro)中的格式进行传递
 *
 */
- (void) setDictionaryFormatWithDurationKey:(NSString *)durationKey
                                     urlKey:(NSString *)urlKey
                              definitionKey:(NSString *)definitionKey
                         urlKeyIsDefinition:(BOOL)urlKeyIsDefinition
                             isMultiSegment:(BOOL)isMultiSegment
                            definitionSplit:(NSString *)definitionSplit DEPRECATED_ATTRIBUTE;

/**
 *  如果switchToFullScreen为true,设置切换/退出全屏需要进行的操作(block),请在调用startLoadingView之前全部设置完成
 */
- (void)setSwitchToFullScreen:(void (^)(void))switchToFullScreen;
- (void)setTurnOffFullScreen:(void (^)(void))turnOffFullScreen;
/**
 *  全屏下点击返回键需要进行的操作(注意:如果需要切换全屏一定要设置!!!)
 */
- (void)setBackButtonTappedToDo:(void (^)(void))backButtonTapped;


//后台新增默认配置风车和云泡,如果在SDK中配置则已SDK配置优先
/**
 *  设置是否加载云泡 默认为NO
 */
- (void)setEnableBubble:(BOOL)enable;

/**
 *  设置是否加载风车 默认为YES
 */
- (void)setEnableWindmill:(BOOL)enable;

/**
 * 每次视频显示大小变化都需要调用此接口,如果需要切换全屏最好设置在切换/退出全屏的方法中,请不要使用setFrame方法
 */
- (void)updateFrame:(CGRect)newFrame;

/**
 *  切换/退出全屏调用方法,YES:进入全屏,NO:退出全屏
 */
- (void)enterOrExitFullScreen:(BOOL)fullScreen;


#pragma 设置结束,开始加载
/**
 *  需要加载时再调用,开始加载并播放视频
 */
- (void)startLoadingVideo;

#pragma 结束播放
/**
 *  停止播放
 */
- (void)stop;

/**
 *  停止播放并销毁view(注意:退出必须调用,不然内存不会释放!!!)
 */
- (void)stopAndDestoryView;

//注意,以下get方法通用,只能在加载视频后

#pragma 播放时获取参数
/**
 *  获得当前是否全屏
 */
- (BOOL)isFullScreen;

/**
 *  获取当前是否锁屏(仅限于有界面)
 */
- (BOOL)isLockScreen;

/**
 *  当前播放时间
 */
- (NSTimeInterval)getCurrentPlayTime;

/**
 *  总播放时间
 */
- (NSTimeInterval)getTotalDuration;

/**
 *  获取缓冲百分比(0~100,有可能会出现偏差<0或>100,建议做一下处理)
 */
- (NSInteger)getBufferLoadingProgress;

/**
 *  获取视频尺寸
 */
- (CGSize)getVideoSize;

/**
 *  获取播放状态
 */
- (BOOL)isPlaying;

/**
 *  获取当前缓冲进度
 */
- (NSTimeInterval)getCurrentBufferTime;

/**
 *  获取是否为直播
 */
- (BOOL)getIsLiveVideo;

/**
 *  获取云链显示状态
 */
- (BOOL)getVenvyTagIsShow;

/**
 *  获取云泡是否显示
 */
- (BOOL)getBubbleIsShow;

/**
 *  获取当前时间点的视频图像
 */
- (UIImage *)thumbnailImageAtCurrentTime;
/**
 *  设置清晰度(只能设置最高和最低)默认是最高，isHigh=YES;
 */
- (void)setDefaultVideoDefinition:(BOOL)isHigh;

#pragma 播放中控制播放器,需要在无界面中才能实现
//注意,以下方法在controlStyle = VVSDKPlayerControlStyleNone并且在加载视频后

/**
 *  控制播放器播放/暂停
 *
 */
- (void)playerPlayorPause:(BOOL)play;

/**
 *  设置播放时间(注:播放完成后需要重新播放后才能再调用此方法)
 */
- (void)setSeekTime:(NSTimeInterval)playTime;

/**
 *  设置是否显示云链
 */
- (void)setShowVenvyTag:(BOOL)isShow;

/**
 *  设置是否显示云泡(不加载云泡无法调用) 默认是NO
 */
- (void)setShowBubble:(BOOL)isShow;

/**
 *  切换清晰度,传的值为sendFormatArray中的序号
 */
- (void)changeVideoDefinition:(NSInteger)format;

/**
 *  设置视频显示尺寸
 */
- (void)setScreenSize:(VVSDKPlayerScreenSize)screenSize;

@end
