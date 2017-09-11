//
//  HeadNavigationController.m
//  beibeiCollect
//
//  Created by moi on 14-5-4.
//  Copyright (c) 2014年 liyun. All rights reserved.
//


#define SetColorWith(x,y,z) [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1]

#import "HeadNavigationView.h"
#import "MOIReadHintView.h"
#import "UIView+DDAddition.h"

//#import "MessagePageMainViewController.h"

@implementation HeadNavigationView
{
    UIView *_lineView;
    UIButton *_headBtnLeft;
    UIActivityIndicatorView * _indecateView;
    
    MOIReadHintView *_hintView;
                 
    UITapGestureRecognizer *_headTapGesture;
    
    int _selfActivityReturnCount;
    
    NSString *_titleStr;
    
    BOOL _rightEnabled;
}

//Style
- (instancetype)initWithDelegate:(UIViewController *)_delegate AntTitle:(NSString *)_strTitle AndStyle:(kHeadNavigationStyleEnum)_styleEnum ;
{
    _rightEnabled = NO;
    int statusHigh = ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? 20 : 0);
    
    self = [super initWithFrame:CGRectMake(0,0, kwidth, statusHigh + 45)];
    if (self) {
        
        self.selfDelegate = _delegate;
        
        _lineView = [UIView lineViewForColor:[UIColor clearColor] AndFrame:CGRectMake(0, self.height - .5, kwidth, .5)];
        [self addSubview:_lineView];
        
        _headBtnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        [_headBtnLeft setAdjustsImageWhenHighlighted:NO];
        [_headBtnLeft.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_headBtnLeft addTarget:self action:@selector(btnLeft) forControlEvents:UIControlEventTouchUpInside];
        [_headBtnLeft setFrame:CGRectMake(0, self.height - 44, 40, 44)];
        [_headBtnLeft setImage:[UIImage imageNamed:@"导航返回icon"] forState:UIControlStateNormal];
//        [_headBtnLeft setImage:[UIImage imageNamed:@"返回按下"] forState:UIControlStateHighlighted];
        
        [self addSubview:_headBtnLeft];
        
        _headBtnRight = [UIButton buttonWithType:UIButtonTypeCustom];
        _headBtnRight.layer.cornerRadius = 2;
        _headBtnRight.clipsToBounds = YES;
        [_headBtnRight.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_headBtnRight addTarget:self action:@selector(btnRight) forControlEvents:UIControlEventTouchUpInside];
        [_headBtnRight setFrame:CGRectMake(self.width - 56, self.height - 45, 55, 45)];
        
        _titleStr = _strTitle;
//        CGSize size= [LYUtils labSizeWithStr:_titleStr font:kDefaultBoldFontSize(17) labWidth:200];
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(80, self.height - 35, kwidth - (80 * 2), 25)];
        _titleLab.numberOfLines = 1;
        _titleLab.backgroundColor = [UIColor clearColor];
        [_titleLab setFont:[UIFont systemFontOfSize:17]];
        [_titleLab setTextAlignment:NSTextAlignmentCenter];
        [_titleLab setText:_titleStr];
        _titleLab.userInteractionEnabled = YES;
        [self addSubview:_titleLab];
        
        _indecateView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(_titleLab.left -30,_titleLab.top, 30, 25)];
        [_indecateView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
        [self addSubview:_indecateView];
        
        _headTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnHead)];
        [_headTapGesture setNumberOfTapsRequired:2];
        [_headTapGesture setNumberOfTouchesRequired:1];
        [_titleLab addGestureRecognizer:_headTapGesture];
        
        [self changeStyle:_styleEnum];
    }
    return self;
}

