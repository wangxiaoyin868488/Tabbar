//
//  MOIPromptView.m
//  EpicLive
//
//  Created by apple on 16/8/10.
//  Copyright © 2016年 liyun. All rights reserved.
//

#import "MOIPromptView.h"

@implementation MOIPromptView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    
    self.fatherView.layer.cornerRadius = 3;
    self.fatherView.clipsToBounds = YES;
    
//    UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSelf)];
//    [self.bjView addGestureRecognizer:_tap];
}

- (void)setPromptViewWithMisstopic:(int)misstopicNum missdate:(int)missdateNum{
    

    UIFont *_titlefont = kDefaultFontSize(13);
    NSString *_dataNumStr = [NSString stringWithFormat:@"%zd",missdateNum];
    NSString *_topicNumStr = [NSString stringWithFormat:@"%zd",misstopicNum];
    
//    NSString * cLabelString = [NSString stringWithFormat:@"你没来的这%@天里，错过了不少新毒物。毒编特地为你筛选了%@篇最毒文。",_dataNumStr,_topicNumStr];
    _promptLabel.text = [NSString stringWithFormat:@"你没来的这%@天里，错过了不少新毒物。毒编特地为你筛选了%@篇最毒文。",_dataNumStr,_topicNumStr];
    
//    int lineSpacing = 6;
//    
//    NSMutableAttributedString * attributedString1;
//    if (cLabelString) {
//        attributedString1 = [[NSMutableAttributedString alloc] initWithString:cLabelString];
//        CGSize _labSize = [LYUtils labSizeWithStr:cLabelString font:_titlefont labWidth:self.width - 60 lineSpacing:6 numberOfLines:2];
//        if (_labSize.height < 30) {
//            lineSpacing = 0;
//        }
//    }
//    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle1 setLineSpacing:lineSpacing];
//    
//    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [cLabelString length])];
//    [attributedString1 addAttribute:NSForegroundColorAttributeName value:SetColorWith(23, 23, 23) range:NSMakeRange(0, attributedString1.length)];
//    [attributedString1 addAttribute:NSForegroundColorAttributeName value:SetColorWith(237, 78, 23) range:NSMakeRange(5, _dataNumStr.length)];
//    [attributedString1 addAttribute:NSForegroundColorAttributeName value:SetColorWith(237, 78, 23) range:NSMakeRange(attributedString1.length - _topicNumStr.length - 5, _topicNumStr.length)];
//    
//    [_promptLabel setAttributedText:attributedString1];
    [_promptLabel setFont:_titlefont];
//
//    _promptLabel.textAlignment = NSTextAlignmentCenter;
    
}



- (IBAction)rightNowBtnClick:(UIButton *)sender {
    
    if (_rightNowBtnClick) {
        _rightNowBtnClick(_dictR);
    }
    [self dismissSelf];
}

- (IBAction)closeBtnClick:(UIButton *)sender {
    
    [self dismissSelf];
    
}

-(void)willShowSelfInView:(UIView *)_view{
    
    _bjView.alpha = 0;
    _fatherView.alpha = 0;
    _fatherView.transform = CGAffineTransformMakeScale(.5, .5);
    [_view addSubview:self];
    
    [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _bjView.alpha = 1;
        _fatherView.alpha = 1;
        _fatherView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)dismissSelf{
    [UIView animateWithDuration:.3 animations:^{
        _bjView.alpha = 0;
        _fatherView.alpha = 0;

    } completion:^(BOOL finished) {
        
        [self removeAllSubviews];
        [self removeFromSuperview];
    }];
}


+ (instancetype)promptView{
    return [[[NSBundle mainBundle]loadNibNamed:@"MOIPromptView" owner:nil options:nil] lastObject];
}


@end
