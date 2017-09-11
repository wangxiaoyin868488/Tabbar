//
//  VideoPlayerController.m
//  Tabbar
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "VideoPlayerController.h"
#import "XYPlayerView.h"
#import "XYBrightnessView.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "AFNetworkReachabilityManager.h"

#import "CeshiViewCell.h"

#import "Masonry.h"
#import "ZFPlayerView.h"
#import "ZFBrightnessView.h"
@interface VideoPlayerController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong , nonatomic) XYPlayerView *playerView;

@end

@implementation VideoPlayerController{

    UITableView *_myTableView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [XYBrightnessView sharedBrightnesView];
    
    [self setTableView];
    [self updatePlayerView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 40, 20)];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor blackColor];
    [backBtn addTarget:self action:@selector(backhahaha) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
}
- (void)backhahaha{

    [self.navigationController popViewControllerAnimated:YES];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setAfn];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_playerView.player pause];
    _playerView.maskView.startBtn.selected = NO;
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

-(void)dealloc
{
    [_playerView.timer invalidate];
    _playerView.timer = nil;
    //NSLog(@"%@释放了",self.class);
    [_playerView cancelAutoFadeOutControlBar];}


#pragma  mark ----- 判断网络模式
- (void)setAfn{
    
    __weak VideoPlayerController *_weakSelf = self;
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi://WiFi
                
                if (_weakSelf.videoURL) {
                    [_weakSelf.playerView.player play];
                    _weakSelf.playerView.maskView.startBtn.selected = YES;
                }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:{//自带网络
                
                UIAlertView *_emptyMessage = [[UIAlertView alloc] initWithTitle:@"流量使用提示" message:@"继续播放，运营商将收取流量费用" delegate:_weakSelf cancelButtonTitle:@"停止播放" otherButtonTitles:@"继续播放", nil];
                [_emptyMessage show];
            }
                break;
            case AFNetworkReachabilityStatusUnknown:{//未知网络
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:{//断网
            }
                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];
    
}

- (void)updatePlayerView{
    [_playerView removeFromSuperview];
    _playerView = [XYPlayerView setupXYPlayer];
    
    if (_videoURL) {
        [self updatePlayerURL];
    }
    
    _playerView.frame = CGRectMake(0, 50, kwidth, kwidth*9/16);
    [self.view addSubview:_playerView];
    
}
-(void)updatePlayerURL{
    _playerView.videoURL = _videoURL;
    
//    [self setAfn];
    
}

- (void)setTableView{

    _myTableView = [[UITableView alloc]init];
    _myTableView.frame = CGRectMake(0, 50, kwidth, kheight - 50);

    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kwidth*9/16)];
    headView.backgroundColor = [UIColor blackColor];
    
    [_myTableView setTableHeaderView:headView];
    
    //IOS7让人蛋疼的地方，不设置为false就会自动有一个空白
    self.automaticallyAdjustsScrollViewInsets = false;

    [_myTableView registerNib:[UINib nibWithNibName:@"CeshiViewCell" bundle:nil] forCellReuseIdentifier:@"CeshiViewCell"];
    [_myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    [self.view addSubview:_myTableView];
    [self.view insertSubview:_myTableView atIndex:0];
    
}


//   根据tableView的contentoffset改变播放view的大小

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

//    if (scrollView.contentOffset.y > 0) {
//        if (scrollView.contentOffset.y < kwidth/2) {
//            _playerView.frame = CGRectMake(0, 50, kwidth, kwidth - scrollView.contentOffset.y);
//        }else{
//            _playerView.frame = CGRectMake(0, 50, kwidth, kwidth/2);
//        }
//    }else{
//        _playerView.frame = CGRectMake(0, 50, kwidth, kwidth);
//    }
    
    //一行就可以了，真牛逼
    _playerView.frame = CGRectMake(0, 50, kwidth, kwidth - MIN( MAX(0,scrollView.contentOffset.y), kwidth / 2));
    
}
#pragma mark ---- tableview代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 8;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CeshiViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CeshiViewCell"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 120;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    

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
