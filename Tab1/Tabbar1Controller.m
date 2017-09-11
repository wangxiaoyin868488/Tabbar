//
//  Tabbar1Controller.m
//  Tabbar
//
//  Created by apple on 16/5/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Tabbar1Controller.h"
#import "CeshiViewCell.h"
#import "AdvertiseViewController.h"

#import "MOIPromptView.h"

@interface Tabbar1Controller ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation Tabbar1Controller{

    UITableView *_myTableView;

    MOIPromptView *_promptView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.headNavigationView setTitle:@"首页"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToAd) name:@"pushtoad" object:nil];

    [self setCells];
}
- (void)pushToAd {
    
    AdvertiseViewController *adVc = [[AdvertiseViewController alloc] init];
    adVc.adUrl = @"http://www.baidu.com";
    [self.navigationController pushViewController:adVc animated:YES];
    
}


- (void)mainTabBarSelectAgain{
    
    if (_myTableView) {
        [_myTableView setContentOffset:CGPointMake(0, 0) animated:YES];
        
        [self addPromptView:YES];
    }
}



- (void)addPromptView:(BOOL)isShow{
    
    if (isShow) {
        if (_promptView) {
            [_promptView removeAllSubviews];
            [_promptView removeFromSuperview];
            _promptView = nil;
        }
        
        _promptView = [MOIPromptView promptView];
        _promptView.frame = CGRectMake(0, 0, kwidth, kheight);
        [_promptView setPromptViewWithMisstopic:15 missdate:8];
        
        [_promptView setRightNowBtnClick:^(NSDictionary *dict) {
            
//            MainTopicListViewController *_listView = [[MainTopicListViewController alloc] init];
//            _listView.titleStr = @"错过的毒文";
//            _listView.isMiss = YES;
//            [[MainTabBarViewController sharedInstance].navigationController pushViewController:_listView animated:YES];
            
        }];
        
        [_promptView willShowSelfInView:[UIApplication sharedApplication].keyWindow];
        
    }
}

- (void)setCells{

    
    _myTableView = [[UITableView alloc]init];
    _myTableView.backgroundColor = [UIColor greenColor];
    _myTableView.frame = CGRectMake(0, 65, kwidth, kheight - 114);
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    
    
    [_myTableView registerNib:[UINib nibWithNibName:@"CeshiViewCell" bundle:nil] forCellReuseIdentifier:@"CeshiViewCell"];
    [_myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
//    [self.view insertSubview:_myTableView atIndex:0];
    
    [self.view addSubview:_myTableView];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 10;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    CeshiViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CeshiViewCell"];
    
    cell.testLabel.text = [NSString stringWithFormat:@"这是首页的第%zd行测试",indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case 0:{
            
            NSLog(@"0");
            
        }
            break;
        case 1:{
            NSLog(@"1");
        }
            
            break;

        case 2:{
            NSLog(@"2");
        }
            
            break;
        case 3:{
            NSLog(@"3");
        }
            
            break;
        case 4:{
            NSLog(@"4");
        }
            
            break;
        default:
            break;
    }



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
