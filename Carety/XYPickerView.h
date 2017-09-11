//
//  XYPickerView.h
//  EpicLive
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 liyun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MyBasicBlock)(id result);

@interface XYPickerView : UIView

@property (retain, nonatomic) NSArray *arrPickerData;
@property (retain, nonatomic) UIPickerView *pickerView;

@property (nonatomic, copy) MyBasicBlock selectBlock;

- (void)popPickerView;


@end
