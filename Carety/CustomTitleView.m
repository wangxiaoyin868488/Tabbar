//
//  CustomTitleView.m
//  EpicLive
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 liyun. All rights reserved.
//

#import "CustomTitleView.h"

@implementation CustomTitleView{

UIView *_bjView;
UIView *_btnView;

CustomTitleViewBlock _customBlock;
dispatch_block_t _dismissBlock;

}


- (instancetype)initWithClickBlock:(CustomTitleViewBlock)clickBlock dismissBlock:(dispatch_block_t)dismissBlock isQuanBu:(BOOL)isQuanbu{
    
    
    self = [super initWithFrame:CGRectMake(0, 0, kwidth, kheight)];
    
    if (self) {
        _customBlock = clickBlock;
        _dismissBlock = dismissBlock;
        
        self.hidden = YES;
        
        _bjView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight)];
        _bjView.backgroundColor = [UIColor blackColor];
        _bjView.alpha = 0;
        [self addSubview:_bjView];
        
        _bjView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bjViewClick)];
        [_bjView addGestureRecognizer:tap];
        
//        _btnView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, kwidth, 0)];
        
        
        _btnView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bottom, kwidth, 128)];

        _btnView.backgroundColor = [UIColor whiteColor];
        _btnView.alpha = 0;
        [self addSubview:_btnView];
        [self setBtnWithBool:isQuanbu];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kwidth, 0.5)];
        
        lineView.backgroundColor = SetColorWith(226, 226, 226);
        
        [_btnView addSubview:lineView];
        
    }
    
    return self;
}


- (void)setBtnWithBool:(BOOL)isQuanbu{
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kwidth, 64)];
    [btn1 setTitle:@"相机" forState:UIControlStateNormal];
    [btn1.titleLabel setFont:kDefaultFontSize(15)];
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_btnView addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, kwidth, 64)];
    [btn2 setTitle:@"相册" forState:UIControlStateNormal];
    [btn2.titleLabel setFont:kDefaultFontSize(15)];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btnView addSubview:btn2];
    
}

- (void)btnClick:(UIButton *)btn{
    
    if (_customBlock) {
        _customBlock(btn.tag,btn.titleLabel.text,btn);
    }
    
    [self bjViewClick];
    
}
- (void)showViewInView:(UIView *)inView{
//    [inView addSubview:self];
//
//    [UIView animateWithDuration:0.3 animations:^{
//        
//        _bjView.alpha = 0.5;
//        _btnView.alpha = 1;
//        
//    }];
//    
//    [UIView animateWithDuration:.3 delay:.1 usingSpringWithDamping:.6 initialSpringVelocity:.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        
//        _btnView.height = 128;
//        
//    } completion:nil];
    
    
    
    
    [inView addSubview:self];
    self.hidden = NO;
    
    [UIView animateWithDuration:.3 animations:^{
        _bjView.alpha = 0.5;
        _btnView.alpha = 1;
    }];
    
    [UIView animateWithDuration:.3 delay:.1 usingSpringWithDamping:0.6 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _btnView.bottom = kheight - 50;
    } completion:nil];
    
    
//    [UIView animateWithDuration:.3 delay:.2 usingSpringWithDamping:0.6 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        _closeView.bottom = kheight - 10;
//    } completion:nil];

}

- (void)bjViewClick{
    
    
//    [UIView animateWithDuration:0.3 animations:^{
//        
//        [_btnView removeAllSubviews];
//        
//        _btnView.height = 0;
//        _bjView.alpha = 0;
//        _btnView.alpha = 0;
//        
//    } completion:^(BOOL finished) {
//        
//        if (_dismissBlock) {
//            _dismissBlock();
//        }
//        [self removeAllSubviews];
//        [self removeFromSuperview];
//        
//    }];
    
    
    
    [UIView animateWithDuration:.3 delay:.1 usingSpringWithDamping:1 initialSpringVelocity:1 options:.6 animations:^{
        [_btnView removeAllSubviews];

        _btnView.height = 0;
        _bjView.alpha = 0;
        _btnView.alpha = 0;
        
    } completion:^(BOOL finished) {
        if (_dismissBlock) {
            _dismissBlock();
        }
        [self removeAllSubviews];
        [self removeFromSuperview];
    }];
    
    [UIView animateWithDuration:.5 delay:.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        _btnView.top = kheight;
        
    } completion:nil];

}

@end
