//
//  Tabbar3Controller.m
//  Tabbar
//
//  Created by apple on 16/5/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Tabbar3Controller.h"
#import "VideoPlayerController.h"
@interface Tabbar3Controller ()

@end

@implementation Tabbar3Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];

    [self.headNavigationView setTitle:@"商城"];

    UIButton *btrn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 60)];
    btrn.backgroundColor = [UIColor redColor];
    
    
    btrn.center = self.view.center;
    
    [btrn setTitle:@"点我啊" forState:UIControlStateNormal];
    
    [btrn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btrn];
    
}

- (void)btnClick{

    VideoPlayerController *videoVc = [[VideoPlayerController alloc]init];
    videoVc.videoURL = [NSURL URLWithString:@"http://baobab.wdjcdn.com/1456117847747a_x264.mp4"];
    
    [self.navigationController pushViewController:videoVc animated:YES];
    
    NSLog(@"去你妹的");

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
