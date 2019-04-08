//
//  NewGoodsTableViewCell2.m
//  MerShop
//
//  Created by mac on 2019/3/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "NewGoodsTableViewCell2.h"

@implementation NewGoodsTableViewCell2

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setAttributeText:(NSString *)string{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:string];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(string.length-1, 1)];
    self.leftLabel.attributedText = str;
}

@end
