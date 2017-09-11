//
//  MainTabbarController.m
//  Tabbar
//
//  Created by apple on 16/5/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MainTabbarController.h"
#import "Tabbar1Controller.h"
#import "Tabbar2Controller.h"
#import "Tabbar3Controller.h"
#import "Tabbar4Controller.h"

#import "MOIBaseViewController.h"
#import "UIView+DDAddition.h"
#import "FootNavView.h"
#import "MOIReadHintView.h"



#import "VideoPlayerController.h"
#import "AppDelegate.h"

#define ApplicationDelegate   ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface MainTabbarController ()

@end

@implementation MainTabbarController{
    
    UIView *_footView;
    NSInteger _selectViewNumber;
    UIView *_mainHeadView;

    
    NSMutableArray *_btnArray;
    NSMutableArray *_hintArray;

}

- (void)viewDidLoad {
    [super viewDidLoad];

    _showInterestSelectViewController = YES;
    [self initUi];
    
}


-(void)btnHead{
    MOIBaseViewController *_vc = (MOIBaseViewController *)self.selectedViewController;
    if ([_vc respondsToSelector:@selector(mainTabBarSelectAgain)]) {
        [_vc mainTabBarSelectAgain];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//-(void)awakeFromNib
//{
//    [super awakeFromNib];
//    self.selectedIndex = 2;
//}
//
//// 哪些页面支持自动转屏
//- (BOOL)shouldAutorotate{
//    
////    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
//    UINavigationController *nav = self.viewControllers[self.selectedIndex];
//    
//    // MoviePlayerViewController这个页面支持自动转屏
//    if ([nav.topViewController isKindOfClass:[VideoPlayerController class]]) {
//        return !ApplicationDelegate.isLockScreen;  // 调用AppDelegate单例记录播放状态是否锁屏
//    }
//    return NO;
//}
//
//// viewcontroller支持哪些转屏方向
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    
////    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
//    UINavigationController *nav = self.viewControllers[self.selectedIndex];
//    
//    if ([nav.topViewController isKindOfClass:[VideoPlayerController class]]) { // VideoPlayerController这个页面支持转屏方向
//        return UIInterfaceOrientationMaskAllButUpsideDown;
//    }else { // 其他页面支持转屏方向
//        return UIInterfaceOrientationMaskPortrait;
//    }
//    return UIInterfaceOrientationMaskPortrait;
//}
//



- (void)initUi{

    [self.tabBar setHidden:YES];
    
    _footView = [[UIView alloc]initWithFrame:CGRectMake(0, kheight - 49, kwidth, 49)];
    _footView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.8];
    [self.view addSubview:_footView];
    
    _selectViewNumber = 0;
    _btnArray = [NSMutableArray new];
    _hintArray = [NSMutableArray new];

    
    for (int i = 0 ; i < 4; i++) {
        
        UIImage *_image;
        UIImage *_highlightedImge;
        switch (i) {
            case 0:
                _image = [UIImage imageNamed:@"首页icon"];
                _highlightedImge = [UIImage imageNamed:@"首页选中icon"];
                break;
            case 1:
                _image = [UIImage imageNamed:@"晒物icon"];
                _highlightedImge = [UIImage imageNamed:@"晒物选中icon"];
                break;
                
            case 2:
                _image = [UIImage imageNamed:@"商城icon"];
                _highlightedImge = [UIImage imageNamed:@"商城选中icon"];
                break;
                
            case 3:
                _image = [UIImage imageNamed:@"我的icon"];
                _highlightedImge = [UIImage imageNamed:@"我的选中icon"];
                break;
            default:
                break;
        }

        FootNavView *_btn = [[FootNavView alloc] initWithFrame:CGRectMake(kwidth/4 *i ,2+ self.view.height - 49, kwidth/4, 49) Image:_image highlightedImge:_highlightedImge];
        _btn.tag = i;
        [_btnArray addObject:_btn];
        if (i == 0) {
            [_btn setBtnSelect:YES];
        }
        [_btn setSelectFootNavBtn:^(FootNavView *footNavBtnSelf){
            [self pressTabbarSelect:footNavBtnSelf];
        }];
        
        [self.view addSubview:_btn];
        
        MOIReadHintView *_hint = [MOIReadHintView readHintViewWithTopLeftPoint:CGPointMake(_btn.width / 2 + 15, 2)];
        [_hint setNumberInt:0];
        [_hintArray addObject:_hint];
        [_btn addSubview:_hint];
    }

    [self pressTabbarSelect:[_btnArray objectAtIndex:0]];
}

- (void)pressTabbarSelect:(FootNavView *)_footBavView
{
    
    if (!self.viewControllers) {
        self.viewControllers = @[[self viewControllerWithTabtag:0],[self viewControllerWithTabtag:1],[self viewControllerWithTabtag:2],[self viewControllerWithTabtag:3]];
    }
    
    if (_selectViewNumber == _footBavView.tag) {
        [self btnHead];
    }else{
        _selectViewNumber = _footBavView.tag;
        
        MOIBaseViewController *_bvc = [self.viewControllers objectAtIndex:_selectViewNumber];
        if ([_bvc respondsToSelector:@selector(mainTabBarFirstSelect)]) {
            [_bvc mainTabBarFirstSelect];
        }
        self.selectedIndex = _footBavView.tag;

//        [LYUtils umengEventId:UmengEvenIdMainTabBarSelect setAttractive:^void(NSMutableDictionary *_attractive) {
//            NSString *_selectVC;
//            switch (self.selectedIndex) {
//                case 0:
//                    _selectVC = @"首页";
//                    break;
//                    
//                case 1:
//                    _selectVC = @"晒物";
//                    break;
//                    
//                case 2:
//                    _selectVC = @"商城";
//                    break;
//                    
//                case 3:
//                    _selectVC = @"我的";
//                    break;
//                    
//                default:
//                    _selectVC = @"其他位置页面";
//                    break;
//            }
//            [_attractive safeSetObject:_selectVC forKey:@"页面选择"];
//
//        }];
    }
    
    
    for (FootNavView *_fView in _btnArray) {
        if (_footBavView.tag != _fView.tag) {
            [_fView setBtnSelect:NO];
        }
        
        if (_footBavView.tag == _fView.tag) {
            _mainHeadView.hidden = _fView.tag != 0;
        }
    }
}


-(UIViewController*)viewControllerWithTabtag:(NSInteger)tag
{
    UIViewController *_viewController;
    switch (tag) {
        case 0:
        {
            _viewController = [[Tabbar1Controller alloc] init];
        }
            break;
            
        case 1:
        {
            
            _viewController = [[Tabbar2Controller alloc]init];
            
        }
            break;
            
        case 2:
        {
            _viewController = [[Tabbar3Controller alloc] init];
        }
            break;
            
        case 3:
        {
            _viewController = [[Tabbar4Controller alloc] init];
        }
            break;
            
        default:
            break;
    }
    
    return _viewController;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
