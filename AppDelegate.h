//
//  AppDelegate.h
//  Tabbar
//
//  Created by apple on 16/5/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIViewController *rootViewController;

// 调用AppDelegate单例记录播放状态是否锁屏
@property (nonatomic, assign) BOOL     isLockScreen;

@end

