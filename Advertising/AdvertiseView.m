//
//  AdvertiseView.m
//  Tabbar
//
//  Created by apple on 16/6/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AdvertiseView.h"

@interface AdvertiseView ()

@property (nonatomic, strong) UIImageView *adView;

@property (nonatomic, strong) UIButton *countBtn;

@property (nonatomic, strong) NSTimer *countTimer;

@property (nonatomic, assign) int count;


@end

//广告显示时间
static int const showtime = 3;


@implementation AdvertiseView


- (NSTimer *)countTimer{

    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;

}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        //1.广告图片
        
        _adView = [[UIImageView alloc]initWithFrame:frame];
        _adView.userInteractionEnabled = YES;
        _adView.contentMode = UIViewContentModeScaleAspectFill;
        _adView.clipsToBounds = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToAd)];
        [_adView addGestureRecognizer:tap];
        
        //2.跳过按钮
        CGFloat widthV = 60;
        CGFloat heightV = 30;
        
        _countBtn = [[UIButton alloc]initWithFrame:CGRectMake(kwidth - widthV - 24, heightV, widthV, heightV)];
        [_countBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d", showtime] forState:UIControlStateNormal];
        _countBtn.titleLabel.font = kDefaultFontSize(15);
        [_countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_countBtn setBackgroundColor:SetColorWith(153, 153, 153)];
        _countBtn.layer.cornerRadius = 4;
        
        [self addSubview:_adView];
        [self addSubview:_countBtn];
        
    }
    return self;
}
//- (void)setFilePath:(NSString *)filePath
//{
//    _firePath = filePath;
//    _adView.image = [UIImage imageWithContentsOfFile:filePath];
//}

- (void)setFirePath:(NSString *)firePath{

    _firePath = firePath;
    _adView.image = [UIImage imageWithContentsOfFile:firePath];

}

- (void)pushToAd{

    [self dismiss];

    [[NSNotificationCenter defaultCenter]postNotificationName:@"pushtoad" object:nil userInfo:nil];

}
- (void)countDown{

    _count --;
    
    [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d",_count] forState:UIControlStateNormal];
    
    if (_count == 0) {
        [self.countTimer invalidate];
        self.countTimer = nil;
        [self dismiss];
    }

}

- (void)show{
    
    // 倒计时方法1：GCD
    //    [self startCoundown];

    // 倒计时方法2：定时器
    
    [self startTimer];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:self];

}

//定时器倒计时
- (void)startTimer{
    
    _count = showtime;
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
    
}

//GCD倒计时

- (void)startCoundown{

    __block int timeOut = showtime + 1;//倒计时时间 + 1
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);//每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if (timeOut <= 0) {//倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self dismiss];
                
            });
            
        }else{
        
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d",timeOut] forState:UIControlStateNormal];
                
            });
            
            timeOut --;
        }
        
    });
    dispatch_resume(_timer);


}


//移除广告页面
- (void)dismiss{
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.alpha = 0.f;

    }completion:^(BOOL finished) {
        
        [self removeFromSuperview];

    }];

}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




@end
