//
//  MOIPromptView.h
//  EpicLive
//
//  Created by apple on 16/8/10.
//  Copyright © 2016年 liyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MOIPromptView : UIView

@property (weak, nonatomic) IBOutlet UIButton *rightNowBtn;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIView *fatherView;
@property (weak, nonatomic) IBOutlet UIView *bjView;
@property (weak, nonatomic) IBOutlet UILabel *promptLabel;


@property (strong , nonatomic) NSDictionary  *dictR;
@property (copy) void(^rightNowBtnClick)(NSDictionary *);




+ (instancetype)promptView;

- (void)setPromptViewWithMisstopic:(int)misstopicNum missdate:(int)missdateNum;

- (void)willShowSelfInView:(UIView *)_view;

@end
