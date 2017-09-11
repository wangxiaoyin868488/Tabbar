//
//  MOIBaseViewController.m
//  CatClaws
//
//  Created by Andy on 14-11-26.
//  Copyright (c) 2014年 MOI. All rights reserved.
//

#import "MOIBaseViewController.h"
#import "UIImage+Additions.h"
#import "AppDelegate.h"
//#import "MobClick.h"

#import "JGProgressHUDIndeterminateIndicatorView.h"
#import "JGProgressHUDSuccessIndicatorView.h"
#import "JGProgressHUDErrorIndicatorView.h"

@interface MOIBaseViewController ()

@end

@implementation MOIBaseViewController
{
    UILabel *_noMessageTitleLab;
    NSString *_noMessageTitleStr;
    UILabel *_noMessageContentLab;
    UIImageView *_loadMessageImageView;
    
    
    
    UITapGestureRecognizer *_hiddeHead;
    
    long long _rotationAngle;
    
    void(^hideHeadView)();
}

- (void)viewDidLoad;
{
    [super viewDidLoad];
    
    self.view.width = kwidth;
    self.view.height = kheight;
//    self.view.backgroundColor = kColorbackground;
    
//#ifdef __IPHONE_7_0
//    //保证在有NavigationBar的界面开始位置都是NavigationBar左下角
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//#endif
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    _headNavigationView = [[HeadNavigationView alloc] initWithDelegate:self AntTitle:nil AndStyle:kHeadNavigationStyle_deepColor];
    [self.view addSubview:_headNavigationView];
    
#ifdef __IPHONE_7_0
    self.automaticallyAdjustsScrollViewInsets = NO;
#endif
    
    _hiddeHead = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setupHeadViewUI)];
    [self.view addGestureRecognizer:_hiddeHead];
    self.canHiddenHeadNav = NO;
}

-(void)setCanHiddenHeadNav:(BOOL)canHiddenHeadNav{
    _canHiddenHeadNav = canHiddenHeadNav;
    
    _hiddeHead.enabled = _canHiddenHeadNav;
}

-(void)setupHeadViewUI{
    
    [UIView animateWithDuration:.3 animations:^{
        if (self.headNavigationView.top == 0) {
         self.headNavigationView.alpha = 0;
   
            self.headNavigationView.top = -self.headNavigationView.height;
            
            hideHeadView = nil;
        }else{
            self.headNavigationView.alpha = 1;
            self.headNavigationView.top = 0;
            
            __block MOIBaseViewController *_blockSelf = self;
            hideHeadView = ^(){
                [UIView animateWithDuration:.5 animations:^{
                    
                    _blockSelf.headNavigationView.alpha = 0;
                    _blockSelf.headNavigationView.top = -_blockSelf.headNavigationView.height;
                    
                } completion:nil];
            };
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), hideHeadView);
            
        }
    }];
    
    
}

-(void)setUpNoMessageView{
    if (_noMessageView) {
        return;
    }
    
    _noMessageView = [[UIView alloc] initWithFrame:CGRectMake(0, (kheight - 150 ) / 2, kwidth, 150)];
    _noMessageView.backgroundColor = [UIColor clearColor];
    
    _noMessageTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, kwidth, 20)];
    [_noMessageTitleLab setTextColor:SetColorWith(23, 23, 23)];
    [_noMessageTitleLab setTextAlignment:NSTextAlignmentCenter];
    [_noMessageTitleLab setFont:kDefaultFontSize(19)];
    [_noMessageView addSubview:_noMessageTitleLab];
    
    _noMessageContentLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _noMessageTitleLab.bottom + 10, kwidth, 20)];
    _noMessageContentLab.numberOfLines = 0;
    [_noMessageContentLab setTextColor:SetColorWith(102, 102, 102)];
    [_noMessageContentLab setTextAlignment:NSTextAlignmentCenter];
    [_noMessageContentLab setFont:kDefaultFontSize(13)];
    [_noMessageView addSubview:_noMessageContentLab];
    
    [self.view insertSubview:_noMessageView atIndex:0];
    _noMessageView.hidden = YES;
    _noMessageView.userInteractionEnabled = NO;
}

