//
//  CopyLabelController.m
//  Tabbar
//
//  Created by apple on 16/7/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CopyLabelController.h"
#import "CopyLabel.h"

@interface CopyLabelController ()

@property (weak, nonatomic) IBOutlet CopyLabel *labelCopy;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation CopyLabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.userInteractionEnabled = YES;

    
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
