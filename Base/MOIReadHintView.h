//
//  MOIReadHintView.h
//  CatClaws
//
//  Created by moi on 14-12-6.
//  Copyright (c) 2014年 MOI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MOIReadHintView : UIView

+ (MOIReadHintView *)readHintViewWithCenterPoint:(CGPoint)_point;
+ (MOIReadHintView *)readHintViewWithTopLeftPoint:(CGPoint)_point;

@property (nonatomic) NSInteger numberInt;
@property (nonatomic) __block BOOL isCanPoint;
@property (nonatomic) BOOL isShine;

@end
