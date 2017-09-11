//
//  BtnCollectionViewCell.h
//  EpicLive
//
//  Created by apple on 16/5/23.
//  Copyright © 2016年 liyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BtnCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

- (void)setBtnCollectionViewCellWithDict:(NSDictionary *)dict;

- (void)setBtnCollectionViewCellWithStr:(NSString *)str;




@end