-(void)setNoMessageViewTitle:(NSString *)_tStr AndContent:(NSString *)_cStr{
    if (!_noMessageView) {
        [self setUpNoMessageView];
    }
    _noMessageTitleStr = _tStr;
    [_noMessageTitleLab setText:_noMessageTitleStr];
    [_noMessageContentLab setText:_cStr];
}

- (void)setWaitViewLoading:(BOOL)_isLoading{
    
    if (!_loadMessageImageView) {
        [self setUpNoMessageView];
        
        _loadMessageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kwidth / 2 - 11, 30, 22, 22)];
        [_noMessageView addSubview:_loadMessageImageView];
        [_loadMessageImageView setAnimationImages:@[[UIImage imageNamed:@"缓冲黑1"],
                                                    [UIImage imageNamed:@"缓冲黑1"],
                                                    [UIImage imageNamed:@"缓冲黑2"],
                                                    [UIImage imageNamed:@"缓冲黑3"],
                                                    [UIImage imageNamed:@"缓冲黑4"],
                                                    [UIImage imageNamed:@"缓冲黑5"],
                                                    [UIImage imageNamed:@"缓冲黑6"],
                                                    [UIImage imageNamed:@"缓冲黑6"]]];
        [_loadMessageImageView setAnimationDuration:.25];
    }
    
    if (_noMessageView.hidden) {
        return;
    }
    
    if (_isLoading) {
        [_loadMessageImageView startAnimating];
        _noMessageTitleLab.text = @"努力获取中";
        _noMessageTitleLab.font = kDefaultFontSize(16);
        [_noMessageTitleLab setTextColor:SetColorWith(102, 102, 102)];
    }else{
        [_loadMessageImageView stopAnimating];
        _noMessageTitleLab.text = _noMessageTitleStr;
        _noMessageTitleLab.font = kDefaultBoldFontSize(19);
        [_noMessageTitleLab setTextColor:SetColorWith(23, 23, 23)];
    }
    
    _loadMessageImageView.hidden = !_isLoading;
    _noMessageContentLab.hidden = _isLoading;
}

- (void)btnRight;
{
    
}

- (void)btnHead;{
    
}


// Called when the view is about to made visible. Default does nothing
- (void)viewWillAppear:(BOOL)animated;
{
    [super viewWillAppear:animated];
    [self.headNavigationView changeStyle:self.headNavigationView.myStyle];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

// Called when the view has been fully transitioned onto the screen. Default does nothing
- (void)viewDidAppear:(BOOL)animated;
{
    [super viewDidAppear:animated];
//    [MobClick beginLogPageView:[NSString stringWithFormat:@"%@",[self class]]];
    
}

// Called when the view is dismissed, covered or otherwise hidden. Default does nothing
- (void)viewWillDisappear:(BOOL)animated;
{
    [super viewWillDisappear:animated];
    
//    [MobClick endLogPageView:[NSString stringWithFormat:@"%@",[self class]]];
}

// Called after the view was dismissed, covered or otherwise hidden. Default does nothing
//- (void)viewDidDisappear:(BOOL)animated;
//{
//    [super viewDidAppear:animated];
//}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"didReceiveMemoryWarning : ----------%@--------",[self class]);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%@ dealloc",[self class]);
}

// 初始化视图
- (void)setupViews
{
    // 初始化标题，左右按钮
    // 初始化其他视图
}


- (void)setupParams
{
    
}

- (void)mainTabBarFirstSelect
{
    
}

-(void)showProgressViewWithText:(NSString *)string
{
    [self showProgressViewWithText:string AndIndicatorEunm:kMOIIndicatorEnum_Error];
}

