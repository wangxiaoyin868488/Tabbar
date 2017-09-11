//
//  MOIReadHintView.m
//  CatClaws
//
//  Created by moi on 14-12-6.
//  Copyright (c) 2014年 MOI. All rights reserved.
//

#define kheight ([UIScreen mainScreen].bounds.size.height)
#define kwidth ([UIScreen mainScreen].bounds.size.width)

#import "MOIReadHintView.h"
#import "UIView+DDAddition.h"

@implementation MOIReadHintView
{
    UIView *_backgroundView;
    
    UILabel *_numberLab;
    
    int _shineNumber;
    NSTimer *_shineTimer;
}

#define kNumberLabTop 1.5

+ (MOIReadHintView *)readHintViewWithCenterPoint:(CGPoint)_point
{
    return [[MOIReadHintView alloc] initWithFrame:CGRectMake(_point.x - 10, _point.y - 7, 10, 10)];
}

+ (MOIReadHintView *)readHintViewWithTopLeftPoint:(CGPoint)_point
{
    return [[MOIReadHintView alloc] initWithFrame:CGRectMake(_point.x, _point.y + 3, 10, 10)];
}
- (void)dealloc
{
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
//        _backgroundView.backgroundColor = SetColorWith(237, 78, 23);
        _backgroundView.backgroundColor = [UIColor yellowColor];
        
        _backgroundView.layer.cornerRadius = 5;
        _backgroundView.clipsToBounds = YES;
        _backgroundView.hidden = YES;
        [self addSubview:_backgroundView];
        
        _numberLab = [[UILabel alloc] initWithFrame:CGRectMake(0, kNumberLabTop, self.width, 10)];
//        [_numberLab setFont:kDefaultBoldFontSize(10)];
        [_numberLab setFont:[UIFont boldSystemFontOfSize:10]];

        [_numberLab setTextColor:[UIColor whiteColor]];
        [_numberLab setTextAlignment:NSTextAlignmentCenter];
        _numberLab.hidden = YES;
        [self addSubview:_numberLab];
    }
    return self;
}

//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}

-(void)setNumberInt:(NSInteger)numberInt{
    
    _numberInt = numberInt;
    if (_numberInt > 99) {
        _numberInt = 99;
        _numberLab.text = [NSString stringWithFormat:@"%lu+",_numberInt];
    }else{
        _numberLab.text = [NSString stringWithFormat:@"%lu",_numberInt];
    }
    [self updateBackgroundView];
}

-(void)setIsCanPoint:(BOOL)isCanPoint{
    
    _isCanPoint = isCanPoint;
    
    [self updateBackgroundView];
}

-(void)setIsShine:(BOOL)isShine{
    
    _isShine = isShine;
    
    if (_isShine) {
        _shineNumber = 3;
        if (![_shineTimer isValid]) {
            _shineTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(shineTimeDown:) userInfo:nil repeats:YES];
        }
    }else{
        if ([_shineTimer isValid]) {
            [_shineTimer invalidate];
        }
    }
}

-(void)shineTimeDown:(NSTimer *)_timer{
    _shineNumber --;
    
    if (_shineNumber < 0) {
        
        [UIView animateWithDuration:.1 animations:^{
            self.transform = CGAffineTransformMakeScale(1.4, 1.4);
            self.left = self.left - 1.5;
            self.top = self.top - 1.5;
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:.6 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                self.transform = CGAffineTransformMakeScale(1, 1);
                self.left = self.left + 1.5;
                self.top = self.top + 1.5;
                
            } completion:^(BOOL finished) {
                
            }];
            
        }];
        
        _shineNumber = 3;
    }
}

-(void)updateBackgroundView{
    
//    dispatch_async(dispatch_get_main_queue(), ^{
        if (_numberInt < 1) { //不显示数字时
            _numberLab.hidden = YES;
            
            //判断是否显示小红点
            if (_isCanPoint) {
                
                CGRect newRect = CGRectMake(0, 0, 8, 8);
                
                if (!CGRectEqualToRect(_backgroundView.bounds, newRect)) {
                    [UIView animateWithDuration:.2 animations:^{
                        
                        [_backgroundView setFrame:newRect];
                        _backgroundView.hidden = NO;
                        
                        if (_backgroundView.layer.cornerRadius == 10) {
                            _backgroundView.layer.cornerRadius = 7;
                        }
                        
                    } completion:^(BOOL finished) {
                        _backgroundView.layer.cornerRadius = 4;
                    }];
                }else{
                    _backgroundView.hidden = NO;
                    _backgroundView.layer.cornerRadius = 4;
                }
                
            }else{
                if (_backgroundView.hidden == NO) {
                    [UIView animateWithDuration:.2 animations:^{
                        _backgroundView.hidden = YES;
                    }];
                }
            }
            
        }else{
            //需要显示数字时
            
            if (_numberInt > 9) {
                CGRect newRect = CGRectMake(0, 0, 21, 13);
                if (!CGRectEqualToRect(_backgroundView.bounds, newRect)) {
                    [UIView animateWithDuration:.2 animations:^{
                        
                        [_numberLab setFrame:CGRectMake(0, kNumberLabTop, newRect.size.width, 10)];
                        [_backgroundView setFrame:newRect];
                        _backgroundView.hidden = NO;
                        _numberLab.hidden = NO;
                        if (_backgroundView.layer.cornerRadius == 4) {
                            _backgroundView.layer.cornerRadius = 6;
                        }
                        
                    } completion:^(BOOL finished) {
                        _backgroundView.layer.cornerRadius = 6.5;
                    }];
                }
            }
            else
            {
                CGRect newRect = CGRectMake(0, 0, 17, 13);
                if (!CGRectEqualToRect(_backgroundView.bounds, newRect)) {
                    [UIView animateWithDuration:.2 animations:^{
                        
                        [_numberLab setFrame:CGRectMake(0, kNumberLabTop, newRect.size.width, 10)];
                        [_backgroundView setFrame:newRect];
                        _backgroundView.hidden = NO;
                        _numberLab.hidden = NO;
                        if (_backgroundView.layer.cornerRadius == 4) {
                            _backgroundView.layer.cornerRadius = 6;
                        }
                        
                    } completion:^(BOOL finished) {
                        _backgroundView.layer.cornerRadius = 6.5;
                    }];
                }else{
                    _backgroundView.hidden = NO;
                    _backgroundView.layer.cornerRadius = 6.5;
                    
                    _numberLab.hidden = NO;
                }
            }
        }
//    });
    
}

@end
