//
//  MOIBaseViewController.h
//  CatClaws
//
//  Created by Andy on 14-11-26.
//  Copyright (c) 2014年 MOI. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "HeadNavigationView.h"
#import "JGProgressHUD.h"

//typedef enum kMOIIndicatorEnum
//{
//    kMOIIndicatorEnum_Error,
//    kMOIIndicatorEnum_Warning,
//    kMOIIndicatorEnum_Success,
//    kMOIIndicatorEnum_Matrix,
//    kMOIIndicatorEnum_Default,
//    kMOIIndicatorEnum_Process,
//}kMOIIndicator;

typedef enum kMOIIndicatorEnum
{
    kMOIIndicatorEnum_Indeterminate = 1, //菊花
    kMOIIndicatorEnum_Success = 2, //完成
    kMOIIndicatorEnum_Error = 3, //失败
    
}kMOIIndicator;

                              
@interface MOIBaseViewController : UIViewController



@property (nonatomic,strong) HeadNavigationView *headNavigationView;
@property (strong , nonatomic) UIView *noMessageView;
@property (strong , nonatomic) JGProgressHUD *progress;


#pragma mark - public api
@property (nonatomic) BOOL canHiddenHeadNav;

- (void)setupHeadViewUI;//继承后可重写 执行点击页面内位置的执行
- (void)setupViews;
- (void)setupParams;
- (void)mainTabBarFirstSelect; //主TabBar选中
- (void)mainTabBarSelectAgain; //主TabBar选中状态再次点击

- (void)btnRight;
- (void)btnHead;

//设置空白时的内容
- (void)setUpWaitCatView;
- (void)setNoMessageViewTitle:(NSString *)_tStr AndContent:(NSString *)_cStr;
- (void)setWaitViewLoading:(BOOL)_isLoading;

//常用提示窗
- (void)showProgressViewWithText:(NSString *)string;
- (void)showProgressViewWithText:(NSString *)string AndIndicatorEunm:(kMOIIndicator)_enum;

- (void)insertProgressViewForText:(NSString *)string;
- (void)editProgressViewForText:(NSString *)string;
- (void)editProgressViewForText:(NSString *)string AndIndicatorEunm:(kMOIIndicator)_enum;
- (void)removeProgressView;
- (void)removeProgressViewForAfterDelay:(NSTimeInterval)delay Completion:(void(^)())_Completion;


@end
