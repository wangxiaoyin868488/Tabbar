//
//  HeadNavigationView.h
//  beibeiCollect
//
//  Created by moi on 14-5-4.
//  Copyright (c) 2014年 liyun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum kHeadNavigationStyle
{
//    深色
    kHeadNavigationStyle_deepColor = 0,
    
//    白色
    kHeadNavigationStyle_white = 1,
    
}kHeadNavigationStyleEnum;



@interface HeadNavigationView : UIView
@property (weak,nonatomic) UIViewController *selfDelegate;
@property kHeadNavigationStyleEnum myStyle;
@property (strong , nonatomic) UILabel *titleLab;
@property (strong , nonatomic) UIButton *headBtnRight;
@property (strong , nonatomic) UIButton *headBtnLeft;

/**
 delegate 需按需求实现方法
 -(void)btnLeft;
 -(void)btnRight;
 **/
-(instancetype)initWithDelegate:(UIViewController *)_delegate AntTitle:(NSString *)_strTitle AndStyle:(kHeadNavigationStyleEnum)_styleEnum;

-(void)changeStyle:(kHeadNavigationStyleEnum)_style;
/**
 默认左按钮为返回按钮
 **/
-(void)setupLeftImage:(UIImage *)_img;
-(void)setupLeftImage:(UIImage *)_img newRect:(CGRect)_rect;
-(void)setupLeftStr:(NSString *)_strLeft;
-(void)setupRightImage:(UIImage *)_img;
-(void)setupRightStr:(NSString *)_strRight;

//增加MOIReadHintView
-(void)setupHintView;
-(void)changeHintViewCount:(int)_count;

-(void)setupRightEnabled:(BOOL)_enabled;
/**
 显示ActivityIndicatorView ActivityReturnCount++
 **/
-(void)showActivityIndicatorView;
/**
 ActivityReturnCount-- ActivityReturnCount==0 隐藏ActivityIndicatorView
 **/
-(void)hiddenActivityIndicatorView;

-(void)setTitle:(NSString *)title;

-(void)hideLeftBtn:(BOOL)hidden;

-(void)hideRightBtn:(BOOL)hidden;
@end