-(void)changeStyle:(kHeadNavigationStyleEnum)_style{
    self.myStyle = _style;
    switch (_myStyle) {
        case kHeadNavigationStyle_white:
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
            
            self.backgroundColor = SetColorWith(246, 246, 246);
            _titleLab.textColor = SetColorWith(71, 71, 71);
            _lineView.backgroundColor = SetColorWith(176, 176, 176);
            
            if (!_rightEnabled) {
               [_headBtnRight setTitleColor:SetColorWith(70, 70, 70) forState:UIControlStateNormal];
            }
            
            [_headBtnLeft setTitleColor:SetColorWith(70, 70, 70) forState:UIControlStateNormal];
            break;
            
        case kHeadNavigationStyle_deepColor:
        default:
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
            
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.8];
            _titleLab.textColor = [UIColor whiteColor];
            
            if (!_rightEnabled) {
                [_headBtnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            
            [_headBtnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
    }
}

-(void)setupRightEnabled:(BOOL)_enabled{
//    [_headBtnRight setEnabled:_enabled];
    _rightEnabled = YES;
    
    _headBtnRight.top = 27;
    _headBtnRight.height = 25;
    [_headBtnRight.titleLabel setFont:kDefaultFontSize((_enabled ? 14 : 13))];
    [_headBtnRight setTitleColor:(_enabled ? [UIColor whiteColor] : SetColorWith(153, 153, 153)) forState:UIControlStateNormal];
    [_headBtnRight setBackgroundColor:(_enabled ? SetColorWith(23, 23, 23) : [UIColor clearColor])];
}

- (void)setupHintView{
    if (!_hintView) {
        _hintView = [MOIReadHintView readHintViewWithCenterPoint:CGPointMake(kwidth - 15, 32)];
        [_hintView setIsShine:YES];
        [self addSubview:_hintView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messagePageUnReadCountChange:) name:@"MessagePageUnReadCountChange" object:nil];
//        [[MessagePageMainViewController sharedInstance] loadUnReadCount];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MessagePageUnReadCountChange" object:nil];
}
-(void)messagePageUnReadCountChange:(NSNotification *)_not
{
    if (_not.object) {
//        [_hintView setNumberInt:[_not.object intValueForKey:@"unReadCount"]];
    }
}

-(void)changeHintViewCount:(int)_count{
    if (_hintView) {
        [_hintView setNumberInt:_count];
    }
}

- (void)setTitle:(NSString *)title
{
    if (![_titleStr isEqualToString:title]) {
        _titleStr = title;
//        CGSize size= [LYUtils labSizeWithStr:_titleStr font:kDefaultBoldFontSize(18) labWidth:200];
//        [_titleLab setFrame:CGRectMake((kwidth/2 -size.width/2), self.height - 37, size.width, 25)];
        [_titleLab setFrame:CGRectMake(80, self.height - 35, kwidth - (80 * 2), 25)];
        [_titleLab setText:_titleStr];
        [_indecateView setFrame:CGRectMake(_titleLab.left -30,_titleLab.top, 30, 25)];
        if (_indecateView.left <= 0 || (_indecateView.left < _headBtnLeft.right && _headBtnLeft.hidden == NO)) {
            _indecateView.hidden = YES;
        }
    }
}

-(void)btnLeft{
    if (_selfDelegate) {
        if ([_selfDelegate respondsToSelector:@selector(btnLeft)]) {
            [((id)_selfDelegate) btnLeft];
        }else{
            [_selfDelegate.navigationController popViewControllerAnimated:YES];
        }
    }
}
-(void)btnRight{
    if (_selfDelegate) {
        if ([_selfDelegate respondsToSelector:@selector(btnRight)]) {
            [((id)_selfDelegate) btnRight];
        }else{
            NSLog(@"--- not @selector(btnRight) by %@",[_selfDelegate class]);
        }
    }
}
-(void)btnHead{
    if (_selfDelegate) {
        if ([_selfDelegate respondsToSelector:@selector(btnHead)]) {
            [((id)_selfDelegate) btnHead];
        }else{
            NSLog(@"--- not @selector(btnHead) by %@",[_selfDelegate class]);
        }
    }
}

-(void)setupLeftStr:(NSString *)_strLeft {
    if (!_strLeft) {
        return;
    }
    CGSize _size = [_strLeft sizeWithAttributes:@{NSFontAttributeName:kDefaultBoldFontSize(16)}];
    [_headBtnLeft setImage:nil forState:UIControlStateNormal];
    [_headBtnLeft setImage:nil forState:UIControlStateHighlighted];
    
    [_headBtnLeft setFrame:CGRectMake(0, self.height - 44, _size.width + 20, 44)];
    [_headBtnLeft setTitle:_strLeft forState:UIControlStateNormal];
    [self addSubview:_headBtnLeft];
}

-(void)setupLeftImage:(UIImage *)_img{
    _headBtnLeft.hidden = NO;
    [_headBtnLeft setImage:_img forState:UIControlStateNormal];
    [_headBtnLeft setImage:_img forState:UIControlStateHighlighted];
    
    [_headBtnLeft setTitle:nil forState:UIControlStateNormal];
    
    if (!_headBtnLeft.superview) {
        [self addSubview:_headBtnLeft];
    }
}

-(void)setupLeftImage:(UIImage *)_img newRect:(CGRect)_rect{
    
    [_headBtnLeft setFrame:_rect];
    [self setupLeftImage:_img];
    
}

-(void)setupRightImage:(UIImage *)_img {
    if (!_img) {
        return;
    }
    
    _headBtnRight.hidden = NO;
    [_headBtnRight setImage:_img forState:UIControlStateNormal];
    [_headBtnRight setImage:_img forState:UIControlStateHighlighted];
    
    [_headBtnRight setTitle:nil forState:UIControlStateNormal];
    
    if (!_headBtnRight.superview) {
        [self addSubview:_headBtnRight];
    }
}

-(void)setupRightStr:(NSString *)_strRight {
    if (!_strRight) {
        return;
    }
    CGSize _size = [_strRight sizeWithAttributes:@{NSFontAttributeName:kDefaultBoldFontSize(16)}];
    int btnWidth = _size.width + 5;
    [_headBtnRight setFrame:CGRectMake(kwidth - 8 - btnWidth, self.height - 44, btnWidth, 44)];
    [_headBtnRight setTitle:_strRight forState:UIControlStateNormal];
    _headBtnRight.hidden = NO;
    
    if (!_headBtnRight.superview) {
        [self addSubview:_headBtnRight];
    }
//    if (btnWidth > 57) {
//        int labMaxWidth = kwidth - (btnWidth * 2) -10;
//        
//        int newLabSize = MIN(_titleLab.width, labMaxWidth);
//        [_titleLab setFrame:CGRectMake(btnWidth +(labMaxWidth/2- newLabSize/2), self.height - 35, newLabSize, 25)];
//    }
}

-(void)showActivityIndicatorView{
    if (_selfActivityReturnCount == 0) {
        _indecateView.hidden = NO;
        [_indecateView startAnimating];
    }
    _selfActivityReturnCount ++;
}
-(void)hiddenActivityIndicatorView{
    _selfActivityReturnCount --;
    if (_selfActivityReturnCount == 0) {
        _indecateView.hidden = YES;
        [_indecateView stopAnimating];
    }
}

- (void)hideLeftBtn:(BOOL)hidden
{
    _headBtnLeft.hidden = hidden;
}

- (void)hideRightBtn:(BOOL)hidden
{
    _headBtnRight.hidden = hidden;
}

@end
