//
//  XYPickerView.m
//  EpicLive
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 liyun. All rights reserved.
//

#import "XYPickerView.h"

#define PICKERVIEW_HEIGHT      200


@interface XYPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (retain, nonatomic) UIView *baseView;


@end

@implementation XYPickerView{

    NSInteger selectRow;

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(0, kheight-PICKERVIEW_HEIGHT, kwidth, PICKERVIEW_HEIGHT)];
        _baseView.backgroundColor = [UIColor grayColor];
        [self addSubview:_baseView];
        
        UIButton *btnOK = [[UIButton alloc] initWithFrame:CGRectMake(kwidth-50, 0, 40, 40)];
        [btnOK setTitle:@"确定" forState:UIControlStateNormal];
        [btnOK setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnOK addTarget:self action:@selector(pickerViewBtnOK:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView addSubview:btnOK];
        
        UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 40, 40)];
        [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnCancel addTarget:self action:@selector(pickerViewBtnCancel:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView addSubview:btnCancel];
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, kwidth, PICKERVIEW_HEIGHT-40)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        [_baseView addSubview:_pickerView];
        
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPickerView)];
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}


#pragma mark - UIPickerViewDataSource

//返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

//每列对应多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _arrPickerData.count;
}

//每行显示的数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _arrPickerData[row];
}


#pragma mark - UIPickerViewDelegate

//选中pickerView的某一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectRow = row;
}

#pragma mark - Private Menthods
//弹出pickerView
- (void)popPickerView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, -50, kwidth, kheight);
    }];
    
}
//取消pickerView
- (void)dismissPickerView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, kheight, kwidth, kheight);
    }];
}
//确定
- (void)pickerViewBtnOK:(id)sender
{
    if (self.selectBlock) {
        self.selectBlock(_arrPickerData[selectRow]);
    }
    [self dismissPickerView];
}

//取消
- (void)pickerViewBtnCancel:(id)sender
{
    if (self.selectBlock) {
        self.selectBlock(nil);
    }
    [self dismissPickerView];
    
}


@end
