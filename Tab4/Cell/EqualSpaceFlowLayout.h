//
//  EqualSpaceFlowLayout.h
//  Tabbar
//
//  Created by apple on 16/5/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EqualSpaceFlowLayout;

@protocol EqualSpaceFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>



@end

@interface EqualSpaceFlowLayout : UICollectionViewFlowLayout

@property (weak , nonatomic) id<EqualSpaceFlowLayoutDelegate>delegate;

@property (strong , nonatomic) NSMutableArray  *itemAttributes;


@end
