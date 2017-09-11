//
//  FootNavBtn.m
//  EpicLive
//
//  Created by moi on 15/8/12.
//  Copyright (c) 2015年 liyun. All rights reserved.
//

#import "FootNavView.h"
#import "UIView+DDAddition.h"

typedef enum : NSUInteger {
    FootNavAnimate_boost,
    FootNavAnimate_changeImg,
} FootNavAnimateEnum;

@implementation FootNavView
{
    UIImageView *_showImageView;
    UILabel *_showLabel;
    
    BOOL _isSelect;
    
    UIImage *_normalImage;
    UIImage *_highlightedImage;
    
    FootNavAnimateEnum _footNavAnimateEnum;
}

#define kMakeScale 1.15

- (instancetype)initWithFrame:(CGRect)frame Image:(UIImage *)_image Title:(NSString *)_title
{
    self = [super initWithFrame:frame];
    if (self) {
        _isSelect = NO;
        
        _showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 28, 29)];
        _showImageView.centerX = frame.size.width / 2;
        _showImageView.backgroundColor = [UIColor clearColor];
        [_showImageView setContentMode:UIViewContentModeScaleAspectFit];
        [_showImageView setImage:_image];
        [self addSubview:_showImageView];
        
        _showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 13, frame.size.width, 10)];
        [_showLabel setTextAlignment:NSTextAlignmentCenter];
        _showLabel.backgroundColor = [UIColor clearColor];
//        [_showLabel setFont:kDefaultFontSize(10)];
        [_showLabel setFont:[UIFont systemFontOfSize:10]];

        
        _showLabel.text = _title;
        [self addSubview:_showLabel];
        
        UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer)];
        [self addGestureRecognizer:_tap];
        self.userInteractionEnabled = YES;
        
        _footNavAnimateEnum = FootNavAnimate_boost;
    }
    return self;
}

-(void)animationSelect_boost{
    
    if (_isSelect) {
        return;
    }
    
    _isSelect = YES;
    
    [_showImageView.layer removeAllAnimations];
    
    
    
    [UIView animateWithDuration:.2 animations:^{
        _showLabel.alpha = 0;
        _showImageView.centerY = self.height / 2;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:.7 delay:0 usingSpringWithDamping:.6 initialSpringVelocity:.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            _showImageView.transform = CGAffineTransformMakeScale(kMakeScale, kMakeScale);
            
        } completion:^(BOOL finished) {
            if (_isSelect) {
                if (_showLabel.alpha != 0 || _showImageView.centerY != self.height / 2 || !CGAffineTransformEqualToTransform(_showImageView.transform , CGAffineTransformMakeScale(kMakeScale, kMakeScale))) {
                    [UIView animateWithDuration:.2 animations:^{
                        _showImageView.transform = CGAffineTransformMakeScale(kMakeScale, kMakeScale);
                        _showLabel.alpha = 0;
                        _showImageView.centerY = self.height / 2;
                    }];
                }
            }
        }];
    }];
}

-(void)animationUnselected_boost{
    
    if (!_isSelect) {
        return;
    }
    
    _isSelect = NO;
    
    [_showImageView.layer removeAllAnimations];
    [UIView animateWithDuration:.2 animations:^{
        _showImageView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:.2 animations:^{
            _showLabel.alpha = 1;
            _showImageView.top = 3;
        } completion:^(BOOL finished) {
            
            if (!_isSelect) {
                if (_showLabel.alpha != 1 || _showImageView.top != 3 || !CGAffineTransformEqualToTransform(_showImageView.transform , CGAffineTransformMakeScale(1, 1)) ) {
                    [UIView animateWithDuration:.2 animations:^{
                        _showImageView.transform = CGAffineTransformMakeScale(1, 1);
                        _showLabel.alpha = 1;
                        _showImageView.top = 3;
                    }];
                }
            }
            
        }];
    }];
}


-(void)tapGestureRecognizer{
    
    if (_selectFootNavBtn) {
        _selectFootNavBtn(self);
    }
    
    switch (_footNavAnimateEnum) {
        case FootNavAnimate_boost:
            [self animationSelect_boost];
            break;
            
        case FootNavAnimate_changeImg:
            [self animationSelect_changeImg];
            break;
            
        default:
            break;
    }
    
}

-(void)setBtnSelect:(BOOL)_select{
    
    
    if (_select) {
        [self tapGestureRecognizer];
    }else{
        switch (_footNavAnimateEnum) {
            case FootNavAnimate_boost:
                [self animationUnselected_boost];
                break;
                
            case FootNavAnimate_changeImg:
                [self animationUnselected_changeImg];
                break;
                
            default:
                break;
        }
    }
    
}


- (instancetype)initWithFrame:(CGRect)frame Image:(UIImage *)_image highlightedImge:(UIImage *)_himage;
{
    self = [super initWithFrame:frame];
    if (self) {
        _isSelect = NO;
        
        _normalImage = _image;
        _highlightedImage = _himage;
        
        _showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 33, 49)];
        _showImageView.centerX = frame.size.width / 2;
        _showImageView.backgroundColor = [UIColor clearColor];
        [_showImageView setContentMode:UIViewContentModeScaleAspectFit];
        [_showImageView setImage:_normalImage];
        [self addSubview:_showImageView];
        
        UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer)];
        [self addGestureRecognizer:_tap];
        self.userInteractionEnabled = YES;
        
        _footNavAnimateEnum = FootNavAnimate_changeImg;
    }
    return self;
}

-(void)animationSelect_changeImg{
    
    [UIView animateWithDuration:.1 animations:^{
        _showImageView.transform = CGAffineTransformMakeScale(.8, .8);
    } completion:^(BOOL finished) {
        [_showImageView setImage:_highlightedImage];
       [UIView animateWithDuration:.2 delay:0 usingSpringWithDamping:.6 initialSpringVelocity:.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
           _showImageView.transform = CGAffineTransformMakeScale(1, 1);
       } completion:^(BOOL finished) {
           
       }];
    }];
}

-(void)animationUnselected_changeImg{
    [_showImageView setImage:_normalImage];
}

@end
