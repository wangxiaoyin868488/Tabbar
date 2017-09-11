//
//  XYPlayerMaskView.h
//  EpicLive
//
//  Created by 王晓银 on 16/3/17.
//  Copyright © 2016年 liyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYPlayerMaskView : UIView

/** 开始播放按钮 */
@property (weak, nonatomic) IBOutlet UIButton       *startBtn;
/** 当前播放时长label */
@property (weak, nonatomic) IBOutlet UILabel        *currentTimeLabel;
/** 视频总时长label */
@property (weak, nonatomic) IBOutlet UILabel        *totalTimeLabel;
/** 缓冲进度条 */
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
/** 滑杆 */
@property (weak, nonatomic) IBOutlet UISlider       *videoSlider;
/** 全屏按钮 */
@property (weak, nonatomic) IBOutlet UIButton       *fullScreenBtn;
@property (weak, nonatomic) IBOutlet UIButton       *lockBtn;

/**
 *  类方法创建
 */
+ (instancetype)setupPlayerMaskView;


@end