-(void)showProgressViewWithText:(NSString *)string AndIndicatorEunm:(kMOIIndicator)_enum
{
    JGProgressHUD *_p = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleLight];
    _p.textLabel.text = string;
    
    switch (_enum) {
            
        case kMOIIndicatorEnum_Success:
            [_p setIndicatorView:[[JGProgressHUDSuccessIndicatorView alloc] init]];
            break;
            
        case kMOIIndicatorEnum_Error:
            [_p setIndicatorView:[[JGProgressHUDErrorIndicatorView alloc] init]];
            break;
            
        default:
            [_p setIndicatorView:[[JGProgressHUDIndeterminateIndicatorView alloc] initWithHUDStyle:JGProgressHUDStyleLight]];
            break;
    }
    
    [_p setInteractionType:JGProgressHUDInteractionTypeBlockTouchesOnHUDView];
    [_p showInView:self.view animated:YES];
    [_p dismissAfterDelay:1.5 animated:YES];
    
//    NSString *_styleName;
//    switch (_enum) {
//        case kMOIIndicatorEnum_Error:
//            _styleName = @"JDStatusBarStyleError";
//            break;
//            
//        case kMOIIndicatorEnum_Error:
//            _styleName = @"JDStatusBarStyleWarning";
//            break;
//            
//        case kMOIIndicatorEnum_Success:
//            _styleName = @"JDStatusBarStyleSuccess";
//            break;
//            
//        case kMOIIndicatorEnum_Matrix:
//            _styleName = @"JDStatusBarStyleMatrix";
//            break;
//            
//        case kMOIIndicatorEnum_Process:
//            _styleName = @"JDStatusBarStyleDark";
//            break;
//            
//        default:
//            break;
//    }
//    
//    [JDStatusBarNotification showWithStatus:string styleName:_styleName];
//    [JDStatusBarNotification dismissAfter:1.5];
}

-(void)insertProgressViewForText:(NSString *)string{
    if (!_progress) {
        _progress = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleLight];
        [_progress setIndicatorView:[[JGProgressHUDIndeterminateIndicatorView alloc] initWithHUDStyle:JGProgressHUDStyleLight]];
        [_progress setInteractionType:JGProgressHUDInteractionTypeBlockTouchesOnHUDView];
    }
    _progress.textLabel.text = string;
    
    if (!_progress.superview) {
        [_progress showInView:self.view animated:YES];
    }
}

-(void)editProgressViewForText:(NSString *)string{
//    [JDStatusBarNotification showWithStatus:string];
    
    if (_progress) {
        [self editProgressViewForText:string AndIndicatorEunm:kMOIIndicatorEnum_Indeterminate];
    }else{
        [self insertProgressViewForText:string];
    }
}

-(void)editProgressViewForText:(NSString *)string AndIndicatorEunm:(kMOIIndicator)_enum {
    
//    [self showProgressViewWithText:string AndIndicatorEunm:_enum];
    
    if (_progress) {
        _progress.textLabel.text = string;
    }else{
        [self insertProgressViewForText:string];
    }
    switch (_enum) {
        case kMOIIndicatorEnum_Indeterminate:
            [_progress setIndicatorView:[[JGProgressHUDIndeterminateIndicatorView alloc] initWithHUDStyle:JGProgressHUDStyleLight]];
            break;
            
        case kMOIIndicatorEnum_Success:
            [_progress setIndicatorView:[[JGProgressHUDSuccessIndicatorView alloc] init]];
            break;
            
        case kMOIIndicatorEnum_Error:
            [_progress setIndicatorView:[[JGProgressHUDErrorIndicatorView alloc] init]];
            break;
            
        default:
            break;
    }
}

-(void)removeProgressView{
    if (_progress) {
        [_progress dismiss];
        _progress = nil;
    }
}
-(void)removeProgressViewForAfterDelay:(NSTimeInterval)delay Completion:(void(^)())_Completion{

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (_progress) {
                [_progress dismiss];
                _progress = nil;
            }
        
//        [JDStatusBarNotification dismiss];
        if (_Completion) {
            _Completion();
        }
    });
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

@end
