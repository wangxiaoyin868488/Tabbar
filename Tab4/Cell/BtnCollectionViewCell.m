//
//  BtnCollectionViewCell.m
//  EpicLive
//
//  Created by apple on 16/5/23.
//  Copyright © 2016年 liyun. All rights reserved.
//

#import "BtnCollectionViewCell.h"


@implementation BtnCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.userInteractionEnabled = YES;
    
    [_tagLabel.layer setMasksToBounds:YES];
    [_tagLabel.layer setCornerRadius:15];
    _tagLabel.layer.borderColor = SetColorWith(94, 94, 94).CGColor;
    _tagLabel.layer.borderWidth = 1/[[UIScreen mainScreen]scale];

}

- (void)setBtnCollectionViewCellWithDict:(NSDictionary *)dict{
    
//    _tagLabel.text = [dict safeObjectForKey:@"name"];

}

- (void)setBtnCollectionViewCellWithStr:(NSString *)str{
    _tagLabel.text = str;
}


@end
