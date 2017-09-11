//
//  CopyLabel.m
//  Tabbar
//
//  Created by apple on 16/7/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CopyLabel.h"

@interface CopyLabel ()

@property (strong , nonatomic) UIMenuController *menu;

@end

@implementation CopyLabel{

    UILongPressGestureRecognizer *_touch;

}

-(BOOL)canBecomeFirstResponder {
    
    return YES;
}

// 可以响应的方法
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    return (action == @selector(copy:) || action == @selector(cut:));
    
}

//针对于响应方法的实现
-(void)copy:(id)sender {
    
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.text;
}
- (void)cut:(id)sender{

    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.text;
}

//UILabel默认是不接收事件的，我们需要自己添加touch事件
-(void)attachTapHandler {
    
    self.userInteractionEnabled = YES;
    _touch = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    _touch.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:_touch];
    
}

//绑定事件

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
//        [self attachTapHandler];
    }
    return self;
}

-(void)awakeFromNib {
    
    [super awakeFromNib];
    [self attachTapHandler];
}

-(void)handleTap:(UIGestureRecognizer*) recognizer {
    
    [self becomeFirstResponder];
    
    if ([recognizer isEqual:_touch]) {
    
        if (!self.menu.isMenuVisible) {
            [self.menu setMenuVisible:YES animated: YES];
        }
    }
}

- (UIMenuController *)menu{

    if (_menu == nil) {
        _menu = [UIMenuController sharedMenuController];
        [_menu setTargetRect:self.frame inView:self.superview];
    }
    return _menu;
}


@end
