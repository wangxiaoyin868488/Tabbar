//
//  AdvertiseView.h
//  Tabbar
//
//  Created by apple on 16/6/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kUserDefaults [NSUserDefaults standardUserDefaults]
static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";



@interface AdvertiseView : UIView


//显示广告页面方法

- (void)show;


//图片路径

@property (copy , nonatomic) NSString *firePath;
@end
