//
//  CustomTitleView.h
//  EpicLive
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 liyun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CustomTitleViewBlock) (NSInteger index ,NSString *btnTitle,UIButton *btn);


@interface CustomTitleView : UIView

- (instancetype)initWithClickBlock:(CustomTitleViewBlock)clickBlock dismissBlock:(dispatch_block_t)dismissBlock isQuanBu:(BOOL)isQuanbu;


- (void)showViewInView:(UIView *)view;

@end
