//
//  XYPlayerView.h
//  EpicLive
//
//  Created by 王晓银 on 16/3/17.
//  Copyright © 2016年 liyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "XYPlayerMaskView.h"

//typedef void(^XYPlayerGoBackBlock)(void);

@interface XYPlayerView : UIView

/** 播放属性 */
@property (nonatomic, strong) AVPlayer*player;
/** 蒙版View */
@property (nonatomic, strong) XYPlayerMaskView *maskView;
/** 播放属性 */
@property (nonatomic, strong) AVPlayerItem *playerItem;
/** playerLayer */
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
/** 视频URL */
@property (nonatomic, strong) NSURL*videoURL;

//播放器的几种状态
typedef NS_ENUM(NSInteger, XYPlayerState) {
    XYPlayerStateBuffering,  //缓冲中
    XYPlayerStatePlaying,    //播放中
    XYPlayerStateStopped,    //停止播放
    XYPlayerStatePause       //暂停播放
};
/** 播发器的几种状态 */
@property (nonatomic, assign) XYPlayerState state;


/** 返回按钮Block */
//@property (nonatomic, copy  ) XYPlayerGoBackBlock goBackBlock;
/**
 *  取消延时隐藏maskView的方法,在ViewController的delloc方法中调用
 *  用于解决：刚打开视频播放器，就关闭该页面，maskView的延时隐藏还未执行。
 */
- (void)cancelAutoFadeOutControlBar;
/** 计时器 */
@property (nonatomic, strong) NSTimer *timer;

/** 类方法创建，该方法适用于代码创建View */
+ (instancetype)setupXYPlayer;

@end
