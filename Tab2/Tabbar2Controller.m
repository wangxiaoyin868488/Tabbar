//
//  Tabbar2Controller.m
//  Tabbar
//
//  Created by apple on 16/5/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Tabbar2Controller.h"
#import "Tabbar2ViewCell.h"
#import "PlayerViewController.h"
@interface Tabbar2Controller ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation Tabbar2Controller{

    UITableView *_myTableView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];

    [self.headNavigationView setTitle:@"晒物"];
    
    
    [self setCells];
    
    
}


- (void)setCells{
    
    _myTableView = [[UITableView alloc]init];
    _myTableView.frame = CGRectMake(0, 65, kwidth, kheight - 114);
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    
    [_myTableView registerNib:[UINib nibWithNibName:@"Tabbar2ViewCell" bundle:nil] forCellReuseIdentifier:@"Tabbar2ViewCell"];
    
    [_myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.view addSubview:_myTableView];
    
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kwidth)];
    headView.backgroundColor = [UIColor grayColor];
    
    [_myTableView setTableHeaderView:headView];
    
    
   
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 10;
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    Tabbar2ViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Tabbar2ViewCell"];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 120;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    PlayerViewController *playVc = [[PlayerViewController alloc]init];
    
    [self.navigationController pushViewController:playVc animated:YES];
    
    
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
