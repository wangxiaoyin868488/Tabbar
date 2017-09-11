//
//  JGProgressHUDIndeterminateIndicatorView.m
//  JGProgressHUD
//
//  Created by Jonas Gessner on 19.07.14.
//  Copyright (c) 2014 Hardtack. All rights reserved.
//

#import "JGProgressHUDIndeterminateIndicatorView.h"

@implementation JGProgressHUDIndeterminateIndicatorView

- (instancetype)initWithHUDStyle:(JGProgressHUDStyle)style {
//    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    [activityIndicatorView startAnimating];
//    self = [super initWithContentView:activityIndicatorView];
//    
//    if (self) {
//        if (style != JGProgressHUDStyleDark) {
//            self.color = [UIColor blackColor];
//        }
//    }
    
    UIImageView *_animatingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [_animatingImageView setAnimationImages:@[[UIImage imageNamed:@"缓冲1"],
                                       [UIImage imageNamed:@"缓冲1"],
                                       [UIImage imageNamed:@"缓冲2"],
                                       [UIImage imageNamed:@"缓冲3"],
                                       [UIImage imageNamed:@"缓冲4"],
                                       [UIImage imageNamed:@"缓冲5"],
                                       [UIImage imageNamed:@"缓冲6"],
                                       [UIImage imageNamed:@"缓冲6"]]];
    [_animatingImageView setAnimationDuration:.25];
    [_animatingImageView startAnimating];
    
    self = [super initWithContentView:_animatingImageView];
    
    return self;
}

- (instancetype)init {
    return [self initWithHUDStyle:0];
}

- (void)setColor:(UIColor *)color {
    [(UIActivityIndicatorView *)self.contentView setColor:color];
}

@end
