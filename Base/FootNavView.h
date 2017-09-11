//
//  FootNavBtn.h
//  EpicLive
//
//  Created by moi on 15/8/12.
//  Copyright (c) 2015年 liyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FootNavView : UIView

@property (copy) void(^selectFootNavBtn)(FootNavView *footNavBtnSelf);

- (instancetype)initWithFrame:(CGRect)frame Image:(UIImage *)_image Title:(NSString *)_title;
- (instancetype)initWithFrame:(CGRect)frame Image:(UIImage *)_image highlightedImge:(UIImage *)_himage;

- (void)setBtnSelect:(BOOL)_select;

@end
